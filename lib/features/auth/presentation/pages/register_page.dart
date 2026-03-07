import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/router/route_names.dart';
import '../../../../core/widgets/app_widgets.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../bloc/auth_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() { _firstNameController.dispose(); _lastNameController.dispose(); _emailController.dispose(); _passwordController.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) context.showSnackBar(state.message, isError: true);
        if (state is AuthAuthenticated) context.go(RouteNames.roleSelection);
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40.h),
                  IconButton(onPressed: () => context.pop(), icon: Icon(LucideIcons.arrowLeft, size: 24.sp), style: IconButton.styleFrom(backgroundColor: AppColors.surfaceVariant, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)))),
                  SizedBox(height: 32.h),
                  Text('Create\nAccount', style: AppTypography.displayLarge).animate().fadeIn(duration: 500.ms).slideX(begin: -0.1),
                  SizedBox(height: 8.h),
                  Text('Join PartnerPro today', style: AppTypography.bodyLarge.copyWith(color: AppColors.textSecondary)).animate().fadeIn(delay: 200.ms),
                  SizedBox(height: 40.h),
                  Row(children: [
                    Expanded(child: AppTextField(controller: _firstNameController, label: 'First Name', prefixIcon: LucideIcons.user, validator: (v) => v == null || v.isEmpty ? 'Required' : null)),
                    SizedBox(width: 12.w),
                    Expanded(child: AppTextField(controller: _lastNameController, label: 'Last Name', prefixIcon: LucideIcons.user, validator: (v) => v == null || v.isEmpty ? 'Required' : null)),
                  ]).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1),
                  SizedBox(height: 16.h),
                  AppTextField(controller: _emailController, label: 'Email', hint: 'you@example.com', prefixIcon: LucideIcons.mail, keyboardType: TextInputType.emailAddress, validator: (v) => v == null || !v.contains('@') ? 'Valid email required' : null).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1),
                  SizedBox(height: 16.h),
                  AppTextField(controller: _passwordController, label: 'Password', hint: 'Min 6 characters', prefixIcon: LucideIcons.lock, obscureText: _obscurePassword, suffix: IconButton(icon: Icon(_obscurePassword ? LucideIcons.eyeOff : LucideIcons.eye, size: 20.sp), onPressed: () => setState(() => _obscurePassword = !_obscurePassword)), validator: (v) => v == null || v.length < 6 ? 'Min 6 characters' : null).animate().fadeIn(delay: 500.ms).slideY(begin: 0.1),
                  SizedBox(height: 32.h),
                  BlocBuilder<AuthBloc, AuthState>(builder: (context, state) { return AppButton(label: 'Create Account', isLoading: state is AuthLoading, onPressed: _onRegister); }).animate().fadeIn(delay: 600.ms),
                  SizedBox(height: 24.h),
                  Row(children: [const Expanded(child: Divider()), Padding(padding: EdgeInsets.symmetric(horizontal: 16.w), child: Text('or', style: AppTypography.labelMedium)), const Expanded(child: Divider())]),
                  SizedBox(height: 24.h),
                  Row(children: [
                    Expanded(child: OutlinedButton.icon(onPressed: () => context.read<AuthBloc>().add(const AuthSignInWithGoogle()), icon: Icon(LucideIcons.chrome, size: 18.sp), label: const Text('Google'), style: OutlinedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 14.h)))),
                    SizedBox(width: 12.w),
                    if (Platform.isIOS) Expanded(child: OutlinedButton.icon(onPressed: () => context.read<AuthBloc>().add(const AuthSignInWithApple()), icon: Icon(LucideIcons.apple, size: 18.sp), label: const Text('Apple'), style: OutlinedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 14.h)))),
                  ]),
                  SizedBox(height: 24.h),
                  Center(child: GestureDetector(onTap: () => context.push(RouteNames.login), child: RichText(text: TextSpan(text: 'Already have an account? ', style: AppTypography.bodyMedium, children: [TextSpan(text: 'Sign In', style: AppTypography.titleMedium.copyWith(color: AppColors.primary))])))),
                  SizedBox(height: 16.h),
                  Center(child: Text('By creating an account, you agree to our\nTerms of Service & Privacy Policy', style: AppTypography.caption, textAlign: TextAlign.center)),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onRegister() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(AuthRegisterWithEmail(email: _emailController.text.trim(), password: _passwordController.text, firstName: _firstNameController.text.trim(), lastName: _lastNameController.text.trim()));
    }
  }
}