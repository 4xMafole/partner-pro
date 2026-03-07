import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_typography.dart';

/// Formatted currency input field with $ prefix and comma separators.
class CurrencyInput extends StatefulWidget {
  final String label;
  final double initialValue;
  final ValueChanged<double> onChanged;
  final double maxValue;
  final String? Function(String?)? validator;

  const CurrencyInput({
    super.key,
    required this.label,
    this.initialValue = 0,
    required this.onChanged,
    this.maxValue = 999999999,
    this.validator,
  });

  @override
  State<CurrencyInput> createState() => _CurrencyInputState();
}

class _CurrencyInputState extends State<CurrencyInput> {
  late TextEditingController _controller;
  final _formatter = NumberFormat('#,##0', 'en_US');

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.initialValue > 0
          ? _formatter.format(widget.initialValue.toInt())
          : '',
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String text) {
    final cleaned = text.replaceAll(RegExp(r'[^0-9]'), '');
    final value = double.tryParse(cleaned) ?? 0;

    if (value > widget.maxValue) return;

    final formatted = cleaned.isEmpty ? '' : _formatter.format(value.toInt());

    _controller.value = TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );

    widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onChanged: _onChanged,
      validator: widget.validator,
      style: AppTypography.bodyMedium,
      decoration: InputDecoration(
        labelText: widget.label,
        prefixText: '\$ ',
        prefixStyle: AppTypography.bodyMedium.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
