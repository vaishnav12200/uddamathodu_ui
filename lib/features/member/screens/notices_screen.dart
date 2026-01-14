import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class Notice {
  final String id;
  final String title;
  final String message;
  final DateTime dateTime;
  final String postedBy;
  final String postedByRole;
  final bool isNew;

  Notice({
    required this.id,
    required this.title,
    required this.message,
    required this.dateTime,
    required this.postedBy,
    required this.postedByRole,
    this.isNew = false,
  });
}

class NoticesScreen extends StatelessWidget {
  const NoticesScreen({super.key});

  List<Notice> get _notices => [
    Notice(
      id: '1',
      title: 'Annual General Meeting - Important',
      message: '''Dear Members,

This is to inform you that the Annual General Meeting for the year 2024 has been scheduled. All members are requested to attend without fail.

Date: 15th March 2024
Time: 10:00 AM
Venue: Tharavad Hall, Main Building

Agenda:
1. Reading and approval of previous meeting minutes
2. Annual financial report presentation
3. Election of new office bearers
4. Discussion on upcoming events
5. Any other matters with the permission of chair

Please confirm your attendance by 10th March 2024.

Note: Light refreshments will be provided after the meeting.''',
      dateTime: DateTime.now().subtract(const Duration(hours: 2)),
      postedBy: 'Raghavan Nair',
      postedByRole: 'Secretary',
      isNew: true,
    ),
    Notice(
      id: '2',
      title: 'Monthly Contribution Reminder - March 2024',
      message: '''Dear Members,

This is a gentle reminder that the monthly contribution for March 2024 is due.

Amount: ₹500
Due Date: 10th March 2024

Payment Method: UPI
After making the payment, please log in to your account and enter the UTR number for verification.

For any queries, please contact the Treasurer.

Thank you for your continued support.''',
      dateTime: DateTime.now().subtract(const Duration(days: 1)),
      postedBy: 'Suresh Kumar',
      postedByRole: 'Treasurer',
      isNew: true,
    ),
    Notice(
      id: '3',
      title: 'Temple Festival Special Contribution',
      message: '''Dear Members,

As you are aware, our annual temple festival is approaching. We request all members to contribute generously for this auspicious occasion.

Suggested Contribution: ₹4,000 (minimum)
Last Date: 25th March 2024

Your contribution will be used for:
- Temple decoration
- Prasadam arrangements
- Cultural programs
- Guest accommodation

Please make your contributions at the earliest.

May the blessings of the Almighty be upon all of us.''',
      dateTime: DateTime.now().subtract(const Duration(days: 3)),
      postedBy: 'Krishnan Menon',
      postedByRole: 'President',
      isNew: false,
    ),
    Notice(
      id: '4',
      title: 'New Member Registration Update',
      message: '''Dear Members,

We are pleased to announce that the online member registration portal is now live. New members can now register through the portal.

Existing members are requested to update their profile information including:
- Mobile number
- Email address
- Current address
- Emergency contact

Please log in and update your details by 31st March 2024.

For any assistance, contact the Admin office.''',
      dateTime: DateTime.now().subtract(const Duration(days: 5)),
      postedBy: 'Admin Office',
      postedByRole: 'Admin',
      isNew: false,
    ),
    Notice(
      id: '5',
      title: 'Scholarship Applications Open',
      message: '''Dear Members,

Applications are invited for the Tharavad Educational Scholarship for the academic year 2024-25.

Eligibility:
- Children of members
- Studying in Class 10 or above
- Minimum 70% marks in previous examination

Documents Required:
- Mark sheet
- Income certificate
- Member ID proof
- Passport size photo

Last Date for Submission: 15th April 2024

Forms available at the Admin office or download from the portal.''',
      dateTime: DateTime.now().subtract(const Duration(days: 7)),
      postedBy: 'Raghavan Nair',
      postedByRole: 'Secretary',
      isNew: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 600;
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(isSmall ? 16 : 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Notice Board',
                      style: AppTextStyles.heading2.copyWith(
                        fontSize: isSmall ? 22 : 28,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Important announcements from the committee',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.warning.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 16,
                      color: AppColors.warning,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Auto-deletes after 15 days',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.warning,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Notice List
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _notices.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final notice = _notices[index];
              return _buildNoticeCard(context, notice, isSmall);
            },
          ),
          
          const SizedBox(height: 24),
          
          // Info Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.primaryBlue.withOpacity(0.2),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.policy_outlined,
                  color: AppColors.primaryBlue,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Notice Board Policy',
                        style: AppTextStyles.label.copyWith(
                          color: AppColors.primaryBlue,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Only committee members can post notices. Members can only read notices. Messages are text-only and auto-delete after 15 days.',
                        style: AppTextStyles.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoticeCard(BuildContext context, Notice notice, bool isSmall) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(16),
        border: notice.isNew 
            ? Border.all(color: AppColors.primaryBlue.withOpacity(0.3))
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _showNoticeDetail(context, notice),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: notice.isNew 
                            ? AppColors.primaryBlue.withOpacity(0.1)
                            : AppColors.backgroundLight,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.campaign_rounded,
                        color: notice.isNew 
                            ? AppColors.primaryBlue
                            : AppColors.textSecondary,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    
                    // Title & Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  notice.title,
                                  style: AppTextStyles.heading3.copyWith(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              if (notice.isNew)
                                Container(
                                  margin: const EdgeInsets.only(left: 8),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.success.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    'NEW',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.success,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              _buildInfoChip(
                                Icons.person_outline,
                                '${notice.postedBy} (${notice.postedByRole})',
                              ),
                              const SizedBox(width: 16),
                              _buildInfoChip(
                                Icons.access_time,
                                _formatDateTime(notice.dateTime),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Preview Message
                Text(
                  notice.message.split('\n').take(3).join('\n'),
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                
                // Read More
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Read More',
                      style: AppTextStyles.link.copyWith(fontSize: 13),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward,
                      size: 14,
                      color: AppColors.primaryBlue,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 14,
          color: AppColors.textLight,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textLight,
          ),
        ),
      ],
    );
  }

  void _showNoticeDetail(BuildContext context, Notice notice) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          width: 600,
          constraints: const BoxConstraints(maxHeight: 600),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.campaign_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            notice.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Posted by ${notice.postedBy} (${notice.postedByRole})',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close, color: Colors.white),
                    ),
                  ],
                ),
              ),
              
              // Content
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Date
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundLight,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 14,
                              color: AppColors.textSecondary,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              _formatFullDateTime(notice.dateTime),
                              style: AppTextStyles.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      
                      // Message
                      SelectableText(
                        notice.message,
                        style: AppTextStyles.bodyMedium.copyWith(
                          height: 1.7,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Footer
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.backgroundLight,
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Close'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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

  String _formatFullDateTime(DateTime dateTime) {
    final months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    final hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';
    return '${dateTime.day} ${months[dateTime.month - 1]} ${dateTime.year} at $hour:${dateTime.minute.toString().padLeft(2, '0')} $period';
  }
}
