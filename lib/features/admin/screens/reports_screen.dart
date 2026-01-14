import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  String _selectedPeriod = 'This Year';
  String _selectedReportType = 'Collection';

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
                    'Reports & Analytics',
                    style: AppTextStyles.heading2.copyWith(
                      fontSize: isDesktop ? 28 : 22,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'View insights and generate reports',
                    style: AppTextStyles.bodyMedium,
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundWhite,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.borderLight),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedPeriod,
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        items: ['This Month', 'This Quarter', 'This Year', 'All Time'].map((period) {
                          return DropdownMenuItem(
                            value: period,
                            child: Text(period, style: AppTextStyles.bodyMedium),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _selectedPeriod = value);
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: () => _showExportDialog(),
                    icon: const Icon(Icons.file_download_outlined, size: 20),
                    label: Text(isDesktop ? 'Export Report' : 'Export'),
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
            ],
          ),
          const SizedBox(height: 24),

          // Summary Cards
          if (isDesktop)
            Row(
              children: [
                _buildSummaryCard(
                  'Total Collection',
                  '₹41,50,000',
                  '+15.2%',
                  Icons.account_balance_wallet_rounded,
                  AppColors.success,
                  true,
                ),
                const SizedBox(width: 16),
                _buildSummaryCard(
                  'Active Members',
                  '256',
                  '+12',
                  Icons.people_rounded,
                  AppColors.primaryBlue,
                  true,
                ),
                const SizedBox(width: 16),
                _buildSummaryCard(
                  'Collection Rate',
                  '87.5%',
                  '+3.2%',
                  Icons.trending_up_rounded,
                  Colors.purple,
                  true,
                ),
                const SizedBox(width: 16),
                _buildSummaryCard(
                  'Pending Amount',
                  '₹3,20,000',
                  '-8.5%',
                  Icons.pending_actions_rounded,
                  AppColors.warning,
                  false,
                ),
              ],
            )
          else
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildSummaryCard(
                        'Total Collection',
                        '₹41.5L',
                        '+15.2%',
                        Icons.account_balance_wallet_rounded,
                        AppColors.success,
                        true,
                        compact: true,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildSummaryCard(
                        'Members',
                        '256',
                        '+12',
                        Icons.people_rounded,
                        AppColors.primaryBlue,
                        true,
                        compact: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildSummaryCard(
                        'Collection Rate',
                        '87.5%',
                        '+3.2%',
                        Icons.trending_up_rounded,
                        Colors.purple,
                        true,
                        compact: true,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildSummaryCard(
                        'Pending',
                        '₹3.2L',
                        '-8.5%',
                        Icons.pending_actions_rounded,
                        AppColors.warning,
                        false,
                        compact: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          const SizedBox(height: 24),

          // Charts Section
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: _buildCollectionChart(),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _buildContributionBreakdown(),
                ),
              ],
            )
          else
            Column(
              children: [
                _buildCollectionChart(),
                const SizedBox(height: 20),
                _buildContributionBreakdown(),
              ],
            ),
          const SizedBox(height: 20),

          // Report Types
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildMemberStats(),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _buildPaymentStats(),
                ),
              ],
            )
          else
            Column(
              children: [
                _buildMemberStats(),
                const SizedBox(height: 20),
                _buildPaymentStats(),
              ],
            ),
          const SizedBox(height: 20),

          // Available Reports
          _buildAvailableReports(isDesktop),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(
    String title,
    String value,
    String change,
    IconData icon,
    Color color,
    bool isPositive, {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(compact ? 8 : 10),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: color, size: compact ? 20 : 24),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isPositive
                        ? AppColors.success.withOpacity(0.1)
                        : AppColors.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isPositive
                            ? Icons.arrow_upward_rounded
                            : Icons.arrow_downward_rounded,
                        size: 12,
                        color: isPositive ? AppColors.success : AppColors.error,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        change,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: isPositive ? AppColors.success : AppColors.error,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: compact ? 12 : 16),
            Text(
              value,
              style: AppTextStyles.heading2.copyWith(
                fontSize: compact ? 20 : 24,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCollectionChart() {
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
                'Collection Trend',
                style: AppTextStyles.heading3.copyWith(fontSize: 18),
              ),
              Row(
                children: [
                  _buildLegendDot('This Year', AppColors.primaryBlue),
                  const SizedBox(width: 16),
                  _buildLegendDot('Last Year', AppColors.textLight),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 200,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(12, (index) {
                final months = ['J', 'F', 'M', 'A', 'M', 'J', 'J', 'A', 'S', 'O', 'N', 'D'];
                final values = [65, 72, 68, 85, 78, 92, 88, 95, 82, 76, 70, 68];
                final percentage = values[index] / 100;
                
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          child: Container(
                            width: double.infinity,
                            height: percentage * 160,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.primaryBlue,
                                  AppColors.primaryLight,
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          months[index],
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textLight,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendDot(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildContributionBreakdown() {
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
            'Contribution Breakdown',
            style: AppTextStyles.heading3.copyWith(fontSize: 18),
          ),
          const SizedBox(height: 20),
          _buildBreakdownItem('Monthly', '₹15,36,000', 0.37, AppColors.primaryBlue),
          _buildBreakdownItem('Festival', '₹18,24,000', 0.44, AppColors.success),
          _buildBreakdownItem('Special', '₹5,12,000', 0.12, Colors.purple),
          _buildBreakdownItem('Others', '₹2,78,000', 0.07, AppColors.warning),
        ],
      ),
    );
  }

  Widget _buildBreakdownItem(String label, String amount, double percentage, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    label,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Text(
                amount,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: percentage,
              backgroundColor: color.withOpacity(0.1),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMemberStats() {
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
            'Member Statistics',
            style: AppTextStyles.heading3.copyWith(fontSize: 18),
          ),
          const SizedBox(height: 20),
          _buildStatRow('Total Members', '256', Icons.people_rounded, AppColors.primaryBlue),
          _buildStatRow('Active', '218', Icons.check_circle_rounded, AppColors.success),
          _buildStatRow('Inactive', '23', Icons.cancel_rounded, AppColors.error),
          _buildStatRow('Pending', '15', Icons.schedule_rounded, AppColors.warning),
          _buildStatRow('New This Month', '8', Icons.person_add_rounded, Colors.purple),
        ],
      ),
    );
  }

  Widget _buildPaymentStats() {
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
            'Payment Statistics',
            style: AppTextStyles.heading3.copyWith(fontSize: 18),
          ),
          const SizedBox(height: 20),
          _buildStatRow('Total Transactions', '1,248', Icons.receipt_long_rounded, AppColors.primaryBlue),
          _buildStatRow('Completed', '1,189', Icons.check_circle_rounded, AppColors.success),
          _buildStatRow('Pending', '42', Icons.schedule_rounded, AppColors.warning),
          _buildStatRow('Failed', '17', Icons.error_rounded, AppColors.error),
          _buildStatRow('Avg. Amount', '₹3,325', Icons.analytics_rounded, Colors.purple),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, String value, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.bodyMedium,
            ),
          ),
          Text(
            value,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvailableReports(bool isDesktop) {
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
            'Available Reports',
            style: AppTextStyles.heading3.copyWith(fontSize: 18),
          ),
          const SizedBox(height: 20),
          if (isDesktop)
            Row(
              children: [
                _buildReportCard(
                  'Collection Report',
                  'Monthly and yearly collection summary',
                  Icons.account_balance_wallet_rounded,
                  AppColors.primaryBlue,
                ),
                const SizedBox(width: 16),
                _buildReportCard(
                  'Member Report',
                  'Member list with payment status',
                  Icons.people_rounded,
                  AppColors.success,
                ),
                const SizedBox(width: 16),
                _buildReportCard(
                  'Pending Report',
                  'Outstanding payments by member',
                  Icons.pending_actions_rounded,
                  AppColors.warning,
                ),
                const SizedBox(width: 16),
                _buildReportCard(
                  'Transaction Report',
                  'Detailed transaction history',
                  Icons.receipt_long_rounded,
                  Colors.purple,
                ),
              ],
            )
          else
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildReportCard(
                        'Collection',
                        'Collection summary',
                        Icons.account_balance_wallet_rounded,
                        AppColors.primaryBlue,
                        compact: true,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildReportCard(
                        'Members',
                        'Member list',
                        Icons.people_rounded,
                        AppColors.success,
                        compact: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildReportCard(
                        'Pending',
                        'Outstanding payments',
                        Icons.pending_actions_rounded,
                        AppColors.warning,
                        compact: true,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildReportCard(
                        'Transactions',
                        'Transaction history',
                        Icons.receipt_long_rounded,
                        Colors.purple,
                        compact: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildReportCard(
    String title,
    String description,
    IconData icon,
    Color color, {
    bool compact = false,
  }) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _generateReport(title),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: EdgeInsets.all(compact ? 12 : 16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: color.withOpacity(0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(compact ? 8 : 10),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: compact ? 20 : 24),
                ),
                SizedBox(height: compact ? 10 : 14),
                Text(
                  title,
                  style: AppTextStyles.label.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: compact ? 13 : 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: compact ? 11 : 12,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _generateReport(String reportType) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Generating $reportType...'),
        backgroundColor: AppColors.primaryBlue,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _showExportDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Export Report', style: AppTextStyles.heading3),
              const SizedBox(height: 8),
              Text(
                'Select the format and type of report to export',
                style: AppTextStyles.bodyMedium,
              ),
              const SizedBox(height: 24),
              Text(
                'Report Type',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.backgroundLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedReportType,
                    isExpanded: true,
                    items: ['Collection', 'Members', 'Payments', 'Summary'].map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _selectedReportType = value);
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Export Format',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildFormatOption('PDF', Icons.picture_as_pdf_rounded, AppColors.error),
                  const SizedBox(width: 12),
                  _buildFormatOption('Excel', Icons.table_chart_rounded, AppColors.success),
                  const SizedBox(width: 12),
                  _buildFormatOption('CSV', Icons.description_rounded, AppColors.primaryBlue),
                ],
              ),
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
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Report exported successfully'),
                            backgroundColor: AppColors.success,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.download_rounded, size: 18),
                      label: const Text('Export'),
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

  Widget _buildFormatOption(String label, IconData icon, Color color) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: color.withOpacity(0.3)),
            ),
            child: Column(
              children: [
                Icon(icon, color: color, size: 24),
                const SizedBox(height: 8),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
