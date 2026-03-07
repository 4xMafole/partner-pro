import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LegalDisclosurePage extends StatelessWidget {
  const LegalDisclosurePage({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Legal Disclosures')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Legal Disclosures', style: theme.textTheme.headlineSmall),
            SizedBox(height: 16.h),
            Text(
              'This page will contain the legal disclosures required by your '
              'jurisdiction for real estate transactions. Update this content '
              'with your actual legal disclosure text.\n\n'
              'Consult your legal team to provide the appropriate disclosures '
              'for buyers and agents using the PartnerPro platform.',
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}