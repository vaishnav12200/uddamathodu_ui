import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class QuickActionsWidget extends StatelessWidget {
  final Function(String)? onActionTap;

  const QuickActionsWidget({
    super.key,
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
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
          Text(
            'Quick Actions',
            style: AppTextStyles.heading3.copyWith(fontSize: 18),
          ),
          const SizedBox(height: 20),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.5,
            children: [
              _buildActionCard(
                icon: Icons.person_add_rounded,
                title: 'Add Member',
                color: AppColors.primaryBlue,
                onTap: () => onActionTap?.call('add_member'),
              ),
              _buildActionCard(
                icon: Icons.receipt_long_rounded,
                title: 'Generate Receipt',
                color: AppColors.success,
                onTap: () => onActionTap?.call('generate_receipt'),
              ),
              _buildActionCard(
                icon: Icons.campaign_rounded,
                title: 'Send Notice',
                color: AppColors.warning,
                onTap: () => onActionTap?.call('send_notice'),
              ),
              _buildActionCard(
                icon: Icons.file_download_rounded,
                title: 'Export Report',
                color: Colors.purple,
                onTap: () => onActionTap?.call('export_report'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.2)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(height: 8),
              Text(
                title,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
