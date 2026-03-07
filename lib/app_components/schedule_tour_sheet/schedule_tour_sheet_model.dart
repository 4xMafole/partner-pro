import '/flutter_flow/flutter_flow_calendar.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'schedule_tour_sheet_widget.dart' show ScheduleTourSheetWidget;
import 'package:flutter/material.dart';

class ScheduleTourSheetModel extends FlutterFlowModel<ScheduleTourSheetWidget> {
  ///  Local state fields for this component.

  List<String> hours = [
    '8:00 AM',
    '9:00 AM',
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '1:00 PM',
    '2:00 PM',
    '3:00 PM',
    '4:00 PM',
    '5:00 PM',
    '6:00 PM',
    '7:00 PM'
  ];
  void addToHours(String item) => hours.add(item);
  void removeFromHours(String item) => hours.remove(item);
  void removeAtIndexFromHours(int index) => hours.removeAt(index);
  void insertAtIndexInHours(int index, String item) =>
      hours.insert(index, item);
  void updateHoursAtIndex(int index, Function(String) updateFn) =>
      hours[index] = updateFn(hours[index]);

  String? selectedTime;

  DateTime? selectedDate;

  ///  State fields for stateful widgets in this component.

  // State field(s) for Calendar widget.
  DateTimeRange? calendarSelectedDay;

  @override
  void initState(BuildContext context) {
    calendarSelectedDay = DateTimeRange(
      start: DateTime.now().startOfDay,
      end: DateTime.now().endOfDay,
    );
  }

  @override
  void dispose() {}
}
