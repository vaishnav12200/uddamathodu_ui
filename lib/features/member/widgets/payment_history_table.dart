import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/localization/app_localizations.dart';

class PaymentRecord {
  final String monthYear;
  final String contributionType;
  final double amount;
  final String status;

  PaymentRecord({
    required this.monthYear,
    required this.contributionType,
    required this.amount,
    required this.status,
  });
}

class PaymentHistoryTable extends StatelessWidget {
  final VoidCallback? onViewAllPressed;

  PaymentHistoryTable({
    super.key,
    this.onViewAllPressed,
  });

  final List<PaymentRecord> _sampleData = [
    PaymentRecord(
      monthYear: 'Mar 2024',
      contributionType: 'Monthly',
      amount: 500,
      status: 'Completed',
    ),
    PaymentRecord(
      monthYear: 'Feb 2024',
      contributionType: 'Annual',
      amount: 3000,
      status: 'Completed',
    ),
    PaymentRecord(
      monthYear: 'Jan 2024',
      contributionType: 'Monthly',
      amount: 500,
      status: 'Completed',
    ),
    PaymentRecord(
      monthYear: 'Dec 2023',
      contributionType: 'Festival',
      amount: 4000,
      status: 'Completed',
    ),
    PaymentRecord(
      monthYear: 'Nov 2023',
      contributionType: 'Monthly',
      amount: 500,
      status: 'Completed',
    ),
    PaymentRecord(
      monthYear: 'Oct 2023',
      contributionType: 'Special',
      amount: 30000,
      status: 'Completed',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 600;
    final l10n = context.l10n;
    
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
                Text(
                  l10n.get('payment_history'),
                  style: AppTextStyles.heading3.copyWith(fontSize: 18),
                ),
                if (onViewAllPressed != null)
                  TextButton(
                    onPressed: onViewAllPressed,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          l10n.get('view_all'),
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
          
          // Table Header
          if (!isSmall)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              color: AppColors.backgroundLight,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      l10n.get('date'),
                      style: AppTextStyles.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      l10n.get('type'),
                      style: AppTextStyles.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      l10n.get('amount'),
                      style: AppTextStyles.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      l10n.get('status'),
                      style: AppTextStyles.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          
          // Table Body
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _sampleData.length,
            separatorBuilder: (_, __) => const Divider(
              height: 1,
              color: AppColors.borderLight,
            ),
            itemBuilder: (context, index) {
              final record = _sampleData[index];
              return isSmall
                  ? _buildMobileRow(record)
                  : _buildDesktopRow(record);
            },
          ),
          
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildDesktopRow(PaymentRecord record) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              record.monthYear,
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              record.contributionType,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              '₹ ${_formatAmount(record.amount)}',
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: _buildStatusBadge(record.status),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileRow(PaymentRecord record) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                record.monthYear,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              _buildStatusBadge(record.status),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                record.contributionType,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                '₹ ${_formatAmount(record.amount)}',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color bgColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'completed':
      case 'approved':
        bgColor = AppColors.success.withOpacity(0.15);
        textColor = AppColors.success;
        break;
      case 'pending':
      case 'pending confirmation':
        bgColor = AppColors.warning.withOpacity(0.15);
        textColor = AppColors.warning;
        break;
      case 'rejected':
        bgColor = AppColors.error.withOpacity(0.15);
        textColor = AppColors.error;
        break;
      default:
        bgColor = AppColors.textLight.withOpacity(0.15);
        textColor = AppColors.textLight;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }

  String _formatAmount(double amount) {
    return amount.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }
}
