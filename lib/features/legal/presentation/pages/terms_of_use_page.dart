import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TermsOfUsePage extends StatelessWidget {
  const TermsOfUsePage({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Terms of Use')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Terms of Use', style: theme.textTheme.headlineSmall),
            SizedBox(height: 16.h),
            Text(
              'Replace this placeholder with your actual Terms of Use.\n\n'
              'Your terms should cover:\n'
              '- User responsibilities\n'
              '- Acceptable use policy\n'
              '- Limitation of liability\n'
              '- Dispute resolution\n'
              '- Termination conditions\n'
              '- Privacy policy reference\n\n'
              'Consult your legal counsel to draft appropriate terms.',
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}