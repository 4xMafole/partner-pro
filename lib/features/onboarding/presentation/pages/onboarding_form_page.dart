import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../core/widgets/app_widgets.dart';

class OnboardingFormPage extends StatefulWidget {
  const OnboardingFormPage({super.key});
  @override
  State<OnboardingFormPage> createState() => _OnboardingFormPageState();
}

class _OnboardingFormPageState extends State<OnboardingFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameC = TextEditingController();
  final _lastNameC = TextEditingController();
  final _phoneC = TextEditingController();
  final _stateC = TextEditingController();
  final _zipC = TextEditingController();

  @override
  void dispose() {
    _firstNameC.dispose();
    _lastNameC.dispose();
    _phoneC.dispose();
    _stateC.dispose();
    _zipC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Complete Profile')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(LucideIcons.userCheck, size: 48.w, color: AppColors.primary),
              SizedBox(height: 16.h),
              Text('Tell us about yourself',
                style: theme.textTheme.headlineSmall, textAlign: TextAlign.center),
              SizedBox(height: 8.h),
              Text('Complete your profile to get started.',
                style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
                textAlign: TextAlign.center),
              SizedBox(height: 32.h),
              AppTextField(
                controller: _firstNameC,
                label: 'First Name',
                prefixIcon: LucideIcons.user,
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: 16.h),
              AppTextField(
                controller: _lastNameC,
                label: 'Last Name',
                prefixIcon: LucideIcons.user,
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: 16.h),
              AppTextField(
                controller: _phoneC,
                label: 'Phone Number',
                prefixIcon: LucideIcons.phone,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      controller: _stateC,
                      label: 'State',
                      prefixIcon: LucideIcons.mapPin,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: AppTextField(
                      controller: _zipC,
                      label: 'Zip Code',
                      prefixIcon: LucideIcons.hash,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.h),
              AppButton(
                label: 'Continue',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Save profile via AuthBloc / repository
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}