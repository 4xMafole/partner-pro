---
title: Setup - Firebase
description: Firebase project configuration for iOS and Android
order: 3
---

# Firebase Setup

## Prerequisites

- Firebase CLI installed (`npm install -g firebase-tools`)
- Firebase project created at [Firebase Console](https://console.firebase.google.com)

## Project Configuration

Project ID: `partnerpro-dev`

### Android

1. Go to Firebase Console -> Project settings -> Add app -> Android
2. Package name: `com.automaterealestate.partnerpro.dev`
3. Download `google-services.json` to `android/app/`
4. This file is gitignored  every developer must download their own copy

### iOS

1. Go to Firebase Console -> Project settings -> Add app -> iOS
2. Bundle ID: `com.automaterealestate.partnerpro.dev`
3. Download `GoogleService-Info.plist` to `ios/Runner/`
4. This file is gitignored  every developer must download their own copy

### Web

Web config is injected via environment variables (see `SETUP_API_KEYS.md`).

## Firebase Services Used

- **Authentication**: Email/password, Google, Facebook, Apple sign-in
- **Cloud Firestore**: All data storage (users, properties, offers, documents, agents)
- **Cloud Storage**: File uploads (images, PDFs, signatures)
- **Cloud Messaging (FCM)**: Push notification delivery
- **Cloud Functions**: Server-side logic (notifications, user deletion cleanup)

## Firestore Security Rules

Located at `firebase/firestore.rules`. Deploy with:

```bash
cd firebase
firebase deploy --only firestore:rules
```

## Cloud Functions

Located at `firebase/functions/index.js`. Deploy with:

```bash
cd firebase
firebase deploy --only functions
```
