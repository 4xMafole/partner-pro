import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/app_widgets.dart';
import '../../../../core/widgets/currency_input.dart';
import '../../../../core/widgets/down_payment_selector.dart';
import '../../../property/data/models/property_model.dart';
import '../../data/models/offer_model.dart';
import '../bloc/offer_bloc.dart';

/// Multi-step offer creation/editing bottom sheet.
///
/// Steps: 1) Buyer Info → 2) Pricing & Financials → 3) Conditions → 4) Title Company → 5) Review & Submit
class OfferProcessSheet extends StatefulWidget {
  final PropertyDataClass property;
  final String requesterId;
  final OfferModel? existingOffer;
  final VoidCallback? onComplete;

  const OfferProcessSheet({
    super.key,
    required this.property,
    required this.requesterId,
    this.existingOffer,
    this.onComplete,
  });

  @override
  State<OfferProcessSheet> createState() => _OfferProcessSheetState();
}

class _OfferProcessSheetState extends State<OfferProcessSheet> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;
  bool _hasSecondBuyer = false;

  // ── Step 1: Buyer Info ──
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneMask = MaskTextInputFormatter(mask: '(###) ###-####');

  // Second buyer
  final _secondFirstNameCtrl = TextEditingController();
  final _secondLastNameCtrl = TextEditingController();
  final _secondPhoneCtrl = TextEditingController();
  final _secondEmailCtrl = TextEditingController();
  final _secondPhoneMask = MaskTextInputFormatter(mask: '(###) ###-####');

  // ── Step 2: Pricing ──
  double _purchasePrice = 0;
  double _downPaymentAmount = 0;
  double _depositAmount = 0;
  double _creditRequest = 0;
  double _additionalEarnest = 0;
  double _optionFee = 0;
  double _coverageAmount = 0;
  String _loanType = '';

  String _depositType = 'None';
  final _closingDaysCtrl = TextEditingController(text: '30');
  DateTime? _closingDate;

  // ── Step 3: Conditions ──
  String _propertyCondition = 'As-Is';
  bool _preApproval = false;
  bool _survey = false;

  // ── Step 4: Title Company ──
  final _titleCompanyCtrl = TextEditingController();
  String _titleChoice = 'Buyer';

  static const _stepTitles = [
    'Buyer Information',
    'Pricing & Financials',
    'Conditions',
    'Title Company',
    'Review & Submit',
  ];

  @override
  void initState() {
    super.initState();
    _populateFromExisting();
  }

  void _populateFromExisting() {
    final offer = widget.existingOffer;
    if (offer == null) return;

    // Buyer info
    final nameParts = offer.buyer.name.split(' ');
    _firstNameCtrl.text = nameParts.isNotEmpty ? nameParts.first : '';
    _lastNameCtrl.text =
        nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';
    _phoneCtrl.text = offer.buyer.phoneNumber;
    _emailCtrl.text = offer.buyer.email;

    // Pricing
    _purchasePrice = offer.purchasePrice.toDouble();
    _downPaymentAmount = offer.downPaymentAmount.toDouble();
    _depositAmount = offer.depositAmount.toDouble();
    _creditRequest = offer.requestForSellerCredit.toDouble();
    _additionalEarnest = offer.additionalEarnest.toDouble();
    _optionFee = offer.optionFee.toDouble();
    _coverageAmount = offer.coverageAmount.toDouble();
    _loanType = offer.loanType;
    _depositType = offer.depositType.isNotEmpty ? offer.depositType : 'None';
    _closingDate = offer.closingDate;

    // Conditions
    _propertyCondition =
        offer.propertyCondition.isNotEmpty ? offer.propertyCondition : 'As-Is';
    _preApproval = offer.preApproval;
    _survey = offer.survey;

    // Title
    _titleCompanyCtrl.text = offer.titleCompany.companyName;
    _titleChoice = offer.titleCompany.choice.isNotEmpty
        ? offer.titleCompany.choice
        : 'Buyer';
  }

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    _secondFirstNameCtrl.dispose();
    _secondLastNameCtrl.dispose();
    _secondPhoneCtrl.dispose();
    _secondEmailCtrl.dispose();
    _closingDaysCtrl.dispose();
    _titleCompanyCtrl.dispose();
    super.dispose();
  }

  Map<String, dynamic> _buildOfferData() {
    final loanAmount = _purchasePrice - _downPaymentAmount;
    return {
      if (widget.existingOffer != null) 'id': widget.existingOffer!.id,
      'status': 'pending',
      'propertyId': widget.property.id,
      'property': {
        'id': widget.property.id,
        'propertyName': widget.property.propertyName,
        'listPrice': widget.property.listPrice,
        'address': {
          'streetNumber': widget.property.address.streetNumber,
          'streetName': widget.property.address.streetName,
          'city': widget.property.address.city,
          'state': widget.property.address.state,
          'zip': widget.property.address.zip,
        },
      },
      'parties': {
        'buyer': {
          'name': '${_firstNameCtrl.text.trim()} ${_lastNameCtrl.text.trim()}',
          'phoneNumber': _phoneCtrl.text.trim(),
          'email': _emailCtrl.text.trim(),
        },
        if (_hasSecondBuyer)
          'secondBuyer': {
            'name':
                '${_secondFirstNameCtrl.text.trim()} ${_secondLastNameCtrl.text.trim()}',
            'phoneNumber': _secondPhoneCtrl.text.trim(),
            'email': _secondEmailCtrl.text.trim(),
          },
      },
      'pricing': {
        'listPrice': widget.property.listPrice,
        'purchasePrice': _purchasePrice.toInt(),
      },
      'financials': {
        'loanType': _loanType,
        'downPaymentAmount': _downPaymentAmount.toInt(),
        'loanAmount': loanAmount.toInt(),
        'creditRequest': _creditRequest.toInt(),
        'depositType': _depositType,
        'depositAmount': _depositAmount.toInt(),
        'additionalEarnest': _additionalEarnest.toInt(),
        'optionFee': _optionFee.toInt(),
        'coverageAmount': _coverageAmount.toInt(),
      },
      'conditions': {
        'propertyCondition': _propertyCondition,
        'preApproval': _preApproval,
        'survey': _survey,
      },
      'closingDate': _closingDate?.toIso8601String() ?? '',
      'closingDays': int.tryParse(_closingDaysCtrl.text) ?? 30,
      'titleCompany': {
        'companyName': _titleCompanyCtrl.text.trim(),
        'choice': _titleChoice,
      },
    };
  }

  void _onNext() {
    if (_currentStep < 4) {
      if (_currentStep == 0 && !_formKey.currentState!.validate()) return;
      // Save draft
      context
          .read<OfferBloc>()
          .add(UpdateOfferDraft(draftData: _buildOfferData()));
      setState(() => _currentStep++);
    }
  }

  void _onBack() {
    if (_currentStep > 0) setState(() => _currentStep--);
  }

  void _onSubmit() {
    final data = _buildOfferData();
    final bloc = context.read<OfferBloc>();

    if (widget.existingOffer != null) {
      bloc.add(UpdateOffer(offerData: data, requesterId: widget.requesterId));
    } else {
      bloc.add(CreateOffer(offerData: data, requesterId: widget.requesterId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OfferBloc, OfferState>(
      listener: (context, state) {
        if (state.successMessage != null) {
          widget.onComplete?.call();
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(state.successMessage!),
                backgroundColor: AppColors.success),
          );
        }
        if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(state.error!), backgroundColor: AppColors.error),
          );
        }
      },
      child: Container(
        height: MediaQuery.sizeOf(context).height * 0.85,
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          children: [
            _buildHandle(),
            _buildHeader(),
            _buildStepIndicator(),
            Expanded(child: _buildStepContent()),
            _buildNavButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildHandle() {
    return Container(
      margin: EdgeInsets.only(top: 12.h),
      width: 36.w,
      height: 4.h,
      decoration: BoxDecoration(
        color: AppColors.textTertiary,
        borderRadius: BorderRadius.circular(2.r),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Offer Process', style: AppTypography.headlineSmall),
              SizedBox(height: 2.h),
              Text(
                _stepTitles[_currentStep],
                style: AppTypography.bodySmall
                    .copyWith(color: AppColors.textSecondary),
              ),
            ],
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: List.generate(5, (i) {
          final isActive = i == _currentStep;
          final isDone = i < _currentStep;
          return Expanded(
            child: Container(
              height: 4.h,
              margin: EdgeInsets.symmetric(horizontal: 2.w),
              decoration: BoxDecoration(
                color: isDone
                    ? AppColors.success
                    : isActive
                        ? AppColors.primary
                        : AppColors.border,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildStepContent() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: switch (_currentStep) {
        0 => _buildBuyerInfoStep(),
        1 => _buildPricingStep(),
        2 => _buildConditionsStep(),
        3 => _buildTitleCompanyStep(),
        4 => _buildReviewStep(),
        _ => const SizedBox.shrink(),
      },
    );
  }

  // ────────────────────────────────────────────
  // STEP 1: Buyer Information
  // ────────────────────────────────────────────
  Widget _buildBuyerInfoStep() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Primary Buyer', style: AppTypography.labelLarge),
          SizedBox(height: 12.h),
          AppTextField(
            controller: _firstNameCtrl,
            label: 'First Name *',
            validator: _required,
          ),
          SizedBox(height: 12.h),
          AppTextField(
            controller: _lastNameCtrl,
            label: 'Last Name *',
            validator: _required,
          ),
          SizedBox(height: 12.h),
          TextFormField(
            controller: _phoneCtrl,
            decoration: const InputDecoration(labelText: 'Phone *'),
            keyboardType: TextInputType.phone,
            inputFormatters: [_phoneMask],
            validator: _required,
            style: AppTypography.bodyMedium,
          ),
          SizedBox(height: 12.h),
          AppTextField(
            controller: _emailCtrl,
            label: 'Email *',
            keyboardType: TextInputType.emailAddress,
            validator: _emailValidator,
          ),
          SizedBox(height: 20.h),
          // Second buyer toggle
          SwitchListTile(
            value: _hasSecondBuyer,
            onChanged: (v) => setState(() => _hasSecondBuyer = v),
            title: Text('Add Second Buyer', style: AppTypography.bodyMedium),
            activeColor: AppColors.primary,
            contentPadding: EdgeInsets.zero,
          ),
          if (_hasSecondBuyer) ...[
            SizedBox(height: 8.h),
            Text('Second Buyer', style: AppTypography.labelLarge),
            SizedBox(height: 12.h),
            AppTextField(controller: _secondFirstNameCtrl, label: 'First Name'),
            SizedBox(height: 12.h),
            AppTextField(controller: _secondLastNameCtrl, label: 'Last Name'),
            SizedBox(height: 12.h),
            TextFormField(
              controller: _secondPhoneCtrl,
              decoration: const InputDecoration(labelText: 'Phone'),
              keyboardType: TextInputType.phone,
              inputFormatters: [_secondPhoneMask],
              style: AppTypography.bodyMedium,
            ),
            SizedBox(height: 12.h),
            AppTextField(
              controller: _secondEmailCtrl,
              label: 'Email',
              keyboardType: TextInputType.emailAddress,
            ),
          ],
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  // ────────────────────────────────────────────
  // STEP 2: Pricing & Financials
  // ────────────────────────────────────────────
  Widget _buildPricingStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // List price display
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: AppColors.surfaceVariant,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('List Price', style: AppTypography.bodyMedium),
              Text(
                '\$${_formatNumber(widget.property.listPrice)}',
                style: AppTypography.titleMedium
                    .copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        CurrencyInput(
          label: 'Purchase Price *',
          initialValue: _purchasePrice,
          onChanged: (v) => _purchasePrice = v,
        ),
        SizedBox(height: 16.h),
        DownPaymentSelector(
          selectedType:
              _loanType.isNotEmpty ? _loanType.split(' ').first : null,
          onTypeSelected: (type) => setState(() => _loanType = type),
          onPercentageChanged: (pct) {
            if (_purchasePrice > 0) {
              final pctVal = double.tryParse(pct.split('-').first) ?? 0;
              setState(() {
                _downPaymentAmount = _purchasePrice * pctVal / 100;
              });
            }
          },
        ),
        SizedBox(height: 16.h),
        CurrencyInput(
          label: 'Down Payment Amount',
          initialValue: _downPaymentAmount,
          onChanged: (v) => _downPaymentAmount = v,
        ),
        SizedBox(height: 16.h),
        // Deposit type dropdown
        DropdownButtonFormField<String>(
          value: _depositType,
          decoration:
              const InputDecoration(labelText: 'Earnest Money Deposit Type'),
          items: ['None', 'Check', 'Wire Transfer', 'Cash']
              .map((t) => DropdownMenuItem(value: t, child: Text(t)))
              .toList(),
          onChanged: (v) => setState(() => _depositType = v ?? 'None'),
        ),
        SizedBox(height: 16.h),
        CurrencyInput(
          label: 'Deposit Amount',
          initialValue: _depositAmount,
          onChanged: (v) => _depositAmount = v,
        ),
        SizedBox(height: 16.h),
        CurrencyInput(
          label: 'Seller Credit Request',
          initialValue: _creditRequest,
          onChanged: (v) => _creditRequest = v,
        ),
        SizedBox(height: 16.h),
        CurrencyInput(
          label: 'Additional Earnest Money',
          initialValue: _additionalEarnest,
          onChanged: (v) => _additionalEarnest = v,
        ),
        SizedBox(height: 16.h),
        CurrencyInput(
          label: 'Option Fee',
          initialValue: _optionFee,
          onChanged: (v) => _optionFee = v,
        ),
        SizedBox(height: 16.h),
        CurrencyInput(
          label: 'Home Warranty Coverage',
          initialValue: _coverageAmount,
          onChanged: (v) => _coverageAmount = v,
        ),
        SizedBox(height: 16.h),
        // Closing days
        AppTextField(
          controller: _closingDaysCtrl,
          label: 'Closing Days',
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 16.h),
        // Closing date picker
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text('Closing Date', style: AppTypography.bodyMedium),
          subtitle: Text(
            _closingDate != null
                ? '${_closingDate!.month}/${_closingDate!.day}/${_closingDate!.year}'
                : 'Select a date',
            style: AppTypography.bodySmall
                .copyWith(color: AppColors.textSecondary),
          ),
          trailing: const Icon(Icons.calendar_today, color: AppColors.primary),
          onTap: _pickClosingDate,
        ),
        SizedBox(height: 24.h),
      ],
    );
  }

  Future<void> _pickClosingDate() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: _closingDate ?? now.add(const Duration(days: 30)),
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );
    if (date != null) setState(() => _closingDate = date);
  }

  // ────────────────────────────────────────────
  // STEP 3: Conditions
  // ────────────────────────────────────────────
  Widget _buildConditionsStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Property Condition', style: AppTypography.labelLarge),
        SizedBox(height: 12.h),
        ...['As-Is', 'Good', 'Excellent'].map((c) => RadioListTile<String>(
              value: c,
              groupValue: _propertyCondition,
              onChanged: (v) => setState(() => _propertyCondition = v!),
              title: Text(c, style: AppTypography.bodyMedium),
              activeColor: AppColors.primary,
              contentPadding: EdgeInsets.zero,
            )),
        SizedBox(height: 20.h),
        Text('Pre-Approval Letter', style: AppTypography.labelLarge),
        SizedBox(height: 8.h),
        ...['Yes', 'No'].map((v) => RadioListTile<bool>(
              value: v == 'Yes',
              groupValue: _preApproval,
              onChanged: (val) => setState(() => _preApproval = val!),
              title: Text(v, style: AppTypography.bodyMedium),
              activeColor: AppColors.primary,
              contentPadding: EdgeInsets.zero,
            )),
        SizedBox(height: 20.h),
        Text('Survey Required', style: AppTypography.labelLarge),
        SizedBox(height: 8.h),
        ...['Yes', 'No'].map((v) => RadioListTile<bool>(
              value: v == 'Yes',
              groupValue: _survey,
              onChanged: (val) => setState(() => _survey = val!),
              title: Text(v, style: AppTypography.bodyMedium),
              activeColor: AppColors.primary,
              contentPadding: EdgeInsets.zero,
            )),
        SizedBox(height: 24.h),
      ],
    );
  }

  // ────────────────────────────────────────────
  // STEP 4: Title Company
  // ────────────────────────────────────────────
  Widget _buildTitleCompanyStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextField(
          controller: _titleCompanyCtrl,
          label: 'Title Company Name',
          prefixIcon: Icons.business,
        ),
        SizedBox(height: 20.h),
        Text('Title Company Choice', style: AppTypography.labelLarge),
        SizedBox(height: 8.h),
        ...['Buyer', 'Seller', 'Mutual'].map((c) => RadioListTile<String>(
              value: c,
              groupValue: _titleChoice,
              onChanged: (v) => setState(() => _titleChoice = v!),
              title: Text(c, style: AppTypography.bodyMedium),
              activeColor: AppColors.primary,
              contentPadding: EdgeInsets.zero,
            )),
        SizedBox(height: 24.h),
      ],
    );
  }

  // ────────────────────────────────────────────
  // STEP 5: Review
  // ────────────────────────────────────────────
  Widget _buildReviewStep() {
    final loanAmount = _purchasePrice - _downPaymentAmount;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _reviewSection('Property', [
          _reviewRow('Address',
              '${widget.property.address.streetNumber} ${widget.property.address.streetName}'),
          _reviewRow(
              'List Price', '\$${_formatNumber(widget.property.listPrice)}'),
        ]),
        _reviewSection('Buyer', [
          _reviewRow('Name', '${_firstNameCtrl.text} ${_lastNameCtrl.text}'),
          _reviewRow('Phone', _phoneCtrl.text),
          _reviewRow('Email', _emailCtrl.text),
          if (_hasSecondBuyer)
            _reviewRow('Second Buyer',
                '${_secondFirstNameCtrl.text} ${_secondLastNameCtrl.text}'),
        ]),
        _reviewSection('Pricing', [
          _reviewRow(
              'Purchase Price', '\$${_formatNumber(_purchasePrice.toInt())}'),
          _reviewRow('Loan Type', _loanType),
          _reviewRow(
              'Down Payment', '\$${_formatNumber(_downPaymentAmount.toInt())}'),
          _reviewRow('Loan Amount', '\$${_formatNumber(loanAmount.toInt())}'),
          _reviewRow('Deposit',
              '\$${_formatNumber(_depositAmount.toInt())} ($_depositType)'),
          if (_creditRequest > 0)
            _reviewRow(
                'Seller Credit', '\$${_formatNumber(_creditRequest.toInt())}'),
          if (_additionalEarnest > 0)
            _reviewRow('Additional Earnest',
                '\$${_formatNumber(_additionalEarnest.toInt())}'),
        ]),
        _reviewSection('Conditions', [
          _reviewRow('Property Condition', _propertyCondition),
          _reviewRow('Pre-Approval', _preApproval ? 'Yes' : 'No'),
          _reviewRow('Survey', _survey ? 'Yes' : 'No'),
        ]),
        _reviewSection('Title Company', [
          _reviewRow(
              'Company',
              _titleCompanyCtrl.text.isEmpty
                  ? 'Not specified'
                  : _titleCompanyCtrl.text),
          _reviewRow('Choice', _titleChoice),
        ]),
        if (_closingDate != null)
          _reviewSection('Closing', [
            _reviewRow('Date',
                '${_closingDate!.month}/${_closingDate!.day}/${_closingDate!.year}'),
            _reviewRow('Days', _closingDaysCtrl.text),
          ]),
        SizedBox(height: 24.h),
      ],
    );
  }

  Widget _reviewSection(String title, List<Widget> rows) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.h),
        Text(title,
            style: AppTypography.labelLarge.copyWith(color: AppColors.primary)),
        Divider(color: AppColors.divider, height: 16.h),
        ...rows,
      ],
    );
  }

  Widget _reviewRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: AppTypography.bodySmall
                  .copyWith(color: AppColors.textSecondary)),
          Flexible(
            child: Text(value,
                style: AppTypography.bodyMedium, textAlign: TextAlign.end),
          ),
        ],
      ),
    );
  }

  Widget _buildNavButtons() {
    return BlocBuilder<OfferBloc, OfferState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.fromLTRB(
              20.w, 12.h, 20.w, MediaQuery.of(context).padding.bottom + 12.h),
          decoration: BoxDecoration(
            color: AppColors.surface,
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: const Offset(0, -2))
            ],
          ),
          child: Row(
            children: [
              if (_currentStep > 0)
                Expanded(
                  child: AppButton(
                    label: 'Back',
                    isOutlined: true,
                    onPressed: _onBack,
                  ),
                ),
              if (_currentStep > 0) SizedBox(width: 12.w),
              Expanded(
                flex: _currentStep == 0 ? 1 : 1,
                child: AppButton(
                  label: _currentStep == 4
                      ? (widget.existingOffer != null
                          ? 'Update Offer'
                          : 'Submit Offer')
                      : 'Next',
                  isLoading: state.isSubmitting,
                  onPressed: _currentStep == 4 ? _onSubmit : _onNext,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String? _required(String? v) =>
      (v == null || v.trim().isEmpty) ? 'Required' : null;

  String? _emailValidator(String? v) {
    if (v == null || v.trim().isEmpty) return 'Required';
    if (!RegExp(r'^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,}$').hasMatch(v.trim())) {
      return 'Enter a valid email';
    }
    return null;
  }

  String _formatNumber(int n) {
    if (n == 0) return '0';
    final s = n.toString();
    final buf = StringBuffer();
    for (var i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write(',');
      buf.write(s[i]);
    }
    return buf.toString();
  }
}
