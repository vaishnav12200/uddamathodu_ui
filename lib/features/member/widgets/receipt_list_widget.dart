import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class Receipt {
  final String id;
  final String receiptNumber;
  final String contributionType;
  final double amount;
  final DateTime date;
  final String utrNumber;
  final String status;

  Receipt({
    required this.id,
    required this.receiptNumber,
    required this.contributionType,
    required this.amount,
    required this.date,
    required this.utrNumber,
    required this.status,
  });
}

class ReceiptListWidget extends StatelessWidget {
  final VoidCallback? onViewAllPressed;

  ReceiptListWidget({
    super.key,
    this.onViewAllPressed,
  });

  final List<Receipt> _sampleReceipts = [
    Receipt(
      id: '1',
      receiptNumber: 'RCP-2024-0125',
      contributionType: 'Monthly',
      amount: 500,
      date: DateTime(2024, 3, 5),
      utrNumber: '412345678901',
      status: 'Approved',
    ),
    Receipt(
      id: '2',
      receiptNumber: 'RCP-2024-0098',
      contributionType: 'Annual',
      amount: 3000,
      date: DateTime(2024, 2, 10),
      utrNumber: '412345678902',
      status: 'Approved',
    ),
    Receipt(
      id: '3',
      receiptNumber: 'Pending',
      contributionType: 'Monthly',
      amount: 500,
      date: DateTime(2024, 1, 15),
      utrNumber: '412345678903',
      status: 'Pending',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 600;
    
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
                        color: AppColors.success.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.receipt_long_rounded,
                        color: AppColors.success,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Recent Receipts',
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
          
          // Receipt List
          if (isSmall)
            _buildMobileList()
          else
            _buildDesktopTable(),
          
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildDesktopTable() {
    return Column(
      children: [
        // Table Header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          color: AppColors.backgroundLight,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Receipt No.',
                  style: AppTextStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Type',
                  style: AppTextStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Amount',
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
                  'Date',
                  style: AppTextStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Status',
                  style: AppTextStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
            ],
          ),
        ),
        
        // Table Body
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _sampleReceipts.length,
          separatorBuilder: (_, __) => const Divider(
            height: 1,
            color: AppColors.borderLight,
          ),
          itemBuilder: (context, index) {
            final receipt = _sampleReceipts[index];
            return _buildDesktopRow(context, receipt);
          },
        ),
      ],
    );
  }

  Widget _buildDesktopRow(BuildContext context, Receipt receipt) {
    final isApproved = receipt.status.toLowerCase() == 'approved';
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              receipt.receiptNumber,
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w500,
                color: isApproved 
                    ? AppColors.textPrimary 
                    : AppColors.textLight,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              receipt.contributionType,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              '₹ ${_formatAmount(receipt.amount)}',
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              _formatDate(receipt.date),
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(child: _buildStatusBadge(receipt.status)),
          ),
          Expanded(
            flex: 1,
            child: isApproved 
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildActionButton(
                        icon: Icons.visibility_outlined,
                        onTap: () => _viewReceipt(context, receipt),
                        tooltip: 'View',
                      ),
                      const SizedBox(width: 8),
                      _buildActionButton(
                        icon: Icons.download_outlined,
                        onTap: () => _downloadReceipt(context, receipt),
                        tooltip: 'Download',
                      ),
                    ],
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _sampleReceipts.length,
      separatorBuilder: (_, __) => const Divider(
        height: 1,
        color: AppColors.borderLight,
      ),
      itemBuilder: (context, index) {
        final receipt = _sampleReceipts[index];
        return _buildMobileCard(context, receipt);
      },
    );
  }

  Widget _buildMobileCard(BuildContext context, Receipt receipt) {
    final isApproved = receipt.status.toLowerCase() == 'approved';
    
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                receipt.receiptNumber,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isApproved 
                      ? AppColors.textPrimary 
                      : AppColors.textLight,
                ),
              ),
              _buildStatusBadge(receipt.status),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    receipt.contributionType,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    _formatDate(receipt.date),
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textLight,
                    ),
                  ),
                ],
              ),
              Text(
                '₹ ${_formatAmount(receipt.amount)}',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlue,
                ),
              ),
            ],
          ),
          if (isApproved) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _viewReceipt(context, receipt),
                    icon: const Icon(Icons.visibility_outlined, size: 18),
                    label: const Text('View'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _downloadReceipt(context, receipt),
                    icon: const Icon(Icons.download_outlined, size: 18),
                    label: const Text('Download'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color bgColor;
    Color textColor;

    switch (status.toLowerCase()) {
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

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onTap,
    required String tooltip,
  }) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.backgroundLight,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 18,
              color: AppColors.primaryBlue,
            ),
          ),
        ),
      ),
    );
  }

  void _viewReceipt(BuildContext context, Receipt receipt) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Receipt Preview',
                    style: AppTextStyles.heading3,
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              
              // Receipt Content
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderLight),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    // Logo
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.people_alt_rounded,
                        color: AppColors.primaryBlue,
                        size: 32,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Uddamthodu Tharavad',
                      style: AppTextStyles.heading3,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Payment Receipt',
                      style: AppTextStyles.bodySmall,
                    ),
                    const SizedBox(height: 20),
                    
                    _buildReceiptRow('Receipt No.', receipt.receiptNumber),
                    _buildReceiptRow('Date', _formatDate(receipt.date)),
                    _buildReceiptRow('Member ID', 'UM0251'),
                    _buildReceiptRow('Type', receipt.contributionType),
                    _buildReceiptRow('Amount', '₹ ${_formatAmount(receipt.amount)}'),
                    _buildReceiptRow('UTR', receipt.utrNumber),
                    _buildReceiptRow('Status', receipt.status),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              
              // Actions
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                      label: const Text('Close'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        _downloadReceipt(context, receipt);
                      },
                      icon: const Icon(Icons.download_outlined),
                      label: const Text('Download'),
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

  Widget _buildReceiptRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            value,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _downloadReceipt(BuildContext context, Receipt receipt) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.download_done, color: Colors.white),
            const SizedBox(width: 12),
            Text('Downloading receipt ${receipt.receiptNumber}...'),
          ],
        ),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  String _formatAmount(double amount) {
    return amount.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}
