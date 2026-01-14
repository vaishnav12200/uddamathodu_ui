import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class ReceiptsManagementScreen extends StatefulWidget {
  const ReceiptsManagementScreen({super.key});

  @override
  State<ReceiptsManagementScreen> createState() => _ReceiptsManagementScreenState();
}

class _ReceiptsManagementScreenState extends State<ReceiptsManagementScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All';
  String _selectedDateRange = 'This Month';

  final List<Receipt> _receipts = [
    Receipt(
      id: 'REC001',
      memberId: 'UM0251',
      memberName: 'Ramesh Varma',
      amount: 500,
      type: 'Monthly Contribution',
      date: DateTime.now().subtract(const Duration(hours: 2)),
      status: 'Generated',
      paymentId: 'PAY001',
    ),
    Receipt(
      id: 'REC002',
      memberId: 'UM0250',
      memberName: 'Suresh Kumar',
      amount: 4000,
      type: 'Temple Festival',
      date: DateTime.now().subtract(const Duration(days: 1)),
      status: 'Sent',
      paymentId: 'PAY002',
    ),
    Receipt(
      id: 'REC003',
      memberId: 'UM0248',
      memberName: 'Vijayan Nambiar',
      amount: 1000,
      type: 'Special Contribution',
      date: DateTime.now().subtract(const Duration(days: 3)),
      status: 'Sent',
      paymentId: 'PAY004',
    ),
    Receipt(
      id: 'REC004',
      memberId: 'UM0246',
      memberName: 'Anil Kumar',
      amount: 2500,
      type: 'Arrears',
      date: DateTime.now().subtract(const Duration(days: 5)),
      status: 'Downloaded',
      paymentId: 'PAY006',
    ),
    Receipt(
      id: 'REC005',
      memberId: 'UM0003',
      memberName: 'Suresh Kumar',
      amount: 500,
      type: 'Monthly Contribution',
      date: DateTime.now().subtract(const Duration(days: 7)),
      status: 'Generated',
      paymentId: 'PAY007',
    ),
  ];

  List<Receipt> get _filteredReceipts {
    var filtered = _receipts;

    if (_selectedFilter != 'All') {
      filtered = filtered.where((r) => r.status == _selectedFilter).toList();
    }

    if (_searchController.text.isNotEmpty) {
      final query = _searchController.text.toLowerCase();
      filtered = filtered.where((r) =>
        r.memberName.toLowerCase().contains(query) ||
        r.memberId.toLowerCase().contains(query) ||
        r.id.toLowerCase().contains(query)
      ).toList();
    }

    return filtered;
  }

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
                    'Receipts Management',
                    style: AppTextStyles.heading2.copyWith(
                      fontSize: isDesktop ? 28 : 22,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Generate and manage payment receipts',
                    style: AppTextStyles.bodyMedium,
                  ),
                ],
              ),
              Row(
                children: [
                  OutlinedButton.icon(
                    onPressed: () => _showBulkGenerateDialog(),
                    icon: const Icon(Icons.auto_awesome_rounded, size: 20),
                    label: Text(isDesktop ? 'Bulk Generate' : 'Bulk'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primaryBlue,
                      side: BorderSide(color: AppColors.primaryBlue.withOpacity(0.3)),
                      padding: EdgeInsets.symmetric(
                        horizontal: isDesktop ? 20 : 12,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: () => _showGenerateReceiptDialog(),
                    icon: const Icon(Icons.receipt_long_rounded, size: 20),
                    label: Text(isDesktop ? 'Generate Receipt' : 'Generate'),
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

          // Stats
          if (isDesktop)
            Row(
              children: [
                _buildStatCard(
                  'Total Receipts',
                  _receipts.length.toString(),
                  Icons.receipt_long_rounded,
                  AppColors.primaryBlue,
                ),
                const SizedBox(width: 16),
                _buildStatCard(
                  'Generated',
                  _receipts.where((r) => r.status == 'Generated').length.toString(),
                  Icons.description_rounded,
                  AppColors.warning,
                ),
                const SizedBox(width: 16),
                _buildStatCard(
                  'Sent',
                  _receipts.where((r) => r.status == 'Sent').length.toString(),
                  Icons.send_rounded,
                  AppColors.success,
                ),
                const SizedBox(width: 16),
                _buildStatCard(
                  'Downloaded',
                  _receipts.where((r) => r.status == 'Downloaded').length.toString(),
                  Icons.download_done_rounded,
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
                    _receipts.length.toString(),
                    Icons.receipt_long_rounded,
                    AppColors.primaryBlue,
                    compact: true,
                  ),
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width - 44) / 2,
                  child: _buildStatCard(
                    'Generated',
                    _receipts.where((r) => r.status == 'Generated').length.toString(),
                    Icons.description_rounded,
                    AppColors.warning,
                    compact: true,
                  ),
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width - 44) / 2,
                  child: _buildStatCard(
                    'Sent',
                    _receipts.where((r) => r.status == 'Sent').length.toString(),
                    Icons.send_rounded,
                    AppColors.success,
                    compact: true,
                  ),
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width - 44) / 2,
                  child: _buildStatCard(
                    'Downloaded',
                    _receipts.where((r) => r.status == 'Downloaded').length.toString(),
                    Icons.download_done_rounded,
                    Colors.purple,
                    compact: true,
                  ),
                ),
              ],
            ),
          const SizedBox(height: 24),

          // Receipts List
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
              children: [
                // Search and Filters
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: isDesktop
                      ? Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: _buildSearchField(),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildFilterDropdown(),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildDateRangeSelector(),
                            ),
                            const SizedBox(width: 16),
                            _buildExportButton(),
                          ],
                        )
                      : Column(
                          children: [
                            _buildSearchField(),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(child: _buildFilterDropdown()),
                                const SizedBox(width: 12),
                                _buildExportButton(),
                              ],
                            ),
                          ],
                        ),
                ),

                // Receipts Table/List
                if (isDesktop)
                  _buildDesktopTable()
                else
                  _buildMobileList(),
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

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      onChanged: (value) => setState(() {}),
      decoration: InputDecoration(
        hintText: 'Search receipts...',
        hintStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textLight,
        ),
        prefixIcon: const Icon(
          Icons.search_rounded,
          color: AppColors.textLight,
        ),
        filled: true,
        fillColor: AppColors.backgroundLight,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildFilterDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedFilter,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          items: ['All', 'Generated', 'Sent', 'Downloaded'].map((filter) {
            return DropdownMenuItem(
              value: filter,
              child: Text(
                filter == 'All' ? 'All Status' : filter,
                style: AppTextStyles.bodyMedium,
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() => _selectedFilter = value);
            }
          },
        ),
      ),
    );
  }

  Widget _buildDateRangeSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedDateRange,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          items: ['Today', 'This Week', 'This Month', 'This Year'].map((range) {
            return DropdownMenuItem(
              value: range,
              child: Text(range, style: AppTextStyles.bodyMedium),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() => _selectedDateRange = value);
            }
          },
        ),
      ),
    );
  }

  Widget _buildExportButton() {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.file_download_outlined, size: 20),
      label: const Text('Export'),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryBlue,
        side: BorderSide(color: AppColors.primaryBlue.withOpacity(0.3)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildDesktopTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: WidgetStateProperty.all(AppColors.backgroundLight),
        headingTextStyle: AppTextStyles.label.copyWith(
          fontWeight: FontWeight.w600,
        ),
        dataRowMaxHeight: 70,
        columns: const [
          DataColumn(label: Text('Receipt ID')),
          DataColumn(label: Text('Member')),
          DataColumn(label: Text('Amount')),
          DataColumn(label: Text('Type')),
          DataColumn(label: Text('Date')),
          DataColumn(label: Text('Status')),
          DataColumn(label: Text('Actions')),
        ],
        rows: _filteredReceipts.map((receipt) {
          return DataRow(
            cells: [
              DataCell(
                Text(
                  receipt.id,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              DataCell(
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      receipt.memberName,
                      style: AppTextStyles.label.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      receipt.memberId,
                      style: AppTextStyles.bodySmall,
                    ),
                  ],
                ),
              ),
              DataCell(
                Text(
                  '₹${receipt.amount.toStringAsFixed(0)}',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.success,
                  ),
                ),
              ),
              DataCell(Text(receipt.type)),
              DataCell(Text(_formatDate(receipt.date))),
              DataCell(_buildStatusBadge(receipt.status)),
              DataCell(
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () => _showReceiptPreview(receipt),
                      icon: const Icon(Icons.visibility_outlined),
                      iconSize: 20,
                      color: AppColors.primaryBlue,
                      tooltip: 'View',
                    ),
                    IconButton(
                      onPressed: () => _downloadReceipt(receipt),
                      icon: const Icon(Icons.download_outlined),
                      iconSize: 20,
                      color: AppColors.success,
                      tooltip: 'Download',
                    ),
                    IconButton(
                      onPressed: () => _sendReceipt(receipt),
                      icon: const Icon(Icons.send_outlined),
                      iconSize: 20,
                      color: Colors.purple,
                      tooltip: 'Send',
                    ),
                  ],
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMobileList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: _filteredReceipts.length,
      separatorBuilder: (_, __) => const Divider(height: 24),
      itemBuilder: (context, index) {
        final receipt = _filteredReceipts[index];
        return _buildReceiptCard(receipt);
      },
    );
  }

  Widget _buildReceiptCard(Receipt receipt) {
    return InkWell(
      onTap: () => _showReceiptPreview(receipt),
      borderRadius: BorderRadius.circular(12),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.receipt_long_rounded,
                  color: AppColors.primaryBlue,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          receipt.id,
                          style: AppTextStyles.label.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        _buildStatusBadge(receipt.status),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${receipt.memberName} (${receipt.memberId})',
                      style: AppTextStyles.bodySmall,
                    ),
                  ],
                ),
              ),
              Text(
                '₹${receipt.amount.toStringAsFixed(0)}',
                style: AppTextStyles.heading3.copyWith(
                  color: AppColors.success,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 14,
                color: AppColors.textLight,
              ),
              const SizedBox(width: 4),
              Text(
                _formatDate(receipt.date),
                style: AppTextStyles.bodySmall,
              ),
              const SizedBox(width: 16),
              Icon(
                Icons.category_outlined,
                size: 14,
                color: AppColors.textLight,
              ),
              const SizedBox(width: 4),
              Text(
                receipt.type,
                style: AppTextStyles.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _downloadReceipt(receipt),
                  icon: const Icon(Icons.download_outlined, size: 18),
                  label: const Text('Download'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primaryBlue,
                    side: BorderSide(color: AppColors.primaryBlue.withOpacity(0.3)),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _sendReceipt(receipt),
                  icon: const Icon(Icons.send_outlined, size: 18),
                  label: const Text('Send'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 10),
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
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color;
    switch (status) {
      case 'Generated':
        color = AppColors.warning;
        break;
      case 'Sent':
        color = AppColors.success;
        break;
      case 'Downloaded':
        color = Colors.purple;
        break;
      default:
        color = AppColors.textSecondary;
    }

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

  String _formatDate(DateTime date) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  void _showGenerateReceiptDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 450),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Generate Receipt', style: AppTextStyles.heading3),
              const SizedBox(height: 8),
              Text(
                'Create a receipt for a completed payment',
                style: AppTextStyles.bodyMedium,
              ),
              const SizedBox(height: 24),
              _buildFormField(
                label: 'Select Payment',
                hint: 'Search payment or member',
                icon: Icons.search_rounded,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.backgroundLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Payment Details',
                      style: AppTextStyles.label.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildDetailRow('Member', 'Select a payment first'),
                    _buildDetailRow('Amount', '-'),
                    _buildDetailRow('Type', '-'),
                    _buildDetailRow('Date', '-'),
                  ],
                ),
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
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Receipt generated successfully'),
                            backgroundColor: AppColors.success,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Generate'),
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

  void _showBulkGenerateDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.auto_awesome_rounded,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text('Bulk Generate Receipts', style: AppTextStyles.heading3),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Generate receipts for all completed payments that don\'t have receipts yet.',
                style: AppTextStyles.bodyMedium,
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.success.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle_rounded, color: AppColors.success),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '12 payments found',
                            style: AppTextStyles.label.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.success,
                            ),
                          ),
                          Text(
                            'Ready to generate receipts',
                            style: AppTextStyles.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
                            content: const Text('12 receipts generated successfully'),
                            backgroundColor: AppColors.success,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.auto_awesome_rounded, size: 18),
                      label: const Text('Generate All'),
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

  void _showReceiptPreview(Receipt receipt) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Receipt Header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.receipt_long_rounded,
                      color: Colors.white,
                      size: 40,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'UDDAMTHODU',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    Text(
                      'Payment Receipt',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              
              // Receipt Details
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.backgroundLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _buildReceiptRow('Receipt No', receipt.id),
                    _buildReceiptRow('Date', _formatDate(receipt.date)),
                    _buildReceiptRow('Member', receipt.memberName),
                    _buildReceiptRow('Member ID', receipt.memberId),
                    _buildReceiptRow('Payment For', receipt.type),
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Amount Paid',
                          style: AppTextStyles.label.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '₹${receipt.amount.toStringAsFixed(0)}',
                          style: AppTextStyles.heading3.copyWith(
                            color: AppColors.success,
                          ),
                        ),
                      ],
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
                      icon: const Icon(Icons.close_rounded, size: 18),
                      label: const Text('Close'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.textSecondary,
                        side: BorderSide(color: AppColors.borderLight),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _downloadReceipt(receipt),
                      icon: const Icon(Icons.download_outlined, size: 18),
                      label: const Text('Download'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
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
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textLight,
            ),
            prefixIcon: Icon(icon, size: 20),
            filled: true,
            fillColor: AppColors.backgroundLight,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.bodySmall),
          Text(
            value,
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _downloadReceipt(Receipt receipt) {
    setState(() {
      final index = _receipts.indexWhere((r) => r.id == receipt.id);
      if (index != -1) {
        _receipts[index] = Receipt(
          id: receipt.id,
          memberId: receipt.memberId,
          memberName: receipt.memberName,
          amount: receipt.amount,
          type: receipt.type,
          date: receipt.date,
          status: 'Downloaded',
          paymentId: receipt.paymentId,
        );
      }
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Receipt ${receipt.id} downloaded'),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _sendReceipt(Receipt receipt) {
    setState(() {
      final index = _receipts.indexWhere((r) => r.id == receipt.id);
      if (index != -1) {
        _receipts[index] = Receipt(
          id: receipt.id,
          memberId: receipt.memberId,
          memberName: receipt.memberName,
          amount: receipt.amount,
          type: receipt.type,
          date: receipt.date,
          status: 'Sent',
          paymentId: receipt.paymentId,
        );
      }
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Receipt sent to ${receipt.memberName}'),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

class Receipt {
  final String id;
  final String memberId;
  final String memberName;
  final double amount;
  final String type;
  final DateTime date;
  final String status;
  final String paymentId;

  Receipt({
    required this.id,
    required this.memberId,
    required this.memberName,
    required this.amount,
    required this.type,
    required this.date,
    required this.status,
    required this.paymentId,
  });
}
