import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/app_widgets.dart';

/// Reusable property filter bottom sheet with clean design.
class PropertyFilterSheet extends StatefulWidget {
  final RangeValues initialPriceRange;
  final RangeValues initialSqftRange;
  final RangeValues initialYearRange;
  final int initialMinBeds;
  final int initialMinBaths;
  final Set<String> initialHomeTypes;
  final Function({
    int? minPrice,
    int? maxPrice,
    int? minBeds,
    int? minBaths,
    int? minSquareFeet,
    int? maxSquareFeet,
    int? minYearBuilt,
    int? maxYearBuilt,
    List<String>? homeTypes,
  }) onApply;
  final VoidCallback onClear;

  const PropertyFilterSheet({
    super.key,
    required this.initialPriceRange,
    required this.initialSqftRange,
    required this.initialYearRange,
    required this.initialMinBeds,
    required this.initialMinBaths,
    required this.initialHomeTypes,
    required this.onApply,
    required this.onClear,
  });

  @override
  State<PropertyFilterSheet> createState() => _PropertyFilterSheetState();
}

class _PropertyFilterSheetState extends State<PropertyFilterSheet> {
  static const int _defaultMaxPrice = 100000000;
  static const int _defaultMaxSqft = 500000;
  static const int _defaultMinYear = 1900;

  late TextEditingController _minPriceCtrl;
  late TextEditingController _maxPriceCtrl;
  late TextEditingController _minSqftCtrl;
  late TextEditingController _maxSqftCtrl;
  late TextEditingController _minYearCtrl;
  late TextEditingController _maxYearCtrl;

  late int _selectedBeds;
  late int _selectedBaths;
  late Set<String> _selectedHomeTypes;

  static const _homeTypeOptions = [
    'Single Family',
    'Condo',
    'Townhouse',
    'Multi-Family',
    'Land',
    'Other'
  ];

  int get _defaultMaxYear => DateTime.now().year + 10;

  @override
  void initState() {
    super.initState();
    _minPriceCtrl = TextEditingController(
      text: widget.initialPriceRange.start == 0
          ? ''
          : widget.initialPriceRange.start.toInt().toString(),
    );
    _maxPriceCtrl = TextEditingController(
      text: widget.initialPriceRange.end >= _defaultMaxPrice
          ? ''
          : widget.initialPriceRange.end.toInt().toString(),
    );
    _minSqftCtrl = TextEditingController(
      text: widget.initialSqftRange.start == 0
          ? ''
          : widget.initialSqftRange.start.toInt().toString(),
    );
    _maxSqftCtrl = TextEditingController(
      text: widget.initialSqftRange.end >= _defaultMaxSqft
          ? ''
          : widget.initialSqftRange.end.toInt().toString(),
    );
    _minYearCtrl = TextEditingController(
      text: widget.initialYearRange.start <= _defaultMinYear
          ? ''
          : widget.initialYearRange.start.toInt().toString(),
    );
    _maxYearCtrl = TextEditingController(
      text: widget.initialYearRange.end >= _defaultMaxYear
          ? ''
          : widget.initialYearRange.end.toInt().toString(),
    );
    _selectedBeds = widget.initialMinBeds;
    _selectedBaths = widget.initialMinBaths;
    _selectedHomeTypes = Set<String>.from(widget.initialHomeTypes);
  }

  @override
  void dispose() {
    _minPriceCtrl.dispose();
    _maxPriceCtrl.dispose();
    _minSqftCtrl.dispose();
    _maxSqftCtrl.dispose();
    _minYearCtrl.dispose();
    _maxYearCtrl.dispose();
    super.dispose();
  }

  int _parseValue(String text, int fallback) {
    final digitsOnly = text.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(digitsOnly) ?? fallback;
  }

  WidgetStateProperty<Color?> get _chipColor {
    return WidgetStateProperty.resolveWith<Color?>((states) {
      final isSelected = states.contains(WidgetState.selected);
      final isPressed = states.contains(WidgetState.pressed);

      if (isSelected) {
        return AppColors.primary.withValues(alpha: isPressed ? 0.22 : 0.15);
      }
      return isPressed
          ? AppColors.primary.withValues(alpha: 0.08)
          : AppColors.surfaceVariant;
    });
  }

  void _apply() {
    final minPrice = _parseValue(_minPriceCtrl.text, 0);
    final maxPrice = _parseValue(_maxPriceCtrl.text, _defaultMaxPrice);
    final minSqft = _parseValue(_minSqftCtrl.text, 0);
    final maxSqft = _parseValue(_maxSqftCtrl.text, _defaultMaxSqft);
    final minYear = _parseValue(_minYearCtrl.text, _defaultMinYear);
    final maxYear = _parseValue(_maxYearCtrl.text, _defaultMaxYear);

    widget.onApply(
      minPrice: minPrice > 0 ? minPrice : null,
      maxPrice: maxPrice < _defaultMaxPrice ? maxPrice : null,
      minBeds: _selectedBeds > 0 ? _selectedBeds : null,
      minBaths: _selectedBaths > 0 ? _selectedBaths : null,
      minSquareFeet: minSqft > 0 ? minSqft : null,
      maxSquareFeet: maxSqft < _defaultMaxSqft ? maxSqft : null,
      minYearBuilt: minYear > _defaultMinYear ? minYear : null,
      maxYearBuilt: maxYear < _defaultMaxYear ? maxYear : null,
      homeTypes:
          _selectedHomeTypes.isNotEmpty ? _selectedHomeTypes.toList() : null,
    );
    Navigator.pop(context);
  }

  void _clear() {
    widget.onClear();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (_, scrollController) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Padding(
                padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 16.h),
                child: Text(
                  'Filter Properties',
                  style: AppTypography.headlineSmall,
                  textAlign: TextAlign.start,
                ),
              ),
              const Divider(height: 1),

              // Scrollable content
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                  children: [
                    // Home Type
                    _SectionHeader('Home Type'),
                    SizedBox(height: 12.h),
                    _ChipWrapTheme(
                      child: Wrap(
                        spacing: 10.w,
                        runSpacing: 10.h,
                        children: _homeTypeOptions.map((type) {
                          final selected = _selectedHomeTypes.contains(type);
                          return FilterChip(
                            label: Text(type),
                            selected: selected,
                            color: _chipColor,
                            checkmarkColor: AppColors.primary,
                            side: BorderSide(
                              color: selected
                                  ? AppColors.primary
                                  : AppColors.border,
                            ),
                            labelStyle: AppTypography.labelSmall.copyWith(
                              color: selected
                                  ? AppColors.primaryDark
                                  : AppColors.textPrimary,
                              fontWeight: selected
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                            onSelected: (v) {
                              setState(() {
                                if (v) {
                                  _selectedHomeTypes.add(type);
                                } else {
                                  _selectedHomeTypes.remove(type);
                                }
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Price Range
                    _SectionHeader('Price Range'),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Expanded(
                          child: _CurrencyTextField(
                            controller: _minPriceCtrl,
                            label: 'Min Price',
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: _CurrencyTextField(
                            controller: _maxPriceCtrl,
                            label: 'Max Price',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),

                    // Bedrooms
                    _SectionHeader('Min Bedrooms'),
                    SizedBox(height: 12.h),
                    _ChipWrapTheme(
                      child: Wrap(
                        spacing: 10.w,
                        runSpacing: 10.h,
                        children: List.generate(
                          6,
                          (i) {
                            final selected = _selectedBeds == i;
                            return ChoiceChip(
                              label: Text(i == 0 ? 'Any' : '$i+'),
                              selected: selected,
                              showCheckmark: true,
                              checkmarkColor: AppColors.primaryDark,
                              color: _chipColor,
                              side: BorderSide(
                                color: selected
                                    ? AppColors.primary
                                    : AppColors.border,
                              ),
                              labelStyle: AppTypography.labelSmall.copyWith(
                                color: selected
                                    ? AppColors.primaryDark
                                    : AppColors.textPrimary,
                                fontWeight: selected
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                              ),
                              onSelected: (_) =>
                                  setState(() => _selectedBeds = i),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Bathrooms
                    _SectionHeader('Min Bathrooms'),
                    SizedBox(height: 12.h),
                    _ChipWrapTheme(
                      child: Wrap(
                        spacing: 10.w,
                        runSpacing: 10.h,
                        children: List.generate(
                          5,
                          (i) {
                            final selected = _selectedBaths == i;
                            return ChoiceChip(
                              label: Text(i == 0 ? 'Any' : '$i+'),
                              selected: selected,
                              showCheckmark: true,
                              checkmarkColor: AppColors.primaryDark,
                              color: _chipColor,
                              side: BorderSide(
                                color: selected
                                    ? AppColors.primary
                                    : AppColors.border,
                              ),
                              labelStyle: AppTypography.labelSmall.copyWith(
                                color: selected
                                    ? AppColors.primaryDark
                                    : AppColors.textPrimary,
                                fontWeight: selected
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                              ),
                              onSelected: (_) =>
                                  setState(() => _selectedBaths = i),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Square Footage
                    _SectionHeader('Square Footage'),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Expanded(
                          child: AppTextField(
                            controller: _minSqftCtrl,
                            label: 'Min Sqft',
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: AppTextField(
                            controller: _maxSqftCtrl,
                            label: 'Max Sqft',
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),

                    // Year Built
                    _SectionHeader('Year Built'),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Expanded(
                          child: AppTextField(
                            controller: _minYearCtrl,
                            label: 'Min Year',
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: AppTextField(
                            controller: _maxYearCtrl,
                            label: 'Max Year',
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),

              // Bottom buttons
              Container(
                padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 16.h),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _clear,
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                        ),
                        child: const Text('Clear'),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _apply,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                        ),
                        child: const Text('Apply Filters'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(title, style: AppTypography.titleMedium),
    );
  }
}

class _ChipWrapTheme extends StatelessWidget {
  final Widget child;
  const _ChipWrapTheme({required this.child});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashFactory: NoSplash.splashFactory,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      child: child,
    );
  }
}

class _CurrencyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const _CurrencyTextField({
    required this.controller,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        _CurrencyInputFormatter(),
      ],
      style: AppTypography.bodyMedium,
      decoration: InputDecoration(
        labelText: label,
        prefixText: '\$ ',
      ),
    );
  }
}

class _CurrencyInputFormatter extends TextInputFormatter {
  const _CurrencyInputFormatter();

  static final NumberFormat _format = NumberFormat.decimalPattern('en_US');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) {
      return const TextEditingValue(text: '');
    }

    final number = int.tryParse(digits);
    if (number == null) {
      return oldValue;
    }

    final formatted = _format.format(number);
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
