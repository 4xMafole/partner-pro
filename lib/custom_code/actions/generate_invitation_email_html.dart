// Automatic FlutterFlow imports
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
String generateInvitationEmailHtml(
  String inviterName,
  String signUpUrl,
  String invitationType, // 'buyer' or 'agent'
  String logoUrl, // URL for the logo image
  String inviterFullName, // Full name for signature
  String? inviterMLS, // MLS number (optional)
  String? inviterContact, // Contact info (optional)
  String? brokerageName, // Brokerage name (optional)
  String? inviteeFirstName,
) {
  // Determine content based on invitation type
  String subject;
  String greeting;
  String mainContent;
  String buttonText;
  String signature;

  if (invitationType.toLowerCase() == 'buyer') {
    subject =
        "Use My Application to Make Offers on Properties with Just a Click – You're Invited!";
    greeting = "Hi $inviteeFirstName,";
    mainContent = '''
        You deserve a home buying experience that feels effortless, modern, and elevated. That's why I've set you up with VIP access to <span class="app-name">PartnerPro</span> — your personal real estate concierge in app form.
        <br><br>
        With PartnerPro, you'll enjoy:
        <ul class="benefits-list">
            <li>Instantly searching properties that fit your lifestyle</li>
            <li>Booking private showings on your schedule</li>
            <li>Writing offers seamlessly with my support</li>
            <li>A dedicated transaction coordinator to keep every detail organized and smooth</li>
        </ul>
        <br>
        This isn't just another real estate app. It's a tool I provide exclusively to my VIP clients so you can buy smarter, faster, and with more confidence.
        <br><br>
        Click below to activate your PartnerPro profile today:
    ''';
    buttonText = "Activate Your Account";
    // Build signature components dynamically
    List<String> signatureLines = [];
    signatureLines.add('<strong>$inviterFullName</strong>');

    if (inviterMLS != null && inviterMLS.isNotEmpty) {
      signatureLines.add('Licensed Realtor<br>MLS# $inviterMLS');
    }

    if (inviterContact != null && inviterContact.isNotEmpty) {
      signatureLines.add(inviterContact);
    }

    if (brokerageName != null && brokerageName.isNotEmpty) {
      signatureLines.add(brokerageName);
    }

    signature = '''
        <div class="signature">
            <p>I'll be right by your side every step of the way to make your journey from search to closing as seamless as possible.</p>
            <br>
            <p><strong>Warmly,</strong></p>
            <p>${signatureLines.join('<br>')}</p>
        </div>
    ''';
  } else {
    subject = "You're Invited to Join PartnerPro";
    greeting = "Hi,";
    mainContent = '''
        Your colleague, <span class="inviter-highlight">$inviterName</span>, thinks you'd love using <span class="app-name">PartnerPro</span> to automate your real estate business and is referring you to the platform.
        <br><br>
        Get started by creating your agent account.
    ''';
    buttonText = "Create My Account";
    signature = '''
        <div class="signature">
            <p>This invitation was sent by $inviterName through PartnerPro.</p>
        </div>
    ''';
  }

  return '''
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>$subject</title>
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            line-height: 1.6;
            color: #333;
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            background-color: #f8f9fa;
        }
        .container {
            background-color: #ffffff;
            border-radius: 8px;
            padding: 40px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .header {
            text-align: center;
            margin-bottom: 30px;
        }
        .logo-img {
            max-width: 200px;
            height: auto;
            margin-bottom: 20px;
        }
        .logo-text {
            font-size: 24px;
            font-weight: bold;
            color: #D0B27D;
            margin-bottom: 10px;
        }
        .greeting {
            font-size: 18px;
            margin-bottom: 20px;
            color: #1f2937;
        }
        .content {
            font-size: 16px;
            margin-bottom: 30px;
            color: #4b5563;
        }
        .benefits-list {
            margin: 15px 0;
            padding-left: 20px;
        }
        .benefits-list li {
            margin-bottom: 8px;
            color: #4b5563;
        }
        .cta-button {
            display: inline-block;
            background-color: #D0B27D;
            color: #ffffff !important;
            text-decoration: none;
            padding: 14px 28px;
            border-radius: 6px;
            font-weight: 600;
            font-size: 16px;
            text-align: center;
            transition: background-color 0.2s ease;
        }
        .cta-button:hover {
            background-color: #c4a66d;
        }
        .cta-container {
            text-align: center;
            margin: 30px 0;
        }
        .signature {
            margin-top: 30px;
            font-size: 16px;
            color: #4b5563;
        }
        .footer {
            margin-top: 40px;
            padding-top: 20px;
            border-top: 1px solid #e5e7eb;
            font-size: 14px;
            color: #6b7280;
            text-align: center;
        }
        .inviter-highlight {
            font-weight: 600;
            color: #D0B27D;
        }
        .app-name {
            font-weight: 600;
            color: #D0B27D;
        }
        @media (max-width: 600px) {
            body {
                padding: 10px;
            }
            .container {
                padding: 20px;
            }
            .cta-button {
                display: block;
                width: 100%;
                box-sizing: border-box;
            }
            .logo-img {
                max-width: 150px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            ${logoUrl.isNotEmpty ? '<img src="$logoUrl" alt="PartnerPro Logo" class="logo-img">' : '<div class="logo-text">PartnerPro</div>'}
        </div>
        
        <div class="greeting">
            $greeting
        </div>
        
        <div class="content">
            $mainContent
        </div>
        
        <div class="cta-container">
            <a href="$signUpUrl" class="cta-button">$buttonText</a>
        </div>
        
        $signature
        
        <div class="footer">
            <p>If you didn't expect this invitation, you can safely ignore this email.</p>
        </div>
    </div>
</body>
</html>
''';
}
