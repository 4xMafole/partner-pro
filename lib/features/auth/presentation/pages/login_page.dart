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

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() { _emailController.dispose(); _passwordController.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) context.showSnackBar(state.message, isError: true);
        if (state is AuthAuthenticated) {
          final user = state.user;
          if (user.role == null || user.isNewUser) { context.go(RouteNames.roleSelection); }
          else if (user.role == 'agent') { context.go(RouteNames.agentDashboard); }
          else { context.go(RouteNames.buyerDashboard); }
        }
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
                  SizedBox(height: 60.h),
                  Text('Welcome\nBack', style: AppTypography.displayLarge).animate().fadeIn(duration: 500.ms).slideX(begin: -0.1),
                  SizedBox(height: 8.h),
                  Text('Sign in to continue', style: AppTypography.bodyLarge.copyWith(color: AppColors.textSecondary)).animate().fadeIn(delay: 200.ms),
                  SizedBox(height: 48.h),
                  AppTextField(controller: _emailController, label: 'Email', hint: 'Enter your email', prefixIcon: LucideIcons.mail, keyboardType: TextInputType.emailAddress, validator: (v) => v == null || !v.contains('@') ? 'Valid email required' : null).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1),
                  SizedBox(height: 16.h),
                  AppTextField(controller: _passwordController, label: 'Password', hint: 'Enter your password', prefixIcon: LucideIcons.lock, obscureText: _obscurePassword, suffix: IconButton(icon: Icon(_obscurePassword ? LucideIcons.eyeOff : LucideIcons.eye, size: 20.sp), onPressed: () => setState(() => _obscurePassword = !_obscurePassword)), validator: (v) => v == null || v.length < 6 ? 'Min 6 characters' : null).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1),
                  SizedBox(height: 8.h),
                  Align(alignment: Alignment.centerRight, child: TextButton(onPressed: () => context.push(RouteNames.forgotPassword), child: Text('Forgot Password?', style: AppTypography.labelMedium.copyWith(color: AppColors.secondary)))),
                  SizedBox(height: 24.h),
                  BlocBuilder<AuthBloc, AuthState>(builder: (context, state) { return AppButton(label: 'Sign In', isLoading: state is AuthLoading, onPressed: _onSignIn); }).animate().fadeIn(delay: 500.ms),
                  SizedBox(height: 32.h),
                  Row(children: [const Expanded(child: Divider()), Padding(padding: EdgeInsets.symmetric(horizontal: 16.w), child: Text('or continue with', style: AppTypography.labelMedium)), const Expanded(child: Divider())]).animate().fadeIn(delay: 600.ms),
                  SizedBox(height: 24.h),
                  Row(children: [
                    Expanded(child: _SocialButton(icon: LucideIcons.chrome, label: 'Google', onTap: () => context.read<AuthBloc>().add(const AuthSignInWithGoogle()))),
                    SizedBox(width: 12.w),
                    if (Platform.isIOS) Expanded(child: _SocialButton(icon: LucideIcons.apple, label: 'Apple', onTap: () => context.read<AuthBloc>().add(const AuthSignInWithApple()))),
                  ]).animate().fadeIn(delay: 700.ms),
                  SizedBox(height: 32.h),
                  Center(child: GestureDetector(onTap: () => context.push(RouteNames.register), child: RichText(text: TextSpan(text: "Don't have an account? ", style: AppTypography.bodyMedium, children: [TextSpan(text: 'Sign Up', style: AppTypography.titleMedium.copyWith(color: AppColors.primary))])))),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onSignIn() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(AuthSignInWithEmail(email: _emailController.text.trim(), password: _passwordController.text));
    }
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _SocialButton({required this.icon, required this.label, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(12.r)),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, size: 20.sp), SizedBox(width: 8.w), Text(label, style: AppTypography.labelLarge)]),
      ),
    );
  }
}