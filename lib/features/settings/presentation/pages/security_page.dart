import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/widgets/app_widgets.dart';

class SecurityPage extends StatelessWidget {
  const SecurityPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Security')),
      body: const AppEmptyState(
        icon: LucideIcons.shield, title: 'Security',
        subtitle: 'Change password, manage sign-in methods, and ID verification.',
      ),
    );
  }
}