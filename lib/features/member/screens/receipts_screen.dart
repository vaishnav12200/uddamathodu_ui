import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class Receipt {
  final String id;
  final String receiptNumber;
  final String memberName;
  final String memberId;
  final String contributionType;
  final double amount;
  final DateTime date;
  final String utrNumber;
  final String approvedBy;
  final String status;

  Receipt({
    required this.id,
    required this.receiptNumber,
    required this.memberName,
    required this.memberId,
    required this.contributionType,
    required this.amount,
    required this.date,
    required this.utrNumber,
    required this.approvedBy,
    required this.status,
  });
}

class ReceiptsScreen extends StatefulWidget {
  const ReceiptsScreen({super.key});

  @override
  State<ReceiptsScreen> createState() => _ReceiptsScreenState();
}

class _ReceiptsScreenState extends State<ReceiptsScreen> {
  String _selectedFilter = 'All';
  
  final List<String> _filters = ['All', 'Approved', 'Pending'];
  
  final List<Receipt> _receipts = [
    Receipt(
      id: '1',
      receiptNumber: 'RCP-2024-0125',
      memberName: 'Ramesh Varma',
      memberId: 'UM0251',
      contributionType: 'Monthly',
      amount: 500,
      date: DateTime(2024, 3, 5),
      utrNumber: '412345678901',
      approvedBy: 'Secretary',
      status: 'Approved',
    ),
    Receipt(
      id: '2',
      receiptNumber: 'RCP-2024-0098',
      memberName: 'Ramesh Varma',
      memberId: 'UM0251',
      contributionType: 'Annual',
      amount: 3000,
      date: DateTime(2024, 2, 10),
      utrNumber: '412345678902',
      approvedBy: 'Treasurer',
      status: 'Approved',
    ),
    Receipt(
      id: '3',
      receiptNumber: 'RCP-2024-0076',
      memberName: 'Ramesh Varma',
      memberId: 'UM0251',
      contributionType: 'Monthly',
      amount: 500,
      date: DateTime(2024, 1, 15),
      utrNumber: '412345678903',
      approvedBy: 'Secretary',
      status: 'Approved',
    ),
    Receipt(
      id: '4',
      receiptNumber: 'RCP-2023-0456',
      memberName: 'Ramesh Varma',
      memberId: 'UM0251',
      contributionType: 'Festival',
      amount: 4000,
      date: DateTime(2023, 12, 20),
      utrNumber: '412345678904',
      approvedBy: 'President',
      status: 'Approved',
    ),
    Receipt(
      id: '5',
      receiptNumber: 'Pending',
      memberName: 'Ramesh Varma',
      memberId: 'UM0251',
      contributionType: 'Monthly',
      amount: 500,
      date: DateTime(2024, 4, 1),
      utrNumber: '412345678907',
      approvedBy: '',
      status: 'Pending',
    ),
  ];

  List<Receipt> get _filteredReceipts {
    if (_selectedFilter == 'All') return _receipts;
    return _receipts.where((r) => r.status == _selectedFilter).toList();
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
          Text(
            'My Receipts',
            style: AppTextStyles.heading2.copyWith(
              fontSize: isSmall ? 22 : 28,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'View and download your payment receipts',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 24),
          
          // Stats Cards
          _buildStatsCards(isSmall),
          const SizedBox(height: 24),
          
          // Filters
          _buildFilters(),
          const SizedBox(height: 20),
          
          // Receipts Grid
          isSmall ? _buildMobileList() : _buildDesktopGrid(),
        ],
      ),
    );
  }

  Widget _buildStatsCards(bool isSmall) {
    final approved = _receipts.where((r) => r.status == 'Approved').length;
    final pending = _receipts.where((r) => r.status == 'Pending').length;
    
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            title: 'Total Receipts',
            value: _receipts.length.toString(),
            icon: Icons.receipt_long,
            color: AppColors.primaryBlue,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            title: 'Approved',
            value: approved.toString(),
            icon: Icons.check_circle,
            color: AppColors.success,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            title: 'Pending',
            value: pending.toString(),
            icon: Icons.hourglass_empty,
            color: AppColors.warning,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
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
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: AppTextStyles.heading3.copyWith(
                    fontSize: 20,
                    color: color,
                  ),
                ),
                Text(
                  title,
                  style: AppTextStyles.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: _filters.map((filter) {
          final isSelected = filter == _selectedFilter;
          return GestureDetector(
            onTap: () => setState(() => _selectedFilter = filter),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryBlue : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                filter,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : AppColors.textSecondary,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDesktopGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.1,
      ),
      itemCount: _filteredReceipts.length,
      itemBuilder: (context, index) {
        return _buildReceiptCard(_filteredReceipts[index]);
      },
    );
  }

  Widget _buildMobileList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _filteredReceipts.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return _buildReceiptCard(_filteredReceipts[index]);
      },
    );
  }

  Widget _buildReceiptCard(Receipt receipt) {
    final isApproved = receipt.status == 'Approved';
    
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isApproved ? AppColors.borderLight : AppColors.warning.withOpacity(0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isApproved 
                        ? AppColors.success.withOpacity(0.1)
                        : AppColors.warning.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.receipt_long,
                    color: isApproved ? AppColors.success : AppColors.warning,
                    size: 24,
                  ),
                ),
                _buildStatusBadge(receipt.status),
              ],
            ),
            const SizedBox(height: 16),
            
            // Receipt Number
            Text(
              receipt.receiptNumber,
              style: AppTextStyles.heading3.copyWith(
                fontSize: 16,
                color: isApproved ? AppColors.textPrimary : AppColors.textLight,
              ),
            ),
            const SizedBox(height: 8),
            
            // Details
            _buildDetailRow('Type', receipt.contributionType),
            _buildDetailRow('Amount', '₹${_formatAmount(receipt.amount)}'),
            _buildDetailRow('Date', _formatDate(receipt.date)),
            _buildDetailRow('UTR', receipt.utrNumber),
            if (isApproved)
              _buildDetailRow('Approved by', receipt.approvedBy),
            
            const Spacer(),
            
            // Actions
            if (isApproved)
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _viewReceipt(receipt),
                      icon: const Icon(Icons.visibility_outlined, size: 18),
                      label: const Text('View'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _downloadReceipt(receipt),
                      icon: const Icon(Icons.download_outlined, size: 18),
                      label: const Text('PDF'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                  ),
                ],
              )
            else
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.warning.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 16,
                      color: AppColors.warning,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Awaiting approval',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.warning,
                        fontWeight: FontWeight.w500,
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

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textLight,
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: AppTextStyles.bodySmall.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    final isApproved = status == 'Approved';
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isApproved 
            ? AppColors.success.withOpacity(0.15)
            : AppColors.warning.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: isApproved ? AppColors.success : AppColors.warning,
        ),
      ),
    );
  }

  void _viewReceipt(Receipt receipt) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          width: 450,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Close button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Receipt Preview', style: AppTextStyles.heading3),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Receipt Preview
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderLight),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    // Header
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.people_alt_rounded,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Uddamthodu Tharavad',
                      style: AppTextStyles.heading3.copyWith(fontSize: 18),
                    ),
                    Text(
                      'Management System',
                      style: AppTextStyles.bodySmall,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.success.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'PAYMENT RECEIPT',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.success,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 16),
                    
                    // Receipt Details
                    _buildReceiptDetailRow('Receipt No.', receipt.receiptNumber),
                    _buildReceiptDetailRow('Date', _formatDate(receipt.date)),
                    const Divider(height: 24),
                    _buildReceiptDetailRow('Member Name', receipt.memberName),
                    _buildReceiptDetailRow('Member ID', receipt.memberId),
                    const Divider(height: 24),
                    _buildReceiptDetailRow('Contribution Type', receipt.contributionType),
                    _buildReceiptDetailRow('Amount', '₹${_formatAmount(receipt.amount)}', isBold: true),
                    _buildReceiptDetailRow('UTR Number', receipt.utrNumber),
                    const Divider(height: 24),
                    _buildReceiptDetailRow('Approved By', receipt.approvedBy),
                    _buildReceiptDetailRow('Status', receipt.status),
                    
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.verified,
                            size: 16,
                            color: AppColors.success,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'This is a computer generated receipt',
                            style: AppTextStyles.bodySmall,
                          ),
                        ],
                      ),
                    ),
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
                        _downloadReceipt(receipt);
                      },
                      icon: const Icon(Icons.download),
                      label: const Text('Download PDF'),
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

  Widget _buildReceiptDetailRow(String label, String value, {bool isBold = false}) {
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
              fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
              color: isBold ? AppColors.primaryBlue : AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  void _downloadReceipt(Receipt receipt) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.download_done, color: Colors.white),
            const SizedBox(width: 12),
            Text('Downloading ${receipt.receiptNumber}.pdf...'),
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
