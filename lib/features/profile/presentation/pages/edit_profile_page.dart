import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../../app/di/injection.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/services/file_service.dart';
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

  final phoneFormatter = MaskTextInputFormatter(
      mask: '(###) ###-####', filter: {"#": RegExp(r'[0-9]')});

  bool _isUploadingImage = false;
  String? _localImagePath;

  bool get _isAgent {
    final authState = context.read<AuthBloc>().state;
    final user = authState is AuthAuthenticated ? authState.user : null;
    return user?.role == 'agent';
  }

  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthBloc>().state;
    final user = authState is AuthAuthenticated ? authState.user : null;
    final agentProfile = context.read<AgentBloc>().state.agentProfile;

    _firstNameController = TextEditingController(
        text: user?.firstName ?? agentProfile?['first_name'] ?? '');
    _lastNameController = TextEditingController(
        text: user?.lastName ?? agentProfile?['last_name'] ?? '');
    _phoneController = TextEditingController(
        text: user?.phoneNumber ?? agentProfile?['phone_number'] ?? '');
    _mlsController =
        TextEditingController(text: agentProfile?['mls_id'] as String? ?? '');
    _brokerageController = TextEditingController(
        text: agentProfile?['brokerage_name'] as String? ?? '');

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

  Future<void> _pickAndUploadImage() async {
    final authState = context.read<AuthBloc>().state;
    final user = authState is AuthAuthenticated ? authState.user : null;
    if (user == null) return;

    final picker = ImagePicker();
    final picked = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 80);
    if (picked == null) return;

    setState(() {
      _isUploadingImage = true;
      _localImagePath = picked.path;
    });

    try {
      final bytes = await picked.readAsBytes();
      final fileService = getIt<FileService>();
      final uploaded = await fileService.uploadFile(
        userId: user.uid,
        directory: 'profile',
        fileName:
            'avatar_${DateTime.now().millisecondsSinceEpoch}.${picked.path.split('.').last}',
        bytes: bytes,
      );

      context.read<AgentBloc>().add(UpdateAgentProfile(
            userData: {'photo_url': uploaded.downloadUrl},
          ));
    } catch (e) {
      if (mounted)
        context.showSnackBar('Failed to upload image', isError: true);
    } finally {
      if (mounted) setState(() => _isUploadingImage = false);
    }
  }

  void _saveProfile() {
    if (!_formKey.currentState!.validate()) return;

    final data = <String, dynamic>{
      'first_name': _firstNameController.text.trim(),
      'last_name': _lastNameController.text.trim(),
      'phone_number': _phoneController.text.trim(),
    };
    if (_isAgent) {
      data['mls_id'] = _mlsController.text.trim();
      data['brokerage_name'] = _brokerageController.text.trim();
    }

    context.read<AgentBloc>().add(UpdateAgentProfile(userData: data));
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
                    ? SizedBox(
                        width: 16.w,
                        height: 16.w,
                        child: const CircularProgressIndicator(strokeWidth: 2))
                    : const Text('Save'),
              );
            },
          ),
        ],
      ),
      body: BlocConsumer<AgentBloc, AgentState>(
        listener: (context, state) {
          if (state.successMessage != null) {
            context.showSnackBar(state.successMessage!);
            Navigator.pop(context);
          }
          if (state.error != null) {
            context.showSnackBar(state.error!, isError: true);
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
                    child: GestureDetector(
                      onTap: _isUploadingImage ? null : _pickAndUploadImage,
                      child: Stack(
                        children: [
                          BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, authState) {
                              final user = authState is AuthAuthenticated
                                  ? authState.user
                                  : null;
                              if (_localImagePath != null) {
                                return CircleAvatar(
                                  radius: 48.r,
                                  backgroundImage:
                                      FileImage(File(_localImagePath!)),
                                );
                              }
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
                                border:
                                    Border.all(color: Colors.white, width: 2),
                              ),
                              child: _isUploadingImage
                                  ? SizedBox(
                                      width: 16.sp,
                                      height: 16.sp,
                                      child: const CircularProgressIndicator(
                                          strokeWidth: 2, color: Colors.white))
                                  : Icon(LucideIcons.camera,
                                      size: 16.sp, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 32.h),
                  AppTextField(
                    controller: _firstNameController,
                    label: 'First Name',
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Required' : null,
                  ),
                  SizedBox(height: 16.h),
                  AppTextField(
                    controller: _lastNameController,
                    label: 'Last Name',
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Required' : null,
                  ),
                  SizedBox(height: 16.h),
                  AppTextField(
                    controller: _phoneController,
                    label: 'Phone Number',
                    hint: '(555) 555-5555',
                    keyboardType: TextInputType.phone,
                    inputFormatters: [phoneFormatter],
                  ),
                  if (_isAgent) ...[
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
