import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class Notice {
  final String id;
  final String title;
  final String message;
  final DateTime dateTime;
  final String postedBy;
  final bool isNew;

  Notice({
    required this.id,
    required this.title,
    required this.message,
    required this.dateTime,
    required this.postedBy,
    this.isNew = false,
  });
}

class NoticeBoardWidget extends StatelessWidget {
  final VoidCallback? onViewAllPressed;

  NoticeBoardWidget({
    super.key,
    this.onViewAllPressed,
  });

  final List<Notice> _sampleNotices = [
    Notice(
      id: '1',
      title: 'Annual Meeting',
      message: 'Annual general meeting scheduled for 15th March 2024 at Tharavad Hall. All members are requested to attend.',
      dateTime: DateTime.now().subtract(const Duration(hours: 2)),
      postedBy: 'Secretary',
      isNew: true,
    ),
    Notice(
      id: '2',
      title: 'Monthly Contribution Reminder',
      message: 'Please ensure monthly contributions for March 2024 are paid before 10th.',
      dateTime: DateTime.now().subtract(const Duration(days: 1)),
      postedBy: 'Treasurer',
      isNew: true,
    ),
    Notice(
      id: '3',
      title: 'Temple Festival Contribution',
      message: 'Special contribution for temple festival. Please contribute generously.',
      dateTime: DateTime.now().subtract(const Duration(days: 3)),
      postedBy: 'President',
      isNew: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.warning.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.campaign_rounded,
                        color: AppColors.warning,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Notice Board',
                      style: AppTextStyles.heading3.copyWith(fontSize: 18),
                    ),
                  ],
                ),
                if (onViewAllPressed != null)
                  TextButton(
                    onPressed: onViewAllPressed,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'View All',
                          style: AppTextStyles.link,
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.chevron_right_rounded,
                          size: 18,
                          color: AppColors.primaryBlue,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          
          const Divider(height: 1, color: AppColors.borderLight),
          
          // Notice List
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _sampleNotices.length > 3 ? 3 : _sampleNotices.length,
            separatorBuilder: (_, __) => const Divider(
              height: 1,
              color: AppColors.borderLight,
              indent: 20,
              endIndent: 20,
            ),
            itemBuilder: (context, index) {
              final notice = _sampleNotices[index];
              return _buildNoticeItem(notice);
            },
          ),
          
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildNoticeItem(Notice notice) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: notice.isNew 
                  ? AppColors.primaryBlue.withOpacity(0.1)
                  : AppColors.backgroundLight,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.notifications_outlined,
              color: notice.isNew 
                  ? AppColors.primaryBlue
                  : AppColors.textLight,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        notice.title,
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (notice.isNew)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.success.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'New',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: AppColors.success,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  notice.message,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.person_outline,
                      size: 14,
                      color: AppColors.textLight,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      notice.postedBy,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textLight,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.access_time,
                      size: 14,
                      color: AppColors.textLight,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _formatDateTime(notice.dateTime),
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textLight,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inMinutes < 60) {
      return '${diff.inMinutes}m ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours}h ago';
    } else if (diff.inDays < 7) {
      return '${diff.inDays}d ago';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }
}
