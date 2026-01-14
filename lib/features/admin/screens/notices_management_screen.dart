import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class NoticesManagementScreen extends StatefulWidget {
  const NoticesManagementScreen({super.key});

  @override
  State<NoticesManagementScreen> createState() => _NoticesManagementScreenState();
}

class _NoticesManagementScreenState extends State<NoticesManagementScreen> {
  final List<AdminNotice> _notices = [
    AdminNotice(
      id: '1',
      title: 'Annual General Meeting - Important',
      message: '''Dear Members,

This is to inform you that the Annual General Meeting for the year 2024 has been scheduled. All members are requested to attend without fail.

Date: 15th March 2024
Time: 10:00 AM
Venue: Tharavad Hall, Main Building

Please confirm your attendance by 10th March 2024.''',
      dateTime: DateTime.now().subtract(const Duration(hours: 2)),
      postedBy: 'Admin',
      status: 'Published',
      recipients: 256,
      readCount: 189,
    ),
    AdminNotice(
      id: '2',
      title: 'Monthly Contribution Reminder - March 2024',
      message: '''Dear Members,

This is a gentle reminder that the monthly contribution for March 2024 is due.

Amount: ₹500
Due Date: 10th March 2024

Thank you for your continued support.''',
      dateTime: DateTime.now().subtract(const Duration(days: 1)),
      postedBy: 'Treasurer',
      status: 'Published',
      recipients: 256,
      readCount: 210,
    ),
    AdminNotice(
      id: '3',
      title: 'Temple Festival Special Contribution',
      message: '''Dear Members,

As you are aware, our annual temple festival is approaching. We request all members to contribute generously.

Suggested Contribution: ₹4,000 (minimum)
Last Date: 25th March 2024''',
      dateTime: DateTime.now().subtract(const Duration(days: 3)),
      postedBy: 'President',
      status: 'Published',
      recipients: 256,
      readCount: 178,
    ),
    AdminNotice(
      id: '4',
      title: 'New Member Registration Update',
      message: '''We are pleased to announce that the online member registration portal is now live. New members can now register through the portal.''',
      dateTime: DateTime.now().subtract(const Duration(days: 5)),
      postedBy: 'Admin',
      status: 'Draft',
      recipients: 0,
      readCount: 0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;

    return SingleChildScrollView(
      padding: EdgeInsets.all(isDesktop ? 24 : 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Notices Management',
                    style: AppTextStyles.heading2.copyWith(
                      fontSize: isDesktop ? 28 : 22,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Create and manage announcements for members',
                    style: AppTextStyles.bodyMedium,
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () => _showCreateNoticeDialog(),
                icon: const Icon(Icons.add_rounded, size: 20),
                label: Text(isDesktop ? 'Create Notice' : 'Create'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop ? 24 : 16,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Stats
          if (isDesktop)
            Row(
              children: [
                _buildStatCard(
                  'Total Notices',
                  _notices.length.toString(),
                  Icons.campaign_rounded,
                  AppColors.primaryBlue,
                ),
                const SizedBox(width: 16),
                _buildStatCard(
                  'Published',
                  _notices.where((n) => n.status == 'Published').length.toString(),
                  Icons.check_circle_rounded,
                  AppColors.success,
                ),
                const SizedBox(width: 16),
                _buildStatCard(
                  'Drafts',
                  _notices.where((n) => n.status == 'Draft').length.toString(),
                  Icons.edit_note_rounded,
                  AppColors.warning,
                ),
                const SizedBox(width: 16),
                _buildStatCard(
                  'Avg. Read Rate',
                  '78%',
                  Icons.visibility_rounded,
                  Colors.purple,
                ),
              ],
            )
          else
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                SizedBox(
                  width: (MediaQuery.of(context).size.width - 44) / 2,
                  child: _buildStatCard(
                    'Total',
                    _notices.length.toString(),
                    Icons.campaign_rounded,
                    AppColors.primaryBlue,
                    compact: true,
                  ),
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width - 44) / 2,
                  child: _buildStatCard(
                    'Published',
                    _notices.where((n) => n.status == 'Published').length.toString(),
                    Icons.check_circle_rounded,
                    AppColors.success,
                    compact: true,
                  ),
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width - 44) / 2,
                  child: _buildStatCard(
                    'Drafts',
                    _notices.where((n) => n.status == 'Draft').length.toString(),
                    Icons.edit_note_rounded,
                    AppColors.warning,
                    compact: true,
                  ),
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width - 44) / 2,
                  child: _buildStatCard(
                    'Avg. Read',
                    '78%',
                    Icons.visibility_rounded,
                    Colors.purple,
                    compact: true,
                  ),
                ),
              ],
            ),
          const SizedBox(height: 24),

          // Notices List
          Container(
            decoration: BoxDecoration(
              color: AppColors.backgroundWhite,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'All Notices',
                        style: AppTextStyles.heading3.copyWith(fontSize: 18),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundLight,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'All Status',
                              style: AppTextStyles.bodySmall.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _notices.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    return _buildNoticeItem(_notices[index], isDesktop);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color, {
    bool compact = false,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(compact ? 16 : 20),
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(compact ? 10 : 12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: compact ? 20 : 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: AppTextStyles.heading3.copyWith(
                      fontSize: compact ? 18 : 22,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoticeItem(AdminNotice notice, bool isDesktop) {
    return InkWell(
      onTap: () => _showNoticeDetailsDialog(notice),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: isDesktop
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: notice.status == 'Published'
                          ? AppColors.success.withOpacity(0.1)
                          : AppColors.warning.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      notice.status == 'Published'
                          ? Icons.campaign_rounded
                          : Icons.edit_note_rounded,
                      color: notice.status == 'Published'
                          ? AppColors.success
                          : AppColors.warning,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                notice.title,
                                style: AppTextStyles.label.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            _buildStatusBadge(notice.status),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          notice.message.length > 150
                              ? '${notice.message.substring(0, 150)}...'
                              : notice.message,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            _buildInfoChip(
                              Icons.person_outline,
                              notice.postedBy,
                            ),
                            const SizedBox(width: 16),
                            _buildInfoChip(
                              Icons.schedule,
                              _formatDate(notice.dateTime),
                            ),
                            if (notice.status == 'Published') ...[
                              const SizedBox(width: 16),
                              _buildInfoChip(
                                Icons.people_outline,
                                '${notice.recipients} recipients',
                              ),
                              const SizedBox(width: 16),
                              _buildInfoChip(
                                Icons.visibility_outlined,
                                '${notice.readCount} read',
                              ),
                            ],
                            const Spacer(),
                            _buildActionButtons(notice),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: notice.status == 'Published'
                              ? AppColors.success.withOpacity(0.1)
                              : AppColors.warning.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          notice.status == 'Published'
                              ? Icons.campaign_rounded
                              : Icons.edit_note_rounded,
                          color: notice.status == 'Published'
                              ? AppColors.success
                              : AppColors.warning,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notice.title,
                              style: AppTextStyles.label.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${notice.postedBy} • ${_formatDate(notice.dateTime)}',
                              style: AppTextStyles.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      _buildStatusBadge(notice.status),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    notice.message.length > 100
                        ? '${notice.message.substring(0, 100)}...'
                        : notice.message,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (notice.status == 'Published') ...[
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(
                          Icons.people_outline,
                          size: 14,
                          color: AppColors.textLight,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${notice.recipients}',
                          style: AppTextStyles.bodySmall,
                        ),
                        const SizedBox(width: 12),
                        Icon(
                          Icons.visibility_outlined,
                          size: 14,
                          color: AppColors.textLight,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${notice.readCount} read',
                          style: AppTextStyles.bodySmall,
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _showEditNoticeDialog(notice),
                          icon: const Icon(Icons.edit_outlined, size: 18),
                          label: const Text('Edit'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.primaryBlue,
                            side: BorderSide(
                              color: AppColors.primaryBlue.withOpacity(0.3),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: notice.status == 'Draft'
                            ? ElevatedButton.icon(
                                onPressed: () => _publishNotice(notice),
                                icon: const Icon(Icons.send_rounded, size: 18),
                                label: const Text('Publish'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.success,
                                  foregroundColor: Colors.white,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              )
                            : ElevatedButton.icon(
                                onPressed: () =>
                                    _showNoticeDetailsDialog(notice),
                                icon: const Icon(
                                    Icons.visibility_outlined,
                                    size: 18),
                                label: const Text('View'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryBlue,
                                  foregroundColor: Colors.white,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    final color = status == 'Published' ? AppColors.success : AppColors.warning;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: AppColors.textLight),
        const SizedBox(width: 4),
        Text(
          text,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(AdminNotice notice) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () => _showEditNoticeDialog(notice),
          icon: const Icon(Icons.edit_outlined),
          iconSize: 20,
          color: AppColors.primaryBlue,
          tooltip: 'Edit',
        ),
        if (notice.status == 'Draft')
          IconButton(
            onPressed: () => _publishNotice(notice),
            icon: const Icon(Icons.send_rounded),
            iconSize: 20,
            color: AppColors.success,
            tooltip: 'Publish',
          ),
        IconButton(
          onPressed: () => _showDeleteConfirmation(notice),
          icon: const Icon(Icons.delete_outline),
          iconSize: 20,
          color: AppColors.error,
          tooltip: 'Delete',
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inMinutes < 60) {
      return '${diff.inMinutes}m ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours}h ago';
    } else if (diff.inDays < 7) {
      return '${diff.inDays}d ago';
    } else {
      final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
      return '${date.day} ${months[date.month - 1]} ${date.year}';
    }
  }

  void _showCreateNoticeDialog() {
    _showNoticeFormDialog(null);
  }

  void _showEditNoticeDialog(AdminNotice notice) {
    _showNoticeFormDialog(notice);
  }

  void _showNoticeFormDialog(AdminNotice? notice) {
    final isEditing = notice != null;
    final titleController = TextEditingController(text: notice?.title ?? '');
    final messageController = TextEditingController(text: notice?.message ?? '');

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600, maxHeight: 700),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isEditing ? 'Edit Notice' : 'Create Notice',
                    style: AppTextStyles.heading3,
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                'Title',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: 'Enter notice title',
                  hintStyle: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textLight,
                  ),
                  filled: true,
                  fillColor: AppColors.backgroundLight,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Message',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: TextField(
                  controller: messageController,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    hintText: 'Enter your message here...',
                    hintStyle: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textLight,
                    ),
                    filled: true,
                    fillColor: AppColors.backgroundLight,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(16),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // Save as draft
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Notice saved as draft'),
                            backgroundColor: AppColors.warning,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.warning,
                        side: BorderSide(color: AppColors.warning.withOpacity(0.5)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Save as Draft'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Notice published successfully'),
                            backgroundColor: AppColors.success,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.send_rounded, size: 18),
                      label: const Text('Publish Now'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.success,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showNoticeDetailsDialog(AdminNotice notice) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 550),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.campaign_rounded,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(notice.title, style: AppTextStyles.heading3),
                        const SizedBox(height: 4),
                        Text(
                          '${notice.postedBy} • ${_formatDate(notice.dateTime)}',
                          style: AppTextStyles.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  _buildStatusBadge(notice.status),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 16),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 300),
                child: SingleChildScrollView(
                  child: Text(
                    notice.message,
                    style: AppTextStyles.bodyMedium.copyWith(
                      height: 1.6,
                    ),
                  ),
                ),
              ),
              if (notice.status == 'Published') ...[
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundLight,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.people_rounded,
                              color: AppColors.primaryBlue,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              notice.recipients.toString(),
                              style: AppTextStyles.heading3.copyWith(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              'Recipients',
                              style: AppTextStyles.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundLight,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.visibility_rounded,
                              color: AppColors.success,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              notice.readCount.toString(),
                              style: AppTextStyles.heading3.copyWith(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              'Read',
                              style: AppTextStyles.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundLight,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.percent_rounded,
                              color: Colors.purple,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${((notice.readCount / notice.recipients) * 100).toStringAsFixed(0)}%',
                              style: AppTextStyles.heading3.copyWith(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              'Read Rate',
                              style: AppTextStyles.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.textSecondary,
                        side: BorderSide(color: AppColors.borderLight),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Close'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        _showEditNoticeDialog(notice);
                      },
                      icon: const Icon(Icons.edit_outlined, size: 18),
                      label: const Text('Edit Notice'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _publishNotice(AdminNotice notice) {
    setState(() {
      final index = _notices.indexWhere((n) => n.id == notice.id);
      if (index != -1) {
        _notices[index] = AdminNotice(
          id: notice.id,
          title: notice.title,
          message: notice.message,
          dateTime: DateTime.now(),
          postedBy: notice.postedBy,
          status: 'Published',
          recipients: 256,
          readCount: 0,
        );
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Notice published successfully'),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _showDeleteConfirmation(AdminNotice notice) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.warning_rounded,
                color: AppColors.error,
              ),
            ),
            const SizedBox(width: 12),
            const Text('Delete Notice'),
          ],
        ),
        content: Text(
          'Are you sure you want to delete "${notice.title}"? This action cannot be undone.',
          style: AppTextStyles.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _notices.removeWhere((n) => n.id == notice.id);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Notice deleted'),
                  backgroundColor: AppColors.error,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class AdminNotice {
  final String id;
  final String title;
  final String message;
  final DateTime dateTime;
  final String postedBy;
  final String status;
  final int recipients;
  final int readCount;

  AdminNotice({
    required this.id,
    required this.title,
    required this.message,
    required this.dateTime,
    required this.postedBy,
    required this.status,
    required this.recipients,
    required this.readCount,
  });
}
