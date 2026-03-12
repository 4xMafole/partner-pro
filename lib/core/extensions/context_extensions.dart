import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_typography.dart';

extension BuildContextX on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;
  MediaQueryData get mq => MediaQuery.of(this);
  Size get screenSize => mq.size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  EdgeInsets get padding => mq.padding;
  bool get isDark => theme.brightness == Brightness.dark;

  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message,
            style: AppTypography.bodyMedium.copyWith(color: Colors.white)),
        backgroundColor: isError ? AppColors.error : AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        margin: EdgeInsets.all(16.w),
      ),
    );
  }

  void showLoadingDialog() {
    showDialog(
      context: this,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
  }

  void hideLoadingDialog() {
    Navigator.of(this, rootNavigator: true).pop();
  }
}

extension StringX on String {
  String get capitalize =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';

  String get initials {
    final parts = trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return isNotEmpty ? this[0].toUpperCase() : '';
  }
}

extension DateTimeX on DateTime {
  String get timeAgo {
    final diff = DateTime.now().difference(this).abs();
    if (diff.inDays > 365) return '${diff.inDays ~/ 365}y ago';
    if (diff.inDays > 30) return '${diff.inDays ~/ 30}mo ago';
    if (diff.inDays > 0) return '${diff.inDays}d ago';
    if (diff.inHours > 0) return '${diff.inHours}h ago';
    if (diff.inMinutes > 0) return '${diff.inMinutes}m ago';
    return 'just now';
  }
}

/// Parse any dynamic timestamp representation into [DateTime].
/// Handles Firestore Timestamp, DateTime, ISO-8601 String,
/// Map ({seconds, nanoseconds}), and raw int (ms or s).
DateTime? parseDateTimeDynamic(dynamic value) {
  if (value == null) return null;
  if (value is DateTime) return value;
  if (value is String && value.trim().isNotEmpty) {
    return DateTime.tryParse(value);
  }
  if (value is Map) {
    final seconds = value['seconds'] ?? value['_seconds'];
    final nanoseconds = value['nanoseconds'] ?? value['_nanoseconds'];
    if (seconds is num) {
      final ms = (seconds.toInt() * 1000) +
          (nanoseconds is num ? nanoseconds.toInt() ~/ 1000000 : 0);
      return DateTime.fromMillisecondsSinceEpoch(ms);
    }
  }
  if (value is int) {
    return value > 1e12
        ? DateTime.fromMillisecondsSinceEpoch(value)
        : DateTime.fromMillisecondsSinceEpoch(value * 1000);
  }
  // Firestore Timestamp .toDate()
  try {
    final date = (value as dynamic).toDate();
    if (date is DateTime) return date;
  } catch (_) {}
  return null;
}

/// Convert any dynamic timestamp to a human-readable time-ago string.
String timeAgoFromDynamic(dynamic value) {
  final parsed = parseDateTimeDynamic(value);
  if (parsed == null) return '';
  return parsed.timeAgo;
}
