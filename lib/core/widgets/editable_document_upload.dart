import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_typography.dart';

/// A row displaying an uploaded document with edit/delete actions.
class EditableDocumentUpload extends StatelessWidget {
  final String fileName;
  final String? fileSize;
  final VoidCallback? onView;
  final VoidCallback? onReplace;
  final VoidCallback? onDelete;
  final bool isUploading;

  const EditableDocumentUpload({
    super.key,
    required this.fileName,
    this.fileSize,
    this.onView,
    this.onReplace,
    this.onDelete,
    this.isUploading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: isUploading
                ? Padding(
                    padding: EdgeInsets.all(10.w),
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.primary,
                    ),
                  )
                : Icon(Icons.picture_as_pdf,
                    color: AppColors.primary, size: 22.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileName,
                  style: AppTypography.bodyMedium
                      .copyWith(fontWeight: FontWeight.w500),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (fileSize != null)
                  Text(
                    fileSize!,
                    style: AppTypography.bodySmall
                        .copyWith(color: AppColors.textTertiary),
                  ),
              ],
            ),
          ),
          if (onView != null)
            IconButton(
              onPressed: onView,
              icon: Icon(Icons.visibility_outlined, size: 20.sp),
              color: AppColors.textSecondary,
              visualDensity: VisualDensity.compact,
            ),
          if (onReplace != null)
            IconButton(
              onPressed: onReplace,
              icon: Icon(Icons.edit_outlined, size: 20.sp),
              color: AppColors.secondary,
              visualDensity: VisualDensity.compact,
            ),
          if (onDelete != null)
            IconButton(
              onPressed: onDelete,
              icon: Icon(Icons.delete_outline, size: 20.sp),
              color: AppColors.error,
              visualDensity: VisualDensity.compact,
            ),
        ],
      ),
    );
  }
}

/// A button to pick and upload a new document.
class DocumentUploadButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isUploading;

  const DocumentUploadButton({
    super.key,
    this.label = 'Upload Document',
    required this.onTap,
    this.isUploading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isUploading ? null : onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 24.h),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary, width: 1.5),
          borderRadius: BorderRadius.circular(12.r),
          color: AppColors.primary.withValues(alpha: 0.04),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isUploading)
              SizedBox(
                width: 24.w,
                height: 24.w,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.primary,
                ),
              )
            else
              Icon(Icons.cloud_upload_outlined,
                  color: AppColors.primary, size: 28.sp),
            SizedBox(height: 8.h),
            Text(
              label,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'PDF files only',
              style: AppTypography.bodySmall
                  .copyWith(color: AppColors.textTertiary),
            ),
          ],
        ),
      ),
    );
  }
}
