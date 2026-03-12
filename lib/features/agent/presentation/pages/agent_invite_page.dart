import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/widgets/app_widgets.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../bloc/agent_bloc.dart';

class AgentInvitePage extends StatefulWidget {
  const AgentInvitePage({super.key});
  @override
  State<AgentInvitePage> createState() => _AgentInvitePageState();
}

class _AgentInvitePageState extends State<AgentInvitePage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _phoneFormatter = MaskTextInputFormatter(
      mask: '(###) ###-####', filter: {"#": RegExp(r'[0-9]')});
  final List<Map<String, dynamic>> _invitees = [];

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _addInvitee() {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _invitees.add({
        'first_name': _firstNameController.text.trim(),
        'last_name': _lastNameController.text.trim(),
        'email': _emailController.text.trim(),
        'phone': _phoneController.text.trim()
      });
      _firstNameController.clear();
      _lastNameController.clear();
      _emailController.clear();
      _phoneController.clear();
      _phoneFormatter.clear();
    });
  }

  void _removeInvitee(int index) {
    setState(() => _invitees.removeAt(index));
  }

  void _sendInvitations() {
    if (_invitees.isEmpty) return;
    final authState = context.read<AuthBloc>().state;
    if (authState is! AuthAuthenticated) return;
    final user = authState.user;
    final uid = user.uid;
    context.read<AgentBloc>().add(SendInvitations(
          inviterUid: uid,
          inviterName: user.firstName ?? user.displayName ?? 'Agent',
          inviterFullName: user.displayName ?? '',
          signUpUrl: 'https://mypartnerpro.com/signup',
          shortLink: 'https://mypartnerpro.com/invite/$uid',
          logoUrl: 'https://mypartnerpro.com/logo.png',
          inviterMLS: null,
          inviterContact: user.phoneNumber,
          brokerageName: null,
          invitees: _invitees,
          requesterId: uid,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Invite Buyers')),
      body: BlocConsumer<AgentBloc, AgentState>(
        listener: (context, state) {
          if (state.successMessage != null) {
            context.showSnackBar(state.successMessage!);
            setState(() => _invitees.clear());
          }
          if (state.error != null && state.isSending == false) {
            context.showSnackBar(state.error!, isError: true);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
              padding: EdgeInsets.all(24.w),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Add Buyer Details',
                        style: AppTypography.headlineSmall),
                    SizedBox(height: 16.h),
                    Form(
                        key: _formKey,
                        child: Column(children: [
                          Row(children: [
                            Expanded(
                                child: AppTextField(
                                    controller: _firstNameController,
                                    label: 'First Name',
                                    hint: 'John',
                                    validator: (v) => v == null || v.isEmpty
                                        ? 'Required'
                                        : null)),
                            SizedBox(width: 12.w),
                            Expanded(
                                child: AppTextField(
                                    controller: _lastNameController,
                                    label: 'Last Name',
                                    hint: 'Doe',
                                    validator: (v) => v == null || v.isEmpty
                                        ? 'Required'
                                        : null)),
                          ]),
                          SizedBox(height: 12.h),
                          AppTextField(
                              controller: _emailController,
                              label: 'Email',
                              hint: 'john@example.com',
                              keyboardType: TextInputType.emailAddress,
                              validator: (v) {
                                if (v == null || v.isEmpty) return 'Required';
                                if (!v.contains('@')) return 'Invalid email';
                                return null;
                              }),
                          SizedBox(height: 12.h),
                          AppTextField(
                              controller: _phoneController,
                              label: 'Phone (optional)',
                              hint: '(555) 123-4567',
                              inputFormatters: [_phoneFormatter],
                              keyboardType: TextInputType.phone),
                          SizedBox(height: 16.h),
                          SizedBox(
                              width: double.infinity,
                              child: OutlinedButton.icon(
                                  onPressed: _addInvitee,
                                  icon: const Icon(LucideIcons.plus),
                                  label: const Text('Add to List'))),
                        ])),
                    if (_invitees.isNotEmpty) ...[
                      SizedBox(height: 24.h),
                      Text('Invitees (${_invitees.length})',
                          style: AppTypography.headlineSmall),
                      SizedBox(height: 12.h),
                      ..._invitees.asMap().entries.map((entry) {
                        final i = entry.key;
                        final inv = entry.value;
                        return Card(
                            margin: EdgeInsets.only(bottom: 8.h),
                            child: ListTile(
                              leading: AppAvatar(
                                  name:
                                      '${inv['first_name']} ${inv['last_name']}',
                                  size: 40),
                              title: Text(
                                  '${inv['first_name']} ${inv['last_name']}',
                                  style: AppTypography.titleMedium),
                              subtitle: Text(inv['email'] as String,
                                  style: AppTypography.bodySmall.copyWith(
                                      color: AppColors.textSecondary)),
                              trailing: IconButton(
                                  icon: Icon(LucideIcons.x,
                                      size: 18.sp, color: AppColors.error),
                                  onPressed: () => _removeInvitee(i)),
                            ));
                      }),
                      SizedBox(height: 24.h),
                      SizedBox(
                          width: double.infinity,
                          child: AppButton(
                              label: 'Send Invitations',
                              icon: LucideIcons.send,
                              isLoading: state.isSending,
                              onPressed:
                                  state.isSending ? null : _sendInvitations)),
                    ],
                  ]));
        },
      ),
    );
  }
}
