import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/app_widgets.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../agent/presentation/bloc/agent_bloc.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _mlsController;
  late final TextEditingController _brokerageController;

  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthBloc>().state;
    final user = authState is AuthAuthenticated ? authState.user : null;
    final agentProfile = context.read<AgentBloc>().state.agentProfile;

    _firstNameController = TextEditingController(text: user?.firstName ?? agentProfile?['first_name'] ?? '');
    _lastNameController = TextEditingController(text: user?.lastName ?? agentProfile?['last_name'] ?? '');
    _phoneController = TextEditingController(text: user?.phoneNumber ?? agentProfile?['phone_number'] ?? '');
    _mlsController = TextEditingController(text: agentProfile?['mls_id'] as String? ?? '');
    _brokerageController = TextEditingController(text: agentProfile?['brokerage_name'] as String? ?? '');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (user != null && agentProfile == null) {
        context.read<AgentBloc>().add(LoadAgentProfile(email: user.email));
      }
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _mlsController.dispose();
    _brokerageController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    if (!_formKey.currentState!.validate()) return;

    context.read<AgentBloc>().add(UpdateAgentProfile(
      userData: {
        'first_name': _firstNameController.text.trim(),
        'last_name': _lastNameController.text.trim(),
        'phone_number': _phoneController.text.trim(),
        'mls_id': _mlsController.text.trim(),
        'brokerage_name': _brokerageController.text.trim(),
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          BlocBuilder<AgentBloc, AgentState>(
            builder: (context, state) {
              return TextButton(
                onPressed: state.isLoading ? null : _saveProfile,
                child: state.isLoading
                    ? SizedBox(width: 16.w, height: 16.w, child: const CircularProgressIndicator(strokeWidth: 2))
                    : const Text('Save'),
              );
            },
          ),
        ],
      ),
      body: BlocConsumer<AgentBloc, AgentState>(
        listener: (context, state) {
          if (state.successMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.successMessage!), backgroundColor: AppColors.success),
            );
            Navigator.pop(context);
          }
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error!), backgroundColor: AppColors.error),
            );
          }
          if (state.agentProfile != null) {
            final p = state.agentProfile!;
            if (_firstNameController.text.isEmpty) {
              _firstNameController.text = p['first_name'] as String? ?? '';
            }
            if (_lastNameController.text.isEmpty) {
              _lastNameController.text = p['last_name'] as String? ?? '';
            }
            if (_phoneController.text.isEmpty) {
              _phoneController.text = p['phone_number'] as String? ?? '';
            }
            if (_mlsController.text.isEmpty) {
              _mlsController.text = p['mls_id'] as String? ?? '';
            }
            if (_brokerageController.text.isEmpty) {
              _brokerageController.text = p['brokerage_name'] as String? ?? '';
            }
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(24.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, authState) {
                            final user = authState is AuthAuthenticated ? authState.user : null;
                            return AppAvatar(
                              name: user?.displayName ?? 'User',
                              imageUrl: user?.photoUrl,
                              size: 96,
                            );
                          },
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(6.w),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: Icon(LucideIcons.camera, size: 16.sp, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 32.h),

                  AppTextField(
                    controller: _firstNameController,
                    label: 'First Name',
                    validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                  ),
                  SizedBox(height: 16.h),
                  AppTextField(
                    controller: _lastNameController,
                    label: 'Last Name',
                    validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                  ),
                  SizedBox(height: 16.h),
                  AppTextField(
                    controller: _phoneController,
                    label: 'Phone Number',
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 16.h),
                  AppTextField(
                    controller: _mlsController,
                    label: 'MLS ID',
                  ),
                  SizedBox(height: 16.h),
                  AppTextField(
                    controller: _brokerageController,
                    label: 'Brokerage Name',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}