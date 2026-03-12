import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/widgets/app_widgets.dart';

class NotificationSettingsPage extends StatelessWidget {
  const NotificationSettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notification Settings')),
      body: const AppEmptyState(
        icon: LucideIcons.bellRing,
        title: 'Notification Preferences',
        subtitle:
            'Configure push notifications, email alerts, and SMS preferences.',
      ),
    );
  }
}
