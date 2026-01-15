import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class ContributionRecord {
  final String id;
  final String monthYear;
  final String contributionType;
  final double amount;
  final String paymentMode;
  final String utrNumber;
  final DateTime paymentDate;
  final String status;

  ContributionRecord({
    required this.id,
    required this.monthYear,
    required this.contributionType,
    required this.amount,
    required this.paymentMode,
    required this.utrNumber,
    required this.paymentDate,
    required this.status,
  });
}

class ContributionHistoryScreen extends StatefulWidget {
  const ContributionHistoryScreen({super.key});

  @override
  State<ContributionHistoryScreen> createState() => _ContributionHistoryScreenState();
}

class _ContributionHistoryScreenState extends State<ContributionHistoryScreen> {
  String _selectedFilter = 'All';
  String _selectedYear = '2024';
  
  final List<String> _filters = ['All', 'Monthly', 'Annual', 'Special', 'Festival'];
  final List<String> _years = ['2024', '2023', '2022', '2021'];
  
  final List<ContributionRecord> _contributions = [
    ContributionRecord(
      id: '1',
      monthYear: 'Mar 2024',
      contributionType: 'Monthly',
      amount: 500,
      paymentMode: 'UPI',
      utrNumber: '412345678901',
      paymentDate: DateTime(2024, 3, 5),
      status: 'Completed',
    ),
    ContributionRecord(
      id: '2',
      monthYear: 'Feb 2024',
      contributionType: 'Annual',
      amount: 3000,
      paymentMode: 'UPI',
      utrNumber: '412345678902',
      paymentDate: DateTime(2024, 2, 10),
      status: 'Completed',
    ),
    ContributionRecord(
      id: '3',
      monthYear: 'Jan 2024',
      contributionType: 'Monthly',
      amount: 500,
      paymentMode: 'UPI',
      utrNumber: '412345678903',
      paymentDate: DateTime(2024, 1, 15),
      status: 'Completed',
    ),
    ContributionRecord(
      id: '4',
      monthYear: 'Dec 2023',
      contributionType: 'Festival',
      amount: 4000,
      paymentMode: 'UPI',
      utrNumber: '412345678904',
      paymentDate: DateTime(2023, 12, 20),
      status: 'Completed',
    ),
    ContributionRecord(
      id: '5',
      monthYear: 'Nov 2023',
      contributionType: 'Monthly',
      amount: 500,
      paymentMode: 'UPI',
      utrNumber: '412345678905',
      paymentDate: DateTime(2023, 11, 8),
      status: 'Completed',
    ),
    ContributionRecord(
      id: '6',
      monthYear: 'Oct 2023',
      contributionType: 'Special',
      amount: 30000,
      paymentMode: 'UPI',
      utrNumber: '412345678906',
      paymentDate: DateTime(2023, 10, 15),
      status: 'Completed',
    ),
    ContributionRecord(
      id: '7',
      monthYear: 'Apr 2024',
      contributionType: 'Monthly',
      amount: 500,
      paymentMode: 'UPI',
      utrNumber: '412345678907',
      paymentDate: DateTime(2024, 4, 1),
      status: 'Pending',
    ),
  ];

  List<ContributionRecord> get _filteredContributions {
    var filtered = _contributions;
    
    if (_selectedFilter != 'All') {
      filtered = filtered.where((c) => c.contributionType == _selectedFilter).toList();
    }
    
    filtered = filtered.where((c) {
      return c.paymentDate.year.toString() == _selectedYear ||
             (_selectedYear == '2024' && c.paymentDate.year == 2024) ||
             (_selectedYear == '2023' && c.paymentDate.year == 2023);
    }).toList();
    
    return filtered;
  }

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Contribution History',
                style: AppTextStyles.heading2.copyWith(
                  fontSize: isSmall ? 22 : 28,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.account_balance_wallet,
                      size: 18,
                      color: AppColors.success,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Total: ₹${_formatAmount(_calculateTotal())}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.success,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Summary Cards
          _buildSummaryCards(isSmall),
          const SizedBox(height: 24),
          
          // Filters
          _buildFilters(isSmall),
          const SizedBox(height: 20),
          
          // Contribution List
          Container(
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
              children: [
                // Table Header (Desktop only)
                if (!isSmall)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundLight,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    child: Row(
                      children: [
                        _buildTableHeader('Month/Year', 2),
                        _buildTableHeader('Type', 2),
                        _buildTableHeader('Amount', 2, align: TextAlign.right),
                        _buildTableHeader('Payment Mode', 2),
                        _buildTableHeader('UTR Number', 3),
                        _buildTableHeader('Status', 2, align: TextAlign.center),
                      ],
                    ),
                  ),
                
                // List
                if (_filteredContributions.isNotEmpty)
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _filteredContributions.length,
                    separatorBuilder: (_, __) => const Divider(
                      height: 1,
                      color: AppColors.borderLight,
                    ),
                    itemBuilder: (context, index) {
                      final contribution = _filteredContributions[index];
                      return isSmall
                          ? _buildMobileRow(contribution)
                          : _buildDesktopRow(contribution);
                    },
                  ),
                
                if (_filteredContributions.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 48,
                          color: AppColors.textLight,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No contributions found',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
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

  Widget _buildSummaryCards(bool isSmall) {
    final summaries = [
      {
        'title': 'Monthly',
        'amount': _calculateByType('Monthly'),
        'color': AppColors.primaryBlue,
        'icon': Icons.calendar_month,
      },
      {
        'title': 'Annual',
        'amount': _calculateByType('Annual'),
        'color': AppColors.success,
        'icon': Icons.event,
      },
      {
        'title': 'Special',
        'amount': _calculateByType('Special'),
        'color': AppColors.warning,
        'icon': Icons.star,
      },
      {
        'title': 'Festival',
        'amount': _calculateByType('Festival'),
        'color': Colors.purple,
        'icon': Icons.celebration,
      },
    ];
    
    if (isSmall) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.5,
        ),
        itemCount: summaries.length,
        itemBuilder: (context, index) {
          final summary = summaries[index];
          return _buildSummaryCard(
            title: summary['title'] as String,
            amount: summary['amount'] as double,
            color: summary['color'] as Color,
            icon: summary['icon'] as IconData,
          );
        },
      );
    }
    
    return Row(
      children: summaries.map((summary) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: _buildSummaryCard(
              title: summary['title'] as String,
              amount: summary['amount'] as double,
              color: summary['color'] as Color,
              icon: summary['icon'] as IconData,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required double amount,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 18),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: AppTextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '₹${_formatAmount(amount)}',
            style: AppTextStyles.heading3.copyWith(
              fontSize: 18,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters(bool isSmall) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        // Type Filter
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.backgroundWhite,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.borderLight),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedFilter,
              items: _filters.map((filter) {
                return DropdownMenuItem(
                  value: filter,
                  child: Text(filter),
                );
              }).toList(),
              onChanged: (value) {
                setState(() => _selectedFilter = value!);
              },
            ),
          ),
        ),
        
        // Year Filter
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.backgroundWhite,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.borderLight),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedYear,
              items: _years.map((year) {
                return DropdownMenuItem(
                  value: year,
                  child: Text(year),
                );
              }).toList(),
              onChanged: (value) {
                setState(() => _selectedYear = value!);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTableHeader(String text, int flex, {TextAlign align = TextAlign.left}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: AppTextStyles.bodySmall.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.textSecondary,
        ),
        textAlign: align,
      ),
    );
  }

  Widget _buildDesktopRow(ContributionRecord contribution) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              contribution.monthYear,
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: _buildTypeBadge(contribution.contributionType),
          ),
          Expanded(
            flex: 2,
            child: Text(
              '₹ ${_formatAmount(contribution.amount)}',
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Icon(
                  Icons.account_balance_wallet,
                  size: 16,
                  color: AppColors.primaryBlue,
                ),
                const SizedBox(width: 6),
                Text(
                  contribution.paymentMode,
                  style: AppTextStyles.bodyMedium,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              contribution.utrNumber,
              style: AppTextStyles.bodySmall.copyWith(
                fontFamily: 'monospace',
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(child: _buildStatusBadge(contribution.status)),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileRow(ContributionRecord contribution) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                contribution.monthYear,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              _buildStatusBadge(contribution.status),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTypeBadge(contribution.contributionType),
              Text(
                '₹ ${_formatAmount(contribution.amount)}',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.receipt_outlined,
                size: 14,
                color: AppColors.textLight,
              ),
              const SizedBox(width: 4),
              Text(
                'UTR: ${contribution.utrNumber}',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textLight,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTypeBadge(String type) {
    Color color;
    switch (type.toLowerCase()) {
      case 'monthly':
        color = AppColors.primaryBlue;
        break;
      case 'annual':
        color = AppColors.success;
        break;
      case 'special':
        color = AppColors.warning;
        break;
      case 'festival':
        color = Colors.purple;
        break;
      default:
        color = AppColors.textLight;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        type,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: color,
        ),
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

  double _calculateTotal() {
    return _contributions
        .where((c) => c.status.toLowerCase() == 'completed')
        .fold(0.0, (sum, c) => sum + c.amount);
  }

  double _calculateByType(String type) {
    return _contributions
        .where((c) => c.contributionType == type && c.status.toLowerCase() == 'completed')
        .fold(0.0, (sum, c) => sum + c.amount);
  }

  String _formatAmount(double amount) {
    return amount.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }
}
