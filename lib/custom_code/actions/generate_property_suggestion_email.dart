// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

/// Generate email notification when an agent suggests a property to a buyer
///
/// Parameters:
/// - propertyData: PropertyDataClass document from Firestore
/// - buyerName: Name of the buyer receiving the suggestion
/// - agentName: Name of the agent making the suggestion
/// - agentPhone: Agent's phone number
/// - agentEmail: Agent's email address
/// - logoUrl: Company logo URL
/// - propertyUrl: Deep link to view the property in the app

String generatePropertySuggestionEmail(
  PropertyDataClassStruct propertyData,
  String buyerName,
  String agentName,
  String agentPhone,
  String agentEmail,
  String logoUrl,
  String propertyUrl,
) {
  // Get address data
  final address = propertyData.address;

  // Format full address
  String fullAddress = '';
  if (address.streetNumber.isNotEmpty) {
    fullAddress += '${address.streetNumber} ';
  }
  if (address.streetName.isNotEmpty) {
    fullAddress += '${address.streetName}, ';
  }
  if (address.city.isNotEmpty) {
    fullAddress += '${address.city}, ';
  }
  if (address.state.isNotEmpty) {
    fullAddress += '${address.state} ';
  }
  if (address.zip.isNotEmpty) {
    fullAddress += address.zip;
  }
  fullAddress = fullAddress.trim();
  if (fullAddress.isEmpty) {
    fullAddress = propertyData.propertyName;
  }

  // Format currency
  String formatCurrency(int? amount) {
    if (amount == null) return '\$0';
    return '\$${amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
  }

  // Get property details
  final price = formatCurrency(propertyData.listPrice);
  final beds = propertyData.bedrooms.toString() ?? 'N/A';
  final baths = propertyData.bathrooms.toString() ?? 'N/A';
  final sqft = propertyData.squareFootage;
  final yearBuilt = propertyData.yearBuilt.toString() ?? '';
  final propertyType = propertyData.propertyType ?? 'Home';
  final lotSize = propertyData.lotSize ?? '';

  // Format property image URL (get first image from media list)
  final propertyImage =
      (propertyData.media.isNotEmpty) ? propertyData.media.first : '';

  // Format square footage with commas
  String formattedSqft = '';
  if (sqft != null) {
    formattedSqft = sqft.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }

  return '''
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>New Property Suggestion - $fullAddress</title>
    <style>
body {
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
    line-height: 1.6;
    color: #333;
    margin: 0;
    padding: 0;
    background-color: #f8f9fa;
}
.email-wrapper {
    width: 100%;
    background-color: #f8f9fa;
    padding: 20px 0;
}
.email-container {
    max-width: 600px;
    margin: 0 auto;
    background-color: #f8f9fa;
}
.container {
    background-color: #ffffff;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    margin: 0 20px;
}
        .header {
            text-align: center;
            padding: 30px 40px 20px;
            background: linear-gradient(135deg, #D0B27D 0%, #c4a66d 100%);
            color: white;
        }
        .logo-img {
            max-width: 150px;
            height: auto;
            margin-bottom: 15px;
            background-color: white;
            padding: 10px;
            border-radius: 8px;
        }
        .logo-text {
            font-size: 26px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .title {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 5px;
        }
        .status-badge {
            display: inline-block;
            background-color: rgba(255, 255, 255, 0.2);
            color: white;
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 600;
            margin-left: 10px;
        }
        .subtitle {
            font-size: 15px;
            opacity: 0.95;
            margin-top: 8px;
        }
        .content {
            padding: 40px;
        }
        .greeting {
            font-size: 18px;
            color: #1f2937;
            font-weight: 600;
            margin-bottom: 15px;
        }
        .message {
            font-size: 16px;
            color: #4b5563;
            margin-bottom: 25px;
            line-height: 1.8;
        }
        .property-image {
            width: 100%;
            height: 300px;
            object-fit: cover;
            border-radius: 8px;
            margin: 20px 0;
        }
        .property-image-placeholder {
            width: 100%;
            height: 300px;
            background: linear-gradient(135deg, #e5e7eb 0%, #d1d5db 100%);
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #6b7280;
            font-size: 18px;
            margin: 20px 0;
        }
        .highlight-box {
            background: linear-gradient(135deg, #fef3c7 0%, #fde68a 100%);
            border-left: 4px solid #D0B27D;
            padding: 25px;
            margin: 25px 0;
            border-radius: 8px;
        }
        .property-address {
            font-size: 20px;
            font-weight: 700;
            color: #1f2937;
            margin-bottom: 15px;
            line-height: 1.3;
        }
        .property-price {
            font-size: 32px;
            font-weight: 800;
            color: #D0B27D;
            margin-bottom: 15px;
        }
        .property-stats {
            display: flex;
            justify-content: space-around;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 2px solid rgba(208, 178, 125, 0.3);
        }
        .stat-item {
            text-align: center;
        }
        .stat-value {
            font-size: 24px;
            font-weight: bold;
            color: #1f2937;
            display: block;
        }
        .stat-label {
            font-size: 13px;
            color: #6b7280;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-top: 5px;
        }
        .key-info {
            background-color: #f9fafb;
            padding: 25px;
            border-radius: 8px;
            margin: 25px 0;
        }
        .section-title {
            font-size: 17px;
            font-weight: 600;
            color: #1f2937;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
        }
        .info-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }
        .info-item {
            padding: 12px;
            background-color: white;
            border-radius: 6px;
            border: 1px solid #e5e7eb;
        }
        .info-label {
            font-size: 12px;
            color: #6b7280;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 5px;
        }
        .info-value {
            font-size: 15px;
            color: #1f2937;
            font-weight: 600;
        }
        .cta-button {
            display: inline-block;
            background-color: #D0B27D;
            color: #ffffff !important;
            text-decoration: none;
            padding: 16px 40px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 17px;
            text-align: center;
            transition: all 0.2s ease;
            margin: 25px 0;
            box-shadow: 0 4px 6px rgba(208, 178, 125, 0.3);
        }
        .cta-button:hover {
            background-color: #c4a66d;
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(208, 178, 125, 0.4);
        }
        .cta-container {
            text-align: center;
            margin: 30px 0;
        }
        .cta-subtitle {
            font-size: 14px;
            color: #6b7280;
            margin-top: 10px;
        }
        .contact-section {
            margin-top: 30px;
            padding-top: 30px;
            border-top: 2px solid #e5e7eb;
        }
        .contact-box {
            background-color: #f9fafb;
            padding: 25px;
            border-radius: 8px;
            margin-top: 15px;
        }
        .contact-title {
            font-size: 16px;
            font-weight: 600;
            color: #1f2937;
            margin-bottom: 12px;
            display: flex;
            align-items: center;
        }
        .contact-detail {
            color: #4b5563;
            font-size: 15px;
            margin: 8px 0;
            display: flex;
            align-items: center;
        }
        .contact-detail strong {
            color: #1f2937;
        }
        .footer {
            background-color: #f9fafb;
            padding: 30px 40px;
            border-top: 1px solid #e5e7eb;
            font-size: 13px;
            color: #6b7280;
            text-align: center;
        }
        .footer-note {
            margin: 8px 0;
        }
        .divider {
            height: 2px;
            background: linear-gradient(90deg, transparent, #D0B27D, transparent);
            margin: 30px 0;
        }
        @media (max-width: 600px) {
    .email-wrapper {
        padding: 10px 0;
    }
    .container {
        margin: 0 10px;
    }
            .content {
                padding: 25px;
            }
            .property-stats {
                flex-direction: column;
                gap: 15px;
            }
            .info-grid {
                grid-template-columns: 1fr;
            }
            .logo-img {
                max-width: 120px;
            }
            .property-price {
                font-size: 28px;
            }
        }
    </style>
</head>
<body>
    <div class="email-wrapper">
        <div class="email-container">
            <div class="container">
        <!-- Header -->
        <div class="header">
            ${logoUrl.isNotEmpty ? '<img src="$logoUrl" alt="PartnerPro Logo" class="logo-img">' : '<div class="logo-text">PartnerPro</div>'}
            <div class="title">
                💡 New Property Suggestion
                <span class="status-badge">NEW</span>
            </div>
            <div class="subtitle">Handpicked by $agentName</div>
        </div>

        <!-- Content -->
        <div class="content">
            <div class="greeting">Hi $buyerName! 👋</div>
            <div class="message">
                I found a property that matches what you're looking for and wanted to share it with you right away. 
                I think this could be a great fit based on your criteria. Take a look at the details below!
            </div>

            <!-- Property Image -->
            ${propertyImage.isNotEmpty ? '<img src="$propertyImage" alt="Property" class="property-image">' : '<div class="property-image-placeholder">🏡 Property Image</div>'}

            <!-- Property Highlight -->
            <div class="highlight-box">
                <div class="property-address">$fullAddress</div>
                <div class="property-price">$price</div>
                
                <div class="property-stats">
                    <div class="stat-item">
                        <span class="stat-value">$beds</span>
                        <span class="stat-label">Beds</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-value">$baths</span>
                        <span class="stat-label">Baths</span>
                    </div>
                    ${sqft != null ? '''
                    <div class="stat-item">
                        <span class="stat-value">$formattedSqft</span>
                        <span class="stat-label">Sq Ft</span>
                    </div>
                    ''' : ''}
                </div>
            </div>

            <!-- Additional Details -->
            <div class="key-info">
                <div class="section-title">📋 Property Details</div>
                <div class="info-grid">
                    <div class="info-item">
                        <div class="info-label">Property Type</div>
                        <div class="info-value">$propertyType</div>
                    </div>
                    ${yearBuilt.isNotEmpty ? '''
                    <div class="info-item">
                        <div class="info-label">Year Built</div>
                        <div class="info-value">$yearBuilt</div>
                    </div>
                    ''' : ''}
                    ${lotSize.isNotEmpty ? '''
                    <div class="info-item">
                        <div class="info-label">Lot Size</div>
                        <div class="info-value">$lotSize</div>
                    </div>
                    ''' : ''}
                    <div class="info-item">
                        <div class="info-label">MLS ID</div>
                        <div class="info-value">${propertyData.mlsId ?? 'N/A'}</div>
                    </div>
                </div>
            </div>

            <div class="divider"></div>

            <!-- CTA -->
            <div class="cta-container">
                <a href="$propertyUrl" class="cta-button">View Full Property Details</a>
                <div class="cta-subtitle">Open in PartnerPro app to explore photos, neighborhood info, and more</div>
            </div>

            <!-- Contact Section -->
            <div class="contact-section">
                <div class="contact-box">
                    <div class="contact-title">🤝 Questions? Let's Talk!</div>
                    <div class="contact-detail"><strong>$agentName</strong></div>
                    <div class="contact-detail">📞 $agentPhone</div>
                    <div class="contact-detail">✉️ $agentEmail</div>
                    <div style="margin-top: 15px; padding-top: 15px; border-top: 1px solid #e5e7eb; color: #6b7280; font-size: 14px;">
                        I'm here to answer any questions and schedule a viewing whenever you're ready!
                    </div>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <div class="footer">
            <div class="footer-note">This property was suggested to you through PartnerPro</div>
            <div class="footer-note">You're receiving this because $agentName is your real estate agent</div>
        </div>
    </div>
        </div>
    </div>
</body>
</html>
''';
}
