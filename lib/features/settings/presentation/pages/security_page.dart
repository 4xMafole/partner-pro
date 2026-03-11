import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/widgets/app_widgets.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';

class SecurityPage extends StatelessWidget {
  const SecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Grab email once before any state transitions
    final authState = context.read<AuthBloc>().state;
    final email = authState is AuthAuthenticated ? authState.user.email : '';

    return Scaffold(
      appBar: AppBar(title: const Text('Security')),
      body: BlocListener<AuthBloc, AuthState>(
        listenWhen: (prev, curr) => curr is AuthPasswordResetSent || curr is AuthError,
        listener: (context, state) {
          if (state is AuthPasswordResetSent) {
            context.showSnackBar('Password reset email sent. Check your inbox.');
          } else if (state is AuthError) {
            context.showSnackBar(state.message, isError: true);
          }
        },
        child: ListView(
          padding: EdgeInsets.all(24.w),
          children: [
            Icon(LucideIcons.shield, size: 48.sp, color: AppColors.primary),
            SizedBox(height: 16.h),
            Text('Password & Sign-In', style: AppTypography.titleLarge, textAlign: TextAlign.center),
            SizedBox(height: 8.h),
            Text(
              'Manage your password and authentication settings.',
              style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.h),

            // Password reset section
            Container(
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
                      Icon(LucideIcons.key, size: 20.sp, color: AppColors.primary),
                      SizedBox(width: 8.w),
                      Text('Reset Password', style: AppTypography.titleSmall),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'A password reset link will be sent to:',
                    style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
                  ),
                  SizedBox(height: 4.h),
                  Text(email, style: AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
                  SizedBox(height: 16.h),
                  SizedBox(
                    width: double.infinity,
                    child: BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return AppButton(
                          label: 'Send Reset Link',
                          isLoading: state is AuthLoading,
                          onPressed: email.isEmpty ? null : () {
                            context.read<AuthBloc>().add(AuthSendPasswordReset(email: email));
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}