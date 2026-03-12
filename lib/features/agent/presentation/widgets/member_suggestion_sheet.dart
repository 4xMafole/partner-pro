import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/app_widgets.dart';

/// Contact data for member suggestion.
class MemberContact {
  final String id;
  final String name;
  final String email;
  final String? photoUrl;
  final bool isSuggested;

  const MemberContact({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    this.isSuggested = false,
  });
}

/// Bottom sheet for searching and suggesting a property to a contact/member.
class MemberSuggestionSheet extends StatefulWidget {
  final List<MemberContact> contacts;
  final ValueChanged<MemberContact> onSelected;
  final String propertyAddress;

  const MemberSuggestionSheet({
    super.key,
    required this.contacts,
    required this.onSelected,
    required this.propertyAddress,
  });

  @override
  State<MemberSuggestionSheet> createState() => _MemberSuggestionSheetState();
}

class _MemberSuggestionSheetState extends State<MemberSuggestionSheet> {
  final _searchCtrl = TextEditingController();
  List<MemberContact> _filtered = [];
  bool _showOnlyAvailable = false;

  @override
  void initState() {
    super.initState();
    _filtered = widget.contacts;
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _onSearch(String query) {
    final lower = query.toLowerCase();
    setState(() {
      _filtered = widget.contacts.where((c) {
        final matchesSearch = c.name.toLowerCase().contains(lower) ||
            c.email.toLowerCase().contains(lower);
        final matchesFilter = !_showOnlyAvailable || !c.isSuggested;
        return matchesSearch && matchesFilter;
      }).toList();
    });
  }

  void _toggleFilter() {
    setState(() {
      _showOnlyAvailable = !_showOnlyAvailable;
      _onSearch(_searchCtrl.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.7,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 12.h),
              width: 36.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.textTertiary,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Suggest Property', style: AppTypography.headlineSmall),
                SizedBox(height: 4.h),
                Text(
                  widget.propertyAddress,
                  style: AppTypography.bodySmall
                      .copyWith(color: AppColors.textSecondary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        controller: _searchCtrl,
                        hint: 'Search clients...',
                        prefixIcon: Icons.search,
                        onChanged: _onSearch,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    GestureDetector(
                      onTap: _toggleFilter,
                      child: Container(
                        padding: EdgeInsets.all(12.r),
                        decoration: BoxDecoration(
                          color: _showOnlyAvailable
                              ? AppColors.primary.withValues(alpha: 0.1)
                              : AppColors.divider,
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color: _showOnlyAvailable
                                ? AppColors.primary
                                : Colors.transparent,
                            width: 1.5,
                          ),
                        ),
                        child: Icon(
                          Icons.filter_list,
                          color: _showOnlyAvailable
                              ? AppColors.primary
                              : AppColors.textSecondary,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                if (_showOnlyAvailable)
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: Text(
                      'Showing available clients only',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.primary,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          Expanded(
            child: _filtered.isEmpty
                ? Center(
                    child: Text(
                      'No clients found',
                      style: AppTypography.bodyMedium
                          .copyWith(color: AppColors.textTertiary),
                    ),
                  )
                : ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    itemCount: _filtered.length,
                    separatorBuilder: (_, __) =>
                        Divider(color: AppColors.divider, height: 1),
                    itemBuilder: (_, i) {
                      final contact = _filtered[i];
                      return ListTile(
                        contentPadding: EdgeInsets.symmetric(vertical: 4.h),
                        enabled: !contact.isSuggested,
                        leading: CircleAvatar(
                          radius: 22.r,
                          backgroundColor:
                              AppColors.primary.withValues(alpha: 0.15),
                          backgroundImage: contact.photoUrl != null
                              ? NetworkImage(contact.photoUrl!)
                              : null,
                          child: contact.photoUrl == null
                              ? Text(
                                  contact.name.isNotEmpty
                                      ? contact.name[0].toUpperCase()
                                      : '?',
                                  style: AppTypography.titleMedium
                                      .copyWith(color: AppColors.primary),
                                )
                              : null,
                        ),
                        title:
                            Text(contact.name, style: AppTypography.bodyMedium),
                        trailing: Icon(
                          contact.isSuggested ? Icons.check_circle : Icons.send,
                          color: contact.isSuggested
                              ? AppColors.success
                              : AppColors.primary,
                          size: 20,
                        ),
                        subtitle: Text(
                          contact.isSuggested
                              ? 'Already suggested'
                              : contact.email,
                          style: AppTypography.bodySmall.copyWith(
                            color: contact.isSuggested
                                ? AppColors.success
                                : AppColors.textSecondary,
                          ),
                        ),
                        onTap: contact.isSuggested
                            ? null
                            : () {
                                widget.onSelected(contact);
                                Navigator.of(context).pop(contact);
                              },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
