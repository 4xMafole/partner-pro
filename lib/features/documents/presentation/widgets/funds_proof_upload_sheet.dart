import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/services/file_service.dart';
import '../../../../core/widgets/app_widgets.dart';
import '../../../../core/widgets/editable_document_upload.dart';

/// Bottom sheet for uploading proof of funds documents.
class FundsProofUploadSheet extends StatefulWidget {
  final String userId;
  final FileService fileService;
  final ValueChanged<UploadedFileInfo>? onUploaded;

  const FundsProofUploadSheet({
    super.key,
    required this.userId,
    required this.fileService,
    this.onUploaded,
  });

  @override
  State<FundsProofUploadSheet> createState() => _FundsProofUploadSheetState();
}

class _FundsProofUploadSheetState extends State<FundsProofUploadSheet> {
  bool _isUploading = false;
  UploadedFileInfo? _uploaded;
  String? _error;

  Future<void> _pickAndUpload() async {
    setState(() {
      _isUploading = true;
      _error = null;
    });

    try {
      final picked = await widget.fileService.pickPdfFile();
      if (picked == null) {
        setState(() => _isUploading = false);
        return;
      }

      final uploaded = await widget.fileService.uploadFile(
        userId: widget.userId,
        directory: 'proof_of_funds',
        fileName: picked.fileName,
        base64Content: picked.base64Content,
      );

      setState(() {
        _uploaded = uploaded;
        _isUploading = false;
      });

      widget.onUploaded?.call(uploaded);
    } catch (e) {
      setState(() {
        _error = 'Upload failed: $e';
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          20.w, 16.h, 20.w, MediaQuery.of(context).padding.bottom + 20.h),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
          Text('Proof of Funds', style: AppTypography.headlineSmall),
          SizedBox(height: 4.h),
          Text(
            'Upload a bank statement or pre-approval letter (PDF, max 90 days old)',
            style: AppTypography.bodySmall
                .copyWith(color: AppColors.textSecondary),
          ),
          SizedBox(height: 20.h),
          if (_uploaded != null)
            EditableDocumentUpload(
              fileName: _uploaded!.fileName,
              onDelete: () => setState(() => _uploaded = null),
            )
          else
            DocumentUploadButton(
              label: 'Upload Proof of Funds',
              onTap: _pickAndUpload,
              isUploading: _isUploading,
            ),
          if (_error != null) ...[
            SizedBox(height: 12.h),
            Text(_error!,
                style:
                    AppTypography.bodySmall.copyWith(color: AppColors.error)),
          ],
          SizedBox(height: 20.h),
          AppButton(
            label: 'Done',
            onPressed: _uploaded != null
                ? () => Navigator.of(context).pop(_uploaded)
                : null,
          ),
        ],
      ),
    );
  }
}
