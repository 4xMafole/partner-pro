import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../core/widgets/app_widgets.dart';

class CommunicationConsentPage extends StatefulWidget {
  const CommunicationConsentPage({super.key});
  @override
  State<CommunicationConsentPage> createState() => _CommunicationConsentPageState();
}

class _CommunicationConsentPageState extends State<CommunicationConsentPage> {
  bool _smsConsent = false;
  bool _emailConsent = false;
  bool _pushConsent = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Communication Consent')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Communication Preferences', style: theme.textTheme.headlineSmall),
            SizedBox(height: 8.h),
            Text(
              'Choose how you\'d like us to communicate with you.',
              style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
            ),
            SizedBox(height: 24.h),
            SwitchListTile(
              title: const Text('SMS Messages'),
              subtitle: const Text('Receive text messages for offers and updates'),
              value: _smsConsent,
              onChanged: (v) => setState(() => _smsConsent = v),
              activeColor: AppColors.primary,
            ),
            SwitchListTile(
              title: const Text('Email Updates'),
              subtitle: const Text('Receive email notifications and newsletters'),
              value: _emailConsent,
              onChanged: (v) => setState(() => _emailConsent = v),
              activeColor: AppColors.primary,
            ),
            SwitchListTile(
              title: const Text('Push Notifications'),
              subtitle: const Text('Receive real-time push notifications'),
              value: _pushConsent,
              onChanged: (v) => setState(() => _pushConsent = v),
              activeColor: AppColors.primary,
            ),
            SizedBox(height: 32.h),
            AppButton(
              label: 'Save Preferences',
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}