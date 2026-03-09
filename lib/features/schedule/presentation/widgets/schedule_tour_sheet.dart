import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/app_widgets.dart';

/// Bottom sheet with a calendar and time grid for scheduling property tours.
class ScheduleTourSheet extends StatefulWidget {
  final String propertyAddress;
  final ValueChanged<DateTime> onDateSelected;

  const ScheduleTourSheet({
    super.key,
    required this.propertyAddress,
    required this.onDateSelected,
  });

  @override
  State<ScheduleTourSheet> createState() => _ScheduleTourSheetState();
}

class _ScheduleTourSheetState extends State<ScheduleTourSheet> {
  late DateTime _selectedDate;
  int? _selectedHour;

  // Predefined showing hours: 8 AM – 7 PM
  static const _hours = [8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19];

  @override
  void initState() {
    super.initState();
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    _selectedDate = DateTime(tomorrow.year, tomorrow.month, tomorrow.day);
  }

  String _formatHour(int hour) {
    if (hour == 12) return '12 PM';
    if (hour > 12) return '${hour - 12} PM';
    return '$hour AM';
  }

  void _onConfirm() {
    if (_selectedHour == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a preferred time.'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    final now = DateTime.now();
    final scheduled = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedHour!,
    );

    if (scheduled.isBefore(now)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a future date and time.'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    widget.onDateSelected(scheduled);
    Navigator.of(context).pop(scheduled);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.78,
      padding: EdgeInsets.fromLTRB(
          20.w, 16.h, 20.w, MediaQuery.of(context).padding.bottom + 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 36.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Text('Schedule a Tour', style: AppTypography.headlineSmall),
          SizedBox(height: 4.h),
          Text(
            widget.propertyAddress,
            style: AppTypography.bodySmall
                .copyWith(color: AppColors.textSecondary),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 12.h),
          // Calendar
          Expanded(
            child: Theme(
              data: Theme.of(context).copyWith(
                colorScheme: Theme.of(context).colorScheme.copyWith(
                      primary: AppColors.primary,
                      onPrimary: Colors.white,
                      surface: AppColors.surface,
                    ),
              ),
              child: CalendarDatePicker(
                initialDate: _selectedDate,
                firstDate: DateTime.now().add(const Duration(days: 1)),
                lastDate: DateTime.now().add(const Duration(days: 90)),
                onDateChanged: (date) => setState(() => _selectedDate = date),
              ),
            ),
          ),
          // Time label
          Row(
            children: [
              Icon(LucideIcons.clock, color: AppColors.primary, size: 18.sp),
              SizedBox(width: 8.w),
              Text('Select Preferred Time', style: AppTypography.labelLarge),
            ],
          ),
          SizedBox(height: 10.h),
          // Time grid
          SizedBox(
            height: 80.h,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8.w,
                crossAxisSpacing: 8.h,
                childAspectRatio: 0.45,
              ),
              itemCount: _hours.length,
              itemBuilder: (_, i) {
                final hour = _hours[i];
                final isSelected = _selectedHour == hour;
                return GestureDetector(
                  onTap: () => setState(() => _selectedHour = hour),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color:
                            isSelected ? AppColors.primary : AppColors.border,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Text(
                      _formatHour(hour),
                      style: AppTypography.labelSmall.copyWith(
                        color:
                            isSelected ? Colors.white : AppColors.textPrimary,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 16.h),
          AppButton(
            label: 'Confirm Tour',
            icon: LucideIcons.calendarCheck,
            onPressed: _onConfirm,
          ),
        ],
      ),
    );
  }
}
