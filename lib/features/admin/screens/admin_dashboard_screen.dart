import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../widgets/admin_sidebar.dart';
import '../widgets/admin_header.dart';
import '../widgets/stats_card.dart';
import '../widgets/collection_chart_widget.dart';
import '../widgets/member_list_widget.dart';
import '../widgets/quick_actions_widget.dart';
import '../widgets/recent_payments_widget.dart';
import 'members_management_screen.dart';
import 'payments_management_screen.dart';
import 'receipts_management_screen.dart';
import 'notices_management_screen.dart';
import 'reports_screen.dart';
import 'settings_screen.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<String> _menuItems = [
    'Dashboard',
    'Members',
    'Payments',
    'Receipts',
    'Notices',
    'Reports',
    'Settings',
  ];

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;
    final isTablet = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.backgroundLight,
      drawer: isDesktop
          ? null
          : AdminSidebar(
              selectedIndex: _selectedIndex,
              onItemSelected: (index) {
                setState(() => _selectedIndex = index);
                Navigator.pop(context);
              },
              menuItems: _menuItems,
            ),
      body: SafeArea(
        child: Row(
          children: [
            // Sidebar for desktop
            if (isDesktop)
              AdminSidebar(
                selectedIndex: _selectedIndex,
                onItemSelected: (index) {
                  setState(() => _selectedIndex = index);
                },
                menuItems: _menuItems,
              ),

            // Main content
            Expanded(
              child: Column(
                children: [
                  // Header
                  AdminHeader(
                    onMenuPressed: isDesktop
                        ? null
                        : () => _scaffoldKey.currentState?.openDrawer(),
                  ),

                  // Content
                  Expanded(
                    child: _buildContent(isDesktop, isTablet),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(bool isDesktop, bool isTablet) {
    switch (_selectedIndex) {
      case 0:
        return _buildDashboardContent(isDesktop, isTablet);
      case 1:
        return const MembersManagementScreen();
      case 2:
        return const PaymentsManagementScreen();
      case 3:
        return const ReceiptsManagementScreen();
      case 4:
        return const NoticesManagementScreen();
      case 5:
        return const ReportsScreen();
      case 6:
        return const SettingsScreen();
      default:
        return _buildDashboardContent(isDesktop, isTablet);
    }
  }

  Widget _buildDashboardContent(bool isDesktop, bool isTablet) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(isDesktop ? 24 : 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Page Title
          Text(
            'Admin Dashboard',
            style: AppTextStyles.heading2.copyWith(
              fontSize: isDesktop ? 28 : 22,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Welcome back! Here\'s what\'s happening with your community.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 24),

          // Stats Cards Row
          if (isDesktop)
            Row(
              children: [
                Expanded(
                  child: StatsCard(
                    title: 'Total Members',
                    value: '256',
                    subtitle: 'Active members',
                    icon: Icons.people_rounded,
                    iconColor: AppColors.primaryBlue,
                    showTrend: true,
                    trendValue: 12.5,
                    trendUp: true,
                    onTap: () => setState(() => _selectedIndex = 1),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: StatsCard(
                    title: 'Total Collection',
                    value: '₹41.5L',
                    subtitle: 'This year',
                    icon: Icons.account_balance_wallet_rounded,
                    iconColor: AppColors.success,
                    showTrend: true,
                    trendValue: 8.2,
                    trendUp: true,
                    onTap: () => setState(() => _selectedIndex = 2),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: StatsCard(
                    title: 'Pending Amount',
                    value: '₹3.2L',
                    subtitle: '45 members',
                    icon: Icons.pending_actions_rounded,
                    iconColor: AppColors.warning,
                    showTrend: true,
                    trendValue: 5.1,
                    trendUp: false,
                    onTap: () => setState(() => _selectedIndex = 2),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: StatsCard(
                    title: 'This Month',
                    value: '₹85,500',
                    subtitle: 'Collection',
                    icon: Icons.calendar_month_rounded,
                    iconColor: Colors.purple,
                    showTrend: true,
                    trendValue: 15.3,
                    trendUp: true,
                  ),
                ),
              ],
            )
          else if (isTablet)
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: StatsCard(
                        title: 'Total Members',
                        value: '256',
                        icon: Icons.people_rounded,
                        iconColor: AppColors.primaryBlue,
                        onTap: () => setState(() => _selectedIndex = 1),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: StatsCard(
                        title: 'Total Collection',
                        value: '₹41.5L',
                        icon: Icons.account_balance_wallet_rounded,
                        iconColor: AppColors.success,
                        onTap: () => setState(() => _selectedIndex = 2),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: StatsCard(
                        title: 'Pending',
                        value: '₹3.2L',
                        icon: Icons.pending_actions_rounded,
                        iconColor: AppColors.warning,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: StatsCard(
                        title: 'This Month',
                        value: '₹85,500',
                        icon: Icons.calendar_month_rounded,
                        iconColor: Colors.purple,
                      ),
                    ),
                  ],
                ),
              ],
            )
          else
            Column(
              children: [
                StatsCard(
                  title: 'Total Members',
                  value: '256',
                  subtitle: 'Active members',
                  icon: Icons.people_rounded,
                  iconColor: AppColors.primaryBlue,
                  showTrend: true,
                  trendValue: 12.5,
                  trendUp: true,
                  onTap: () => setState(() => _selectedIndex = 1),
                ),
                const SizedBox(height: 12),
                StatsCard(
                  title: 'Total Collection',
                  value: '₹41.5L',
                  subtitle: 'This year',
                  icon: Icons.account_balance_wallet_rounded,
                  iconColor: AppColors.success,
                  onTap: () => setState(() => _selectedIndex = 2),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: StatsCard(
                        title: 'Pending',
                        value: '₹3.2L',
                        icon: Icons.pending_actions_rounded,
                        iconColor: AppColors.warning,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: StatsCard(
                        title: 'This Month',
                        value: '₹85,500',
                        icon: Icons.calendar_month_rounded,
                        iconColor: Colors.purple,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          const SizedBox(height: 24),

          // Charts and Lists Section
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Column - Chart
                Expanded(
                  flex: 2,
                  child: CollectionChartWidget(
                    collections: _getMonthlyCollections(),
                  ),
                ),
                const SizedBox(width: 20),
                // Right Column - Quick Actions
                Expanded(
                  child: QuickActionsWidget(
                    onActionTap: (action) => _handleQuickAction(action),
                  ),
                ),
              ],
            )
          else
            Column(
              children: [
                CollectionChartWidget(
                  collections: _getMonthlyCollections(),
                ),
                const SizedBox(height: 20),
                QuickActionsWidget(
                  onActionTap: (action) => _handleQuickAction(action),
                ),
              ],
            ),
          const SizedBox(height: 20),

          // Recent Members and Payments
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: MemberListWidget(
                    members: _getRecentMembers(),
                    onViewAll: () => setState(() => _selectedIndex = 1),
                    onMemberTap: (member) => _showMemberDetails(member),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: RecentPaymentsWidget(
                    payments: _getRecentPayments(),
                    onViewAll: () => setState(() => _selectedIndex = 2),
                  ),
                ),
              ],
            )
          else
            Column(
              children: [
                MemberListWidget(
                  members: _getRecentMembers(),
                  onViewAll: () => setState(() => _selectedIndex = 1),
                  onMemberTap: (member) => _showMemberDetails(member),
                ),
                const SizedBox(height: 20),
                RecentPaymentsWidget(
                  payments: _getRecentPayments(),
                  onViewAll: () => setState(() => _selectedIndex = 2),
                ),
              ],
            ),
        ],
      ),
    );
  }

  List<MonthlyCollection> _getMonthlyCollections() {
    return [
      MonthlyCollection(month: 'Jan', amount: 75000),
      MonthlyCollection(month: 'Feb', amount: 82000),
      MonthlyCollection(month: 'Mar', amount: 68000),
      MonthlyCollection(month: 'Apr', amount: 91000),
      MonthlyCollection(month: 'May', amount: 78000),
      MonthlyCollection(month: 'Jun', amount: 85500),
    ];
  }

  List<MemberData> _getRecentMembers() {
    return [
      MemberData(
        name: 'Ramesh Varma',
        memberId: 'UM0251',
        status: 'Active',
        joinDate: '10 Jan 2024',
      ),
      MemberData(
        name: 'Suresh Kumar',
        memberId: 'UM0250',
        status: 'Active',
        joinDate: '08 Jan 2024',
      ),
      MemberData(
        name: 'Krishnan Nair',
        memberId: 'UM0249',
        status: 'Pending',
        joinDate: '05 Jan 2024',
      ),
      MemberData(
        name: 'Gopalan Menon',
        memberId: 'UM0248',
        status: 'Active',
        joinDate: '02 Jan 2024',
      ),
    ];
  }

  List<PaymentData> _getRecentPayments() {
    return [
      PaymentData(
        memberName: 'Ramesh Varma',
        memberId: 'UM0251',
        amount: 500,
        status: 'Completed',
        description: 'Monthly contribution - Jan 2024',
        date: '10 Jan 2024',
      ),
      PaymentData(
        memberName: 'Suresh Kumar',
        memberId: 'UM0250',
        amount: 4000,
        status: 'Completed',
        description: 'Temple festival contribution',
        date: '09 Jan 2024',
      ),
      PaymentData(
        memberName: 'Mohan Das',
        memberId: 'UM0245',
        amount: 500,
        status: 'Pending',
        description: 'Monthly contribution - Jan 2024',
        date: '08 Jan 2024',
      ),
      PaymentData(
        memberName: 'Raghavan Pillai',
        memberId: 'UM0243',
        amount: 1000,
        status: 'Completed',
        description: 'Special contribution',
        date: '07 Jan 2024',
      ),
    ];
  }

  void _handleQuickAction(String action) {
    switch (action) {
      case 'add_member':
        setState(() => _selectedIndex = 1);
        break;
      case 'generate_receipt':
        setState(() => _selectedIndex = 3);
        break;
      case 'send_notice':
        setState(() => _selectedIndex = 4);
        break;
      case 'export_report':
        setState(() => _selectedIndex = 5);
        break;
    }
  }

  void _showMemberDetails(MemberData member) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Container(
              width: 48,
              height: 48,
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
                  Text(member.name, style: AppTextStyles.heading3),
                  Text(
                    'ID: ${member.memberId}',
                    style: AppTextStyles.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildInfoRow('Status', member.status),
            _buildInfoRow('Joined', member.joinDate),
            _buildInfoRow('Phone', '+91 98765 43210'),
            _buildInfoRow('Email', '${member.name.toLowerCase().replaceAll(' ', '')}@email.com'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() => _selectedIndex = 1);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('View Full Profile'),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.bodyMedium),
          Text(
            value,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
