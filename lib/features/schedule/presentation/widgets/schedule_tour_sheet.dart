import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/app_widgets.dart';

/// Bottom sheet with a calendar for scheduling property tours.
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
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  TimeOfDay _selectedTime = const TimeOfDay(hour: 10, minute: 0);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.7,
      padding: EdgeInsets.fromLTRB(
          20.w, 16.h, 20.w, MediaQuery.of(context).padding.bottom + 16.h),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 36.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.textTertiary,
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
          SizedBox(height: 16.h),
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
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 90)),
                onDateChanged: (date) => setState(() => _selectedDate = date),
              ),
            ),
          ),
          // Time picker
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.access_time, color: AppColors.primary),
            title: Text('Preferred Time', style: AppTypography.bodyMedium),
            trailing: Text(
              _selectedTime.format(context),
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            onTap: _pickTime,
          ),
          SizedBox(height: 12.h),
          AppButton(
            label: 'Confirm Tour',
            icon: Icons.calendar_today,
            onPressed: () {
              final scheduled = DateTime(
                _selectedDate.year,
                _selectedDate.month,
                _selectedDate.day,
                _selectedTime.hour,
                _selectedTime.minute,
              );
              widget.onDateSelected(scheduled);
              Navigator.of(context).pop(scheduled);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (time != null) setState(() => _selectedTime = time);
  }
}
