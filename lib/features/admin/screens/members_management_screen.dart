import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class MembersManagementScreen extends StatefulWidget {
  const MembersManagementScreen({super.key});

  @override
  State<MembersManagementScreen> createState() => _MembersManagementScreenState();
}

class _MembersManagementScreenState extends State<MembersManagementScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Active', 'Inactive', 'Pending'];

  final List<Member> _members = [
    Member(
      id: 'UM0001',
      name: 'Krishnan Menon',
      phone: '+91 98765 43210',
      email: 'krishnan@email.com',
      status: 'Active',
      joinDate: '15 Mar 2020',
      totalPaid: 24500,
      pendingAmount: 0,
      role: 'President',
    ),
    Member(
      id: 'UM0002',
      name: 'Raghavan Nair',
      phone: '+91 98765 43211',
      email: 'raghavan@email.com',
      status: 'Active',
      joinDate: '15 Mar 2020',
      totalPaid: 24500,
      pendingAmount: 0,
      role: 'Secretary',
    ),
    Member(
      id: 'UM0003',
      name: 'Suresh Kumar',
      phone: '+91 98765 43212',
      email: 'suresh@email.com',
      status: 'Active',
      joinDate: '20 Apr 2020',
      totalPaid: 23000,
      pendingAmount: 500,
      role: 'Treasurer',
    ),
    Member(
      id: 'UM0251',
      name: 'Ramesh Varma',
      phone: '+91 98765 43213',
      email: 'ramesh@email.com',
      status: 'Active',
      joinDate: '10 Jan 2024',
      totalPaid: 38500,
      pendingAmount: 1500,
    ),
    Member(
      id: 'UM0250',
      name: 'Gopalan Das',
      phone: '+91 98765 43214',
      email: 'gopalan@email.com',
      status: 'Inactive',
      joinDate: '05 Jan 2024',
      totalPaid: 12000,
      pendingAmount: 3500,
    ),
    Member(
      id: 'UM0249',
      name: 'Mohan Pillai',
      phone: '+91 98765 43215',
      email: 'mohan@email.com',
      status: 'Pending',
      joinDate: '01 Jan 2024',
      totalPaid: 0,
      pendingAmount: 500,
    ),
    Member(
      id: 'UM0248',
      name: 'Vijayan Nambiar',
      phone: '+91 98765 43216',
      email: 'vijayan@email.com',
      status: 'Active',
      joinDate: '28 Dec 2023',
      totalPaid: 8500,
      pendingAmount: 0,
    ),
    Member(
      id: 'UM0247',
      name: 'Anil Kumar',
      phone: '+91 98765 43217',
      email: 'anil@email.com',
      status: 'Active',
      joinDate: '25 Dec 2023',
      totalPaid: 9000,
      pendingAmount: 500,
    ),
  ];

  List<Member> get _filteredMembers {
    var filtered = _members;
    
    if (_selectedFilter != 'All') {
      filtered = filtered.where((m) => m.status == _selectedFilter).toList();
    }
    
    if (_searchController.text.isNotEmpty) {
      final query = _searchController.text.toLowerCase();
      filtered = filtered.where((m) =>
        m.name.toLowerCase().contains(query) ||
        m.id.toLowerCase().contains(query) ||
        m.phone.contains(query)
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
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Members Management',
                    style: AppTextStyles.heading2.copyWith(
                      fontSize: isDesktop ? 28 : 22,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${_members.length} total members',
                    style: AppTextStyles.bodyMedium,
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () => _showAddMemberDialog(),
                icon: const Icon(Icons.person_add_rounded, size: 20),
                label: Text(isDesktop ? 'Add New Member' : 'Add'),
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

          // Search and Filters
          Container(
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
              children: [
                if (isDesktop)
                  Row(
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
                      _buildExportButton(),
                    ],
                  )
                else
                  Column(
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
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Stats Cards
          if (isDesktop)
            Row(
              children: [
                _buildStatCard('Total', _members.length, AppColors.primaryBlue),
                const SizedBox(width: 12),
                _buildStatCard('Active', _members.where((m) => m.status == 'Active').length, AppColors.success),
                const SizedBox(width: 12),
                _buildStatCard('Inactive', _members.where((m) => m.status == 'Inactive').length, AppColors.error),
                const SizedBox(width: 12),
                _buildStatCard('Pending', _members.where((m) => m.status == 'Pending').length, AppColors.warning),
              ],
            )
          else
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildStatCard('Total', _members.length, AppColors.primaryBlue),
                _buildStatCard('Active', _members.where((m) => m.status == 'Active').length, AppColors.success),
                _buildStatCard('Inactive', _members.where((m) => m.status == 'Inactive').length, AppColors.error),
                _buildStatCard('Pending', _members.where((m) => m.status == 'Pending').length, AppColors.warning),
              ],
            ),
          const SizedBox(height: 20),

          // Members Table/List
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
            child: isDesktop
                ? _buildDesktopTable()
                : _buildMobileList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      onChanged: (value) => setState(() {}),
      decoration: InputDecoration(
        hintText: 'Search by name, ID, or phone...',
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
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.primaryBlue.withOpacity(0.3),
          ),
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
          items: _filters.map((filter) {
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

  Widget _buildStatCard(String label, int count, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Text(
              count.toString(),
              style: AppTextStyles.heading2.copyWith(
                color: color,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTextStyles.bodySmall.copyWith(
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
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
          DataColumn(label: Text('Member')),
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('Contact')),
          DataColumn(label: Text('Status')),
          DataColumn(label: Text('Joined')),
          DataColumn(label: Text('Total Paid')),
          DataColumn(label: Text('Pending')),
          DataColumn(label: Text('Actions')),
        ],
        rows: _filteredMembers.map((member) {
          return DataRow(
            cells: [
              DataCell(
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
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
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          member.name,
                          style: AppTextStyles.label.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (member.role != null)
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primaryBlue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              member.role!,
                              style: TextStyle(
                                fontSize: 10,
                                color: AppColors.primaryBlue,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              DataCell(Text(member.id)),
              DataCell(
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(member.phone, style: AppTextStyles.bodySmall),
                    Text(
                      member.email,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textLight,
                      ),
                    ),
                  ],
                ),
              ),
              DataCell(_buildStatusBadge(member.status)),
              DataCell(Text(member.joinDate)),
              DataCell(
                Text(
                  '₹${_formatAmount(member.totalPaid)}',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.success,
                  ),
                ),
              ),
              DataCell(
                Text(
                  member.pendingAmount > 0 
                      ? '₹${_formatAmount(member.pendingAmount)}'
                      : '-',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: member.pendingAmount > 0 
                        ? AppColors.warning 
                        : AppColors.textLight,
                  ),
                ),
              ),
              DataCell(
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () => _showMemberDetailsDialog(member),
                      icon: const Icon(Icons.visibility_outlined),
                      iconSize: 20,
                      color: AppColors.primaryBlue,
                      tooltip: 'View',
                    ),
                    IconButton(
                      onPressed: () => _showEditMemberDialog(member),
                      icon: const Icon(Icons.edit_outlined),
                      iconSize: 20,
                      color: AppColors.textSecondary,
                      tooltip: 'Edit',
                    ),
                    IconButton(
                      onPressed: () => _showDeleteConfirmation(member),
                      icon: const Icon(Icons.delete_outline),
                      iconSize: 20,
                      color: AppColors.error,
                      tooltip: 'Delete',
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
      itemCount: _filteredMembers.length,
      separatorBuilder: (_, __) => const Divider(height: 24),
      itemBuilder: (context, index) {
        final member = _filteredMembers[index];
        return _buildMemberCard(member);
      },
    );
  }

  Widget _buildMemberCard(Member member) {
    return InkWell(
      onTap: () => _showMemberDetailsDialog(member),
      borderRadius: BorderRadius.circular(12),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    member.name.substring(0, 1).toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
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
                          member.name,
                          style: AppTextStyles.label.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (member.role != null) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primaryBlue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              member.role!,
                              style: TextStyle(
                                fontSize: 10,
                                color: AppColors.primaryBlue,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'ID: ${member.id} • ${member.phone}',
                      style: AppTextStyles.bodySmall,
                    ),
                  ],
                ),
              ),
              _buildStatusBadge(member.status),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfoChip('Paid', '₹${_formatAmount(member.totalPaid)}', AppColors.success),
              _buildInfoChip(
                'Pending',
                member.pendingAmount > 0 ? '₹${_formatAmount(member.pendingAmount)}' : '-',
                member.pendingAmount > 0 ? AppColors.warning : AppColors.textLight,
              ),
              _buildInfoChip('Joined', member.joinDate, AppColors.textSecondary),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _showEditMemberDialog(member),
                  icon: const Icon(Icons.edit_outlined, size: 18),
                  label: const Text('Edit'),
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
                  onPressed: () => _showMemberDetailsDialog(member),
                  icon: const Icon(Icons.visibility_outlined, size: 18),
                  label: const Text('View'),
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

  Widget _buildInfoChip(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textLight,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color;
    switch (status) {
      case 'Active':
        color = AppColors.success;
        break;
      case 'Inactive':
        color = AppColors.error;
        break;
      case 'Pending':
        color = AppColors.warning;
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
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  String _formatAmount(double amount) {
    if (amount >= 100000) {
      return '${(amount / 100000).toStringAsFixed(1)}L';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(1)}K';
    }
    return amount.toStringAsFixed(0);
  }

  void _showAddMemberDialog() {
    showDialog(
      context: context,
      builder: (context) => _MemberFormDialog(
        title: 'Add New Member',
        onSave: (member) {
          setState(() {
            _members.insert(0, member);
          });
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Member added successfully'),
              backgroundColor: AppColors.success,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showEditMemberDialog(Member member) {
    showDialog(
      context: context,
      builder: (context) => _MemberFormDialog(
        title: 'Edit Member',
        member: member,
        onSave: (updatedMember) {
          setState(() {
            final index = _members.indexWhere((m) => m.id == member.id);
            if (index != -1) {
              _members[index] = updatedMember;
            }
          });
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Member updated successfully'),
              backgroundColor: AppColors.success,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showMemberDetailsDialog(Member member) {
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
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(
                      child: Text(
                        member.name.substring(0, 1).toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(member.name, style: AppTextStyles.heading3),
                            if (member.role != null) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryBlue.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  member.role!,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.primaryBlue,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text('ID: ${member.id}', style: AppTextStyles.bodyMedium),
                      ],
                    ),
                  ),
                  _buildStatusBadge(member.status),
                ],
              ),
              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 16),
              _buildDetailRow(Icons.phone_outlined, 'Phone', member.phone),
              _buildDetailRow(Icons.email_outlined, 'Email', member.email),
              _buildDetailRow(Icons.calendar_today_outlined, 'Joined', member.joinDate),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildAmountCard(
                      'Total Paid',
                      '₹${_formatAmount(member.totalPaid)}',
                      AppColors.success,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildAmountCard(
                      'Pending',
                      member.pendingAmount > 0 
                          ? '₹${_formatAmount(member.pendingAmount)}'
                          : '₹0',
                      member.pendingAmount > 0 ? AppColors.warning : AppColors.textLight,
                    ),
                  ),
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
                      child: const Text('Close'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        _showEditMemberDialog(member);
                      },
                      icon: const Icon(Icons.edit_outlined, size: 18),
                      label: const Text('Edit Member'),
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

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.textLight),
          const SizedBox(width: 12),
          Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textLight,
            ),
          ),
          const Spacer(),
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

  Widget _buildAmountCard(String label, String amount, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(color: color),
          ),
          const SizedBox(height: 4),
          Text(
            amount,
            style: AppTextStyles.heading3.copyWith(
              color: color,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(Member member) {
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
            const Text('Delete Member'),
          ],
        ),
        content: Text(
          'Are you sure you want to delete ${member.name}? This action cannot be undone.',
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
                _members.removeWhere((m) => m.id == member.id);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Member deleted successfully'),
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

class _MemberFormDialog extends StatefulWidget {
  final String title;
  final Member? member;
  final Function(Member) onSave;

  const _MemberFormDialog({
    required this.title,
    this.member,
    required this.onSave,
  });

  @override
  State<_MemberFormDialog> createState() => _MemberFormDialogState();
}

class _MemberFormDialogState extends State<_MemberFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  String _selectedStatus = 'Active';

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.member?.name ?? '');
    _phoneController = TextEditingController(text: widget.member?.phone ?? '');
    _emailController = TextEditingController(text: widget.member?.email ?? '');
    _selectedStatus = widget.member?.status ?? 'Active';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 450),
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.title, style: AppTextStyles.heading3),
              const SizedBox(height: 24),
              _buildTextField(
                controller: _nameController,
                label: 'Full Name',
                icon: Icons.person_outline,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _phoneController,
                label: 'Phone Number',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _emailController,
                label: 'Email Address',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Text(
                'Status',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: ['Active', 'Inactive', 'Pending'].map((status) {
                  final isSelected = _selectedStatus == status;
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: InkWell(
                        onTap: () => setState(() => _selectedStatus = status),
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primaryBlue.withOpacity(0.1)
                                : AppColors.backgroundLight,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primaryBlue
                                  : AppColors.borderLight,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              status,
                              style: AppTextStyles.bodySmall.copyWith(
                                fontWeight: FontWeight.w600,
                                color: isSelected
                                    ? AppColors.primaryBlue
                                    : AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
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
                        if (_formKey.currentState!.validate()) {
                          final newMember = Member(
                            id: widget.member?.id ?? 'UM${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
                            name: _nameController.text,
                            phone: _phoneController.text,
                            email: _emailController.text,
                            status: _selectedStatus,
                            joinDate: widget.member?.joinDate ?? _formatDate(DateTime.now()),
                            totalPaid: widget.member?.totalPaid ?? 0,
                            pendingAmount: widget.member?.pendingAmount ?? 500,
                            role: widget.member?.role,
                          );
                          widget.onSave(newMember);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(widget.member == null ? 'Add Member' : 'Save Changes'),
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 20),
        filled: true,
        fillColor: AppColors.backgroundLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.primaryBlue.withOpacity(0.5)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.error.withOpacity(0.5)),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${date.day.toString().padLeft(2, '0')} ${months[date.month - 1]} ${date.year}';
  }
}

class Member {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String status;
  final String joinDate;
  final double totalPaid;
  final double pendingAmount;
  final String? role;

  Member({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.status,
    required this.joinDate,
    required this.totalPaid,
    required this.pendingAmount,
    this.role,
  });
}
