import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_typography.dart';

/// Signature capture pad using CustomPainter.
/// Returns PNG bytes via [onSigned] callback.
class SignaturePad extends StatefulWidget {
  final ValueChanged<Uint8List> onSigned;
  final VoidCallback? onClear;
  final Color penColor;
  final double penStrokeWidth;

  const SignaturePad({
    super.key,
    required this.onSigned,
    this.onClear,
    this.penColor = AppColors.textPrimary,
    this.penStrokeWidth = 2.5,
  });

  @override
  State<SignaturePad> createState() => _SignaturePadState();
}

class _SignaturePadState extends State<SignaturePad> {
  final List<List<Offset>> _strokes = [];
  List<Offset> _currentStroke = [];
  bool _hasDrawn = false;

  void _clear() {
    setState(() {
      _strokes.clear();
      _currentStroke = [];
      _hasDrawn = false;
    });
    widget.onClear?.call();
  }

  Future<void> _export() async {
    if (!_hasDrawn) return;

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final size = context.size ?? const Size(300, 150);

    // White background
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = Colors.white,
    );

    final paint = Paint()
      ..color = widget.penColor
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = widget.penStrokeWidth;

    for (final stroke in _strokes) {
      if (stroke.length < 2) continue;
      final path = Path()..moveTo(stroke.first.dx, stroke.first.dy);
      for (var i = 1; i < stroke.length; i++) {
        path.lineTo(stroke[i].dx, stroke[i].dy);
      }
      canvas.drawPath(path, paint);
    }

    final picture = recorder.endRecording();
    final img = await picture.toImage(size.width.toInt(), size.height.toInt());
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);

    if (byteData != null) {
      widget.onSigned(byteData.buffer.asUint8List());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Sign Below', style: AppTypography.labelLarge),
        SizedBox(height: 8.h),
        Container(
          height: 180.h,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.border, width: 1.5),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: GestureDetector(
              onPanStart: (d) {
                setState(() {
                  _currentStroke = [d.localPosition];
                  _hasDrawn = true;
                });
              },
              onPanUpdate: (d) {
                setState(() => _currentStroke.add(d.localPosition));
              },
              onPanEnd: (_) {
                setState(() {
                  _strokes.add(List.from(_currentStroke));
                  _currentStroke = [];
                });
              },
              child: CustomPaint(
                painter: _SignaturePainter(
                  strokes: _strokes,
                  currentStroke: _currentStroke,
                  color: widget.penColor,
                  strokeWidth: widget.penStrokeWidth,
                ),
                size: Size.infinite,
              ),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton.icon(
              onPressed: _clear,
              icon: Icon(Icons.refresh, size: 18.sp),
              label: const Text('Clear'),
            ),
            SizedBox(width: 12.w),
            FilledButton.icon(
              onPressed: _hasDrawn ? _export : null,
              icon: Icon(Icons.check, size: 18.sp),
              label: const Text('Confirm'),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SignaturePainter extends CustomPainter {
  final List<List<Offset>> strokes;
  final List<Offset> currentStroke;
  final Color color;
  final double strokeWidth;

  _SignaturePainter({
    required this.strokes,
    required this.currentStroke,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    for (final stroke in [...strokes, currentStroke]) {
      if (stroke.length < 2) continue;
      final path = Path()..moveTo(stroke.first.dx, stroke.first.dy);
      for (var i = 1; i < stroke.length; i++) {
        path.lineTo(stroke[i].dx, stroke[i].dy);
      }
      canvas.drawPath(path, paint);
    }

    // Draw baseline
    final linePaint = Paint()
      ..color = AppColors.border
      ..strokeWidth = 0.5;
    final y = size.height * 0.75;
    canvas.drawLine(Offset(20, y), Offset(size.width - 20, y), linePaint);
  }

  @override
  bool shouldRepaint(covariant _SignaturePainter old) => true;
}
