import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/widgets/app_widgets.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';

class SecurityPage extends StatefulWidget {
  const SecurityPage({super.key});

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(AuthChangePassword(
            currentPassword: _currentPasswordController.text,
            newPassword: _newPasswordController.text,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Security')),
      body: BlocListener<AuthBloc, AuthState>(
        listenWhen: (prev, curr) =>
            curr is AuthPasswordChanged ||
            curr is AuthError ||
            (prev is AuthLoading && curr is AuthAuthenticated),
        listener: (context, state) {
          if (state is AuthPasswordChanged ||
              (state is AuthAuthenticated &&
                  !ModalRoute.of(context)!.isFirst &&
                  _currentPasswordController.text.isNotEmpty)) {
            if (_currentPasswordController.text.isNotEmpty) {
              context.showSnackBar('Password updated successfully.');
              _currentPasswordController.clear();
              _newPasswordController.clear();
              _confirmPasswordController.clear();
            }
          } else if (state is AuthError) {
            context.showSnackBar(state.message, isError: true);
          }
        },
        child: ListView(
          padding: EdgeInsets.all(24.w),
          children: [
            Icon(LucideIcons.shield, size: 48.sp, color: AppColors.primary),
            SizedBox(height: 16.h),
            Text('Password & Sign-In',
                style: AppTypography.titleLarge, textAlign: TextAlign.center),
            SizedBox(height: 8.h),
            Text(
              'Update your password.',
              style: AppTypography.bodyMedium
                  .copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.h),
            Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(LucideIcons.key,
                            size: 20.sp, color: AppColors.primary),
                        SizedBox(width: 8.w),
                        Text('Change Password',
                            style: AppTypography.titleSmall),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    AppTextField(
                      controller: _currentPasswordController,
                      label: 'Current Password',
                      obscureText: true,
                      validator: (val) {
                        if (val == null || val.isEmpty) return 'Required';
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),
                    AppTextField(
                      controller: _newPasswordController,
                      label: 'New Password',
                      obscureText: true,
                      validator: (val) {
                        if (val == null || val.isEmpty) return 'Required';
                        if (val.length < 6) return 'Password too short';
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),
                    AppTextField(
                      controller: _confirmPasswordController,
                      label: 'Confirm New Password',
                      obscureText: true,
                      validator: (val) {
                        if (val != _newPasswordController.text)
                          return 'Passwords do not match';
                        return null;
                      },
                    ),
                    SizedBox(height: 24.h),
                    SizedBox(
                      width: double.infinity,
                      child: BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          return AppButton(
                            label: 'Update Password',
                            isLoading: state is AuthLoading,
                            onPressed: _submit,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
