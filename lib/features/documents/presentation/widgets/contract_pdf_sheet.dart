import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/app_widgets.dart';

/// Bottom sheet for viewing a contract PDF with optional sign action.
class ContractPdfSheet extends StatefulWidget {
  final String pdfUrl;
  final String title;
  final VoidCallback? onSign;
  final VoidCallback? onDownload;

  const ContractPdfSheet({
    super.key,
    required this.pdfUrl,
    this.title = 'Contract',
    this.onSign,
    this.onDownload,
  });

  @override
  State<ContractPdfSheet> createState() => _ContractPdfSheetState();
}

class _ContractPdfSheetState extends State<ContractPdfSheet> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.85,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        children: [
          // Handle
          Container(
            margin: EdgeInsets.only(top: 12.h),
            width: 36.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: AppColors.textTertiary,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          // Header
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: AppTypography.headlineSmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.onDownload != null)
                      IconButton(
                        icon: const Icon(Icons.download,
                            color: AppColors.primary),
                        onPressed: widget.onDownload,
                      ),
                    IconButton(
                      icon: const Icon(Icons.close,
                          color: AppColors.textSecondary),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // PDF
          Expanded(
            child: Stack(
              children: [
                SfPdfViewer.network(
                  widget.pdfUrl,
                  onDocumentLoaded: (_) => setState(() => _isLoading = false),
                  onDocumentLoadFailed: (_) =>
                      setState(() => _isLoading = false),
                ),
                if (_isLoading)
                  const Center(
                      child:
                          CircularProgressIndicator(color: AppColors.primary)),
              ],
            ),
          ),
          // Sign button
          if (widget.onSign != null)
            Container(
              padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w,
                  MediaQuery.of(context).padding.bottom + 12.h),
              decoration: BoxDecoration(
                color: AppColors.surface,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: const Offset(0, -2))
                ],
              ),
              child: AppButton(
                label: 'Sign Document',
                icon: Icons.draw,
                onPressed: widget.onSign,
              ),
            ),
        ],
      ),
    );
  }
}
