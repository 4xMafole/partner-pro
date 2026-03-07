import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/app_widgets.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../bloc/auth_bloc.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});
  @override State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override void dispose() { _emailController.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthPasswordResetSent) { context.showSnackBar('Password reset email sent! Check your inbox.'); context.pop(); }
        if (state is AuthError) context.showSnackBar(state.message, isError: true);
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40.h),
                  IconButton(onPressed: () => context.pop(), icon: Icon(LucideIcons.arrowLeft, size: 24.sp), style: IconButton.styleFrom(backgroundColor: AppColors.surfaceVariant, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)))),
                  SizedBox(height: 32.h),
                  Text('Reset\nPassword', style: AppTypography.displayLarge).animate().fadeIn(duration: 500.ms),
                  SizedBox(height: 8.h),
                  Text("Enter your email and we'll send you a reset link", style: AppTypography.bodyLarge.copyWith(color: AppColors.textSecondary)).animate().fadeIn(delay: 200.ms),
                  SizedBox(height: 48.h),
                  AppTextField(controller: _emailController, label: 'Email', hint: 'you@example.com', prefixIcon: LucideIcons.mail, keyboardType: TextInputType.emailAddress, validator: (v) => v == null || !v.contains('@') ? 'Valid email required' : null).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1),
                  SizedBox(height: 32.h),
                  BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                    return AppButton(label: 'Send Reset Link', isLoading: state is AuthLoading, onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(AuthSendPasswordReset(email: _emailController.text.trim()));
                      }
                    });
                  }).animate().fadeIn(delay: 400.ms),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}