import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class MemberListWidget extends StatelessWidget {
  final List<MemberData> members;
  final VoidCallback? onViewAll;
  final Function(MemberData)? onMemberTap;

  const MemberListWidget({
    super.key,
    required this.members,
    this.onViewAll,
    this.onMemberTap,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Members',
                style: AppTextStyles.heading3.copyWith(fontSize: 18),
              ),
              TextButton.icon(
                onPressed: onViewAll,
                icon: const Text('View All'),
                label: const Icon(Icons.arrow_forward_rounded, size: 18),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.primaryBlue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...members.map((member) => _buildMemberTile(member)).toList(),
        ],
      ),
    );
  }

  Widget _buildMemberTile(MemberData member) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onMemberTap?.call(member),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: AppColors.borderLight.withOpacity(0.5)),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    member.name.substring(0, 1).toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      member.name,
                      style: AppTextStyles.label.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'ID: ${member.memberId}',
                      style: AppTextStyles.bodySmall,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: member.status == 'Active'
                          ? AppColors.success.withOpacity(0.1)
                          : AppColors.warning.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      member.status,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: member.status == 'Active'
                            ? AppColors.success
                            : AppColors.warning,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    member.joinDate,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textLight,
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
}

class MemberData {
  final String name;
  final String memberId;
  final String status;
  final String joinDate;
  final String? phone;
  final String? email;
  final double? totalContribution;
  final double? pendingAmount;

  MemberData({
    required this.name,
    required this.memberId,
    required this.status,
    required this.joinDate,
    this.phone,
    this.email,
    this.totalContribution,
    this.pendingAmount,
  });
}
