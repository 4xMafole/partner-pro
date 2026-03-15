import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';

class AppDropdown<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final String? labelText;
  final bool isDense;

  const AppDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.labelText,
    this.isDense = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DropdownButtonFormField<T>(
      value: value,
      items: items,
      onChanged: onChanged,
      icon: const Icon(Icons.keyboard_arrow_down_rounded),
      decoration: InputDecoration(
        labelText: labelText,
        isDense: isDense,
      ),
      dropdownColor: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(12),
      style: theme.textTheme.bodyMedium?.copyWith(
        color: AppColors.textPrimary,
      ),
    );
  }
}
