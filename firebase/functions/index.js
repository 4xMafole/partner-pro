const functions = require("firebase-functions");
const admin = require("firebase-admin");
const axios = require("axios").default;
const Stripe = require("stripe");
admin.initializeApp();

const kFcmTokensCollection = "fcm_tokens";
const kPushNotificationsCollection = "ff_push_notifications";
const kUserPushNotificationsCollection = "ff_user_push_notifications";
const firestore = admin.firestore();

const kPushNotificationRuntimeOpts = {
  timeoutSeconds: 540,
  memory: "2GB",
};

const stripeSecret =
  (functions.config().stripe && functions.config().stripe.secret) || "";
const stripe = stripeSecret
  ? new Stripe(stripeSecret, { apiVersion: "2020-08-27" })
  : null;

function getShowingProvider() {
  const showamiCfg = functions.config().showami || {};
  const webhook = showamiCfg.dispatch_webhook || "";

  return {
    async dispatchShowing({ showingId, payload }) {
      if (!webhook) {
        return {
          provider: "showami_stub",
          providerDispatchId: `stub_${showingId}`,
          providerStatus: "queued_no_webhook",
        };
      }

      const response = await axios.post(webhook, payload, {
        headers: { "Content-Type": "application/json" },
      });

      return {
        provider: "showami",
        providerDispatchId:
          response.data?.dispatchId || response.data?.id || showingId,
        providerStatus: "dispatched",
      };
    },
  };
}

exports.addFcmToken = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    return "Failed: Unauthenticated calls are not allowed.";
  }
  const userDocPath = data.userDocPath;
  const fcmToken = data.fcmToken;
  const deviceType = data.deviceType;
  if (
    typeof userDocPath === "undefined" ||
    typeof fcmToken === "undefined" ||
    typeof deviceType === "undefined" ||
    userDocPath.split("/").length <= 1 ||
    fcmToken.length === 0 ||
    deviceType.length === 0
  ) {
    return "Invalid arguments encoutered when adding FCM token.";
  }
  if (context.auth.uid != userDocPath.split("/")[1]) {
    return "Failed: Authenticated user doesn't match user provided.";
  }
  const existingTokens = await firestore
    .collectionGroup(kFcmTokensCollection)
    .where("fcm_token", "==", fcmToken)
    .get();
  var userAlreadyHasToken = false;
  for (var doc of existingTokens.docs) {
    const user = doc.ref.parent.parent;
    if (user.path != userDocPath) {
      // Should never have the same FCM token associated with multiple users.
      await doc.ref.delete();
    } else {
      userAlreadyHasToken = true;
    }
  }
  if (userAlreadyHasToken) {
    return "FCM token already exists for this user. Ignoring...";
  }
  await getUserFcmTokensCollection(userDocPath).doc().set({
    fcm_token: fcmToken,
    device_type: deviceType,
    created_at: admin.firestore.FieldValue.serverTimestamp(),
  });
  return "Successfully added FCM token!";
});

exports.sendPushNotificationsTrigger = functions
  .runWith(kPushNotificationRuntimeOpts)
  .firestore.document(`${kPushNotificationsCollection}/{id}`)
  .onCreate(async (snapshot, _) => {
    try {
      // Ignore scheduled push notifications on create
      const scheduledTime = snapshot.data().scheduled_time || "";
      if (scheduledTime) {
        return;
      }

      await sendPushNotifications(snapshot);
    } catch (e) {
      console.log(`Error: ${e}`);
      await snapshot.ref.update({ status: "failed", error: `${e}` });
    }
  });

exports.sendUserPushNotificationsTrigger = functions
  .runWith(kPushNotificationRuntimeOpts)
  .firestore.document(`${kUserPushNotificationsCollection}/{id}`)
  .onCreate(async (snapshot, _) => {
    try {
      // Ignore scheduled push notifications on create
      const scheduledTime = snapshot.data().scheduled_time || "";
      if (scheduledTime) {
        return;
      }

      // Don't let user-triggered notifications to be sent to all users.
      const userRefsStr = snapshot.data().user_refs || "";
      if (userRefsStr) {
        await sendPushNotifications(snapshot);
      }
    } catch (e) {
      console.log(`Error: ${e}`);
      await snapshot.ref.update({ status: "failed", error: `${e}` });
    }
  });

async function sendPushNotifications(snapshot) {
  const notificationData = snapshot.data();
  const title = notificationData.notification_title || "";
  const body = notificationData.notification_text || "";
  const imageUrl = notificationData.notification_image_url || "";
  const sound = notificationData.notification_sound || "";
  const parameterData = notificationData.parameter_data || "";
  const targetAudience = notificationData.target_audience || "";
  const initialPageName = notificationData.initial_page_name || "";
  const userRefsStr = notificationData.user_refs || "";
  const batchIndex = notificationData.batch_index || 0;
  const numBatches = notificationData.num_batches || 0;
  const status = notificationData.status || "";

  if (status !== "" && status !== "started") {
    console.log(`Already processed ${snapshot.ref.path}. Skipping...`);
    return;
  }

  if (title === "" || body === "") {
    await snapshot.ref.update({ status: "failed" });
    return;
  }

  const userRefs = userRefsStr === "" ? [] : userRefsStr.trim().split(",");
  var tokens = new Set();
  if (userRefsStr) {
    for (var userRef of userRefs) {
      const userTokens = await firestore
        .doc(userRef)
        .collection(kFcmTokensCollection)
        .get();
      userTokens.docs.forEach((token) => {
        if (typeof token.data().fcm_token !== undefined) {
          tokens.add(token.data().fcm_token);
        }
      });
    }
  } else {
    var userTokensQuery = firestore.collectionGroup(kFcmTokensCollection);
    // Handle batched push notifications by splitting tokens up by document
    // id.
    if (numBatches > 0) {
      userTokensQuery = userTokensQuery
        .orderBy(admin.firestore.FieldPath.documentId())
        .startAt(getDocIdBound(batchIndex, numBatches))
        .endBefore(getDocIdBound(batchIndex + 1, numBatches));
    }
    const userTokens = await userTokensQuery.get();
    userTokens.docs.forEach((token) => {
      const data = token.data();
      const audienceMatches =
        targetAudience === "All" || data.device_type === targetAudience;
      if (audienceMatches && typeof data.fcm_token !== undefined) {
        tokens.add(data.fcm_token);
      }
    });
  }

  const tokensArr = Array.from(tokens);
  var messageBatches = [];
  for (let i = 0; i < tokensArr.length; i += 500) {
    const tokensBatch = tokensArr.slice(i, Math.min(i + 500, tokensArr.length));
    const messages = {
      notification: {
        title,
        body,
        ...(imageUrl && { imageUrl: imageUrl }),
      },
      data: {
        initialPageName,
        parameterData,
      },
      android: {
        notification: {
          ...(sound && { sound: sound }),
        },
      },
      apns: {
        payload: {
          aps: {
            ...(sound && { sound: sound }),
          },
        },
      },
      tokens: tokensBatch,
    };
    messageBatches.push(messages);
  }

  var numSent = 0;
  await Promise.all(
    messageBatches.map(async (messages) => {
      const response = await admin.messaging().sendEachForMulticast(messages);
      numSent += response.successCount;
    }),
  );

  await snapshot.ref.update({ status: "succeeded", num_sent: numSent });
}

function getUserFcmTokensCollection(userDocPath) {
  return firestore.doc(userDocPath).collection(kFcmTokensCollection);
}

function getDocIdBound(index, numBatches) {
  if (index <= 0) {
    return "users/(";
  }
  if (index >= numBatches) {
    return "users/}";
  }
  const numUidChars = 62;
  const twoCharOptions = Math.pow(numUidChars, 2);

  var twoCharIdx = (index * twoCharOptions) / numBatches;
  var firstCharIdx = Math.floor(twoCharIdx / numUidChars);
  var secondCharIdx = Math.floor(twoCharIdx % numUidChars);
  const firstChar = getCharForIndex(firstCharIdx);
  const secondChar = getCharForIndex(secondCharIdx);
  return "users/" + firstChar + secondChar;
}

function getCharForIndex(charIdx) {
  if (charIdx < 10) {
    return String.fromCharCode(charIdx + "0".charCodeAt(0));
  } else if (charIdx < 36) {
    return String.fromCharCode("A".charCodeAt(0) + charIdx - 10);
  } else {
    return String.fromCharCode("a".charCodeAt(0) + charIdx - 36);
  }
}
exports.createShowingPaymentIntent = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "Authentication is required.",
      );
    }
    if (!stripe) {
      throw new functions.https.HttpsError(
        "failed-precondition",
        "Stripe is not configured. Set functions config: stripe.secret",
      );
    }

    const showingId = (data.showingId || "").toString();
    const agentId = (data.agentId || "").toString();
    const amountCents = Number(data.amountCents || 5000);
    const currency = (data.currency || "usd").toString().toLowerCase();

    if (!showingId || !agentId || !Number.isFinite(amountCents)) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "showingId, agentId, and amountCents are required.",
      );
    }

    const customerRef = firestore.collection("customers").doc(agentId);
    const customerSnap = await customerRef.get();
    const customerData = customerSnap.exists ? customerSnap.data() || {} : {};
    let stripeCustomerId = customerData.stripeCustomerId || customerData.customer_id || "";

    if (!stripeCustomerId) {
      const userSnap = await firestore.collection("users").doc(agentId).get();
      const userData = userSnap.exists ? userSnap.data() || {} : {};
      const customer = await stripe.customers.create({
        email: userData.email || undefined,
        name: userData.displayName || userData.firstName || undefined,
        metadata: { uid: agentId },
      });
      stripeCustomerId = customer.id;
      await customerRef.set(
        {
          stripeCustomerId,
          uid: agentId,
          updated_at: admin.firestore.FieldValue.serverTimestamp(),
        },
        { merge: true },
      );
    }

    const paymentIntent = await stripe.paymentIntents.create({
      amount: amountCents,
      currency,
      customer: stripeCustomerId,
      capture_method: "manual",
      metadata: {
        showingId,
        agentId,
        flow: "showing_fee_authorization",
      },
    });

    await firestore.collection("showings").doc(showingId).set(
      {
        payment_intent_id: paymentIntent.id,
        payment_status: "authorization_requested",
        payment_amount_cents: amountCents,
        updated_at: admin.firestore.FieldValue.serverTimestamp(),
      },
      { merge: true },
    );

    return {
      clientSecret: paymentIntent.client_secret,
      paymentIntentId: paymentIntent.id,
      customerId: stripeCustomerId,
    };
  },
);

exports.onShowingApprovedDispatch = functions.firestore
  .document("showings/{showingId}")
  .onUpdate(async (change, context) => {
    const before = change.before.data() || {};
    const after = change.after.data() || {};

    if ((before.status || "") === (after.status || "")) {
      return null;
    }

    if ((after.status || "") !== "agent_approved") {
      return null;
    }

    // Enforce policy: authorization before dispatch.
    const paymentStatus = (after.payment_status || "").toString();
    if (!["authorized", "captured"].includes(paymentStatus)) {
      await change.after.ref.set(
        {
          provider_status: "awaiting_payment_authorization",
          updated_at: admin.firestore.FieldValue.serverTimestamp(),
        },
        { merge: true },
      );
      return null;
    }

    const provider = getShowingProvider();
    const dispatchResult = await provider.dispatchShowing({
      showingId: context.params.showingId,
      payload: {
        showingId: context.params.showingId,
        propertyId: after.property_id || "",
        buyerId: after.user_id || "",
        agentId: after.agent_id || "",
        date: after.date || "",
        time: after.time || "",
      },
    });

    await change.after.ref.set(
      {
        status: "dispatched",
        provider: dispatchResult.provider,
        provider_dispatch_id: dispatchResult.providerDispatchId,
        provider_status: dispatchResult.providerStatus,
        dispatched_at: admin.firestore.FieldValue.serverTimestamp(),
        updated_at: admin.firestore.FieldValue.serverTimestamp(),
      },
      { merge: true },
    );

    return null;
  });

exports.onUserDeleted = functions.auth.user().onDelete(async (user) => {
  let firestore = admin.firestore();
  let userRef = firestore.doc("users/" + user.uid);
  await firestore.collection("users").doc(user.uid).delete();
});
