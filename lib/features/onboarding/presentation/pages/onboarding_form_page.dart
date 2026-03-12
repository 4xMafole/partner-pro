import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/app_widgets.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../../core/enums/app_enums.dart';

class OnboardingFormPage extends StatefulWidget {
  final bool isEditing;
  const OnboardingFormPage({super.key, this.isEditing = false});

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

  // Agent Specific Legacy Fields
  final _brokerageNameC = TextEditingController();
  final _brokerageAddressC = TextEditingController();
  final _brokeragePhoneC = TextEditingController();
  final _brokerageLicenseC = TextEditingController();
  final _agentLicenseC = TextEditingController();
  final _mlsEmailC = TextEditingController();
  final _crmEmailC = TextEditingController();

  MlsType? _selectedMlsType;
  CrmType? _selectedCrmType;

  final phoneFormatter = MaskTextInputFormatter(
      mask: '(###) ###-####', filter: {'#': RegExp(r'[0-9]')});

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = context.read<AuthBloc>().state;
      if (state is AuthAuthenticated) {
        final user = state.user;
        _firstNameC.text = user.firstName ?? '';
        _lastNameC.text = user.lastName ?? '';
        _phoneC.text = user.phoneNumber ?? '';
        _stateC.text = user.state ?? '';
        _zipC.text = user.zipCode ?? '';
        if (user.role == 'agent') {
          _brokerageNameC.text = user.brokerageName ?? '';
          _brokerageAddressC.text = user.brokerageAddress ?? '';
          _brokeragePhoneC.text = user.brokeragePhone ?? '';
          _brokerageLicenseC.text = user.brokerageLicense ?? '';
          _agentLicenseC.text = user.agentLicense ?? '';
          _mlsEmailC.text = user.mlsEmail ?? '';
          _crmEmailC.text = user.crmEmail ?? '';
          _selectedMlsType = user.mlsType;
          _selectedCrmType = user.crmType;
        }
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _firstNameC.dispose();
    _lastNameC.dispose();
    _phoneC.dispose();
    _stateC.dispose();
    _zipC.dispose();
    _brokerageNameC.dispose();
    _brokerageAddressC.dispose();
    _brokeragePhoneC.dispose();
    _brokerageLicenseC.dispose();
    _agentLicenseC.dispose();
    _mlsEmailC.dispose();
    _crmEmailC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.isEditing ? 'Edit Profile' : 'Complete Profile')),
      body: BlocConsumer<AuthBloc, AuthState>(
        buildWhen: (prev, curr) =>
            curr is AuthAuthenticated || curr is AuthLoading,
        listener: (context, state) {
          if (state is AuthAuthenticated && state.user.onboardingCompleted) {
            context.showSnackBar('Profile saved successfully!', isError: false);
            if (widget.isEditing) {
              if (context.canPop()) {
                context.pop();
              }
            } else {
              final route = state.user.role == 'agent'
                  ? RouteNames.agentDashboard
                  : RouteNames.buyerDashboard;
              context.go(route);
            }
          } else if (state is AuthError) {
            context.showSnackBar(state.message, isError: true);
          }
        },
        builder: (context, state) {
          if (state is! AuthAuthenticated) {
            return const Center(child: CircularProgressIndicator());
          }
          final user = state.user;
          final isAgent = user.role == 'agent';

          return SingleChildScrollView(
            padding: EdgeInsets.all(24.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(LucideIcons.userCheck,
                      size: 48.w, color: AppColors.primary),
                  SizedBox(height: 16.h),
                  Text('Tell us about yourself',
                      style: theme.textTheme.headlineSmall,
                      textAlign: TextAlign.center),
                  SizedBox(height: 8.h),
                  Text('Complete your profile to get started.',
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: AppColors.textSecondary),
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
                    label: 'Phone Number (Optional)',
                    hint: '(555) 555-5555',
                    prefixIcon: LucideIcons.phone,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [phoneFormatter],
                    validator: (v) => null, // Optional
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
                  if (isAgent) ...[
                    SizedBox(height: 32.h),
                    Text('Agent Information', style: AppTypography.titleMedium),
                    SizedBox(height: 16.h),
                    AppTextField(
                        controller: _agentLicenseC,
                        label: 'Agent License (Optional)',
                        prefixIcon: LucideIcons.award),

                    SizedBox(height: 24.h),
                    Text('Brokerage Information',
                        style: AppTypography.titleMedium),
                    SizedBox(height: 16.h),
                    AppTextField(
                      controller: _brokerageNameC,
                      label: 'Brokerage Name',
                      prefixIcon: LucideIcons.briefcase,
                      validator: (v) => v!.isEmpty ? 'Required' : null,
                    ),
                    SizedBox(height: 16.h),
                    AppTextField(
                      controller: _brokerageAddressC,
                      label: 'Brokerage Address / Office Location',
                      prefixIcon: LucideIcons.map,
                      validator: (v) => v!.isEmpty ? 'Required' : null,
                    ),
                    SizedBox(height: 16.h),
                    AppTextField(
                      controller: _brokeragePhoneC,
                      label: 'Brokerage Phone (Optional)',
                      hint: '(555) 555-5555',
                      prefixIcon: LucideIcons.phoneCall,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [phoneFormatter],
                    ),
                    SizedBox(height: 16.h),
                    AppTextField(
                        controller: _brokerageLicenseC,
                        label: 'Brokerage License (Optional)',
                        prefixIcon: LucideIcons.award),

                    SizedBox(height: 24.h),
                    Text('Integrations', style: AppTypography.titleMedium),
                    SizedBox(height: 16.h),
                    AppTextField(
                        controller: _mlsEmailC,
                        label: 'MLS Email (Optional)',
                        prefixIcon: LucideIcons.mail),
                    SizedBox(height: 16.h),
                    // For brevity, we render simple dropdown buttons instead of creating complex widgets.
                    DropdownButtonFormField<MlsType>(
                      value: _selectedMlsType,
                      decoration: const InputDecoration(labelText: 'MLS Type'),
                      items: MlsType.values
                          .map((e) =>
                              DropdownMenuItem(value: e, child: Text(e.name)))
                          .toList(),
                      onChanged: (v) => setState(() => _selectedMlsType = v),
                    ),
                    SizedBox(height: 16.h),
                    AppTextField(
                        controller: _crmEmailC,
                        label: 'CRM Email (Optional)',
                        prefixIcon: LucideIcons.mail),
                    SizedBox(height: 16.h),
                    DropdownButtonFormField<CrmType>(
                      value: _selectedCrmType,
                      decoration: const InputDecoration(labelText: 'CRM Type'),
                      items: CrmType.values
                          .map((e) =>
                              DropdownMenuItem(value: e, child: Text(e.name)))
                          .toList(),
                      onChanged: (v) => setState(() => _selectedCrmType = v),
                    ),
                  ],
                  SizedBox(height: 32.h),
                  AppButton(
                    label: widget.isEditing ? 'Save Changes' : 'Continue',
                    isLoading: state is AuthLoading,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final updatedUser = user.copyWith(
                          firstName: _firstNameC.text.trim(),
                          lastName: _lastNameC.text.trim(),
                          phoneNumber: _phoneC.text.trim(),
                          state: _stateC.text.trim(),
                          zipCode: _zipC.text.trim(),
                          agentLicense: _agentLicenseC.text.trim(),
                          brokerageName: _brokerageNameC.text.trim(),
                          brokerageAddress: _brokerageAddressC.text.trim(),
                          brokeragePhone: _brokeragePhoneC.text.trim(),
                          brokerageLicense: _brokerageLicenseC.text.trim(),
                          mlsEmail: _mlsEmailC.text.trim(),
                          mlsType: _selectedMlsType,
                          crmEmail: _crmEmailC.text.trim(),
                          crmType: _selectedCrmType,
                          onboardingCompleted: true,
                        );
                        context
                            .read<AuthBloc>()
                            .add(AuthUpdateProfile(updatedUser));
                      }
                    },
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
