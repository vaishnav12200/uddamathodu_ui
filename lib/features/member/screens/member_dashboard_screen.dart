import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/localization/app_localizations.dart';
import '../widgets/member_sidebar.dart';
import '../widgets/member_header.dart';
import '../widgets/welcome_card.dart';
import '../widgets/balance_card.dart';
import '../widgets/payment_history_table.dart';
import '../widgets/upi_transaction_card.dart';
import '../widgets/notice_board_widget.dart';
import '../widgets/receipt_list_widget.dart';
import 'contribution_history_screen.dart';
import 'receipts_screen.dart';
import 'notices_screen.dart';
import 'profile_screen.dart';

class MemberDashboardScreen extends StatefulWidget {
  const MemberDashboardScreen({super.key});

  @override
  State<MemberDashboardScreen> createState() => _MemberDashboardScreenState();
}

class _MemberDashboardScreenState extends State<MemberDashboardScreen> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> _getMenuItems(AppLocalizations l10n) {
    return [
      l10n.get('dashboard'),
      l10n.get('contributions'),
      l10n.get('receipts'),
      l10n.get('notices'),
      l10n.get('profile'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;
    final isTablet = MediaQuery.of(context).size.width > 600;
    final l10n = context.l10n;
    final menuItems = _getMenuItems(l10n);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.backgroundLight,
      drawer: isDesktop ? null : MemberSidebar(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          setState(() => _selectedIndex = index);
          Navigator.pop(context);
        },
        menuItems: menuItems,
      ),
      body: SafeArea(
        child: Row(
          children: [
            // Sidebar for desktop
            if (isDesktop)
              MemberSidebar(
                selectedIndex: _selectedIndex,
                onItemSelected: (index) {
                  setState(() => _selectedIndex = index);
                },
                menuItems: menuItems,
              ),
            
            // Main content
            Expanded(
              child: Column(
                children: [
                  // Header
                  MemberHeader(
                    onMenuPressed: isDesktop 
                        ? null 
                        : () => _scaffoldKey.currentState?.openDrawer(),
                    onProfilePressed: () {
                      setState(() => _selectedIndex = 4);
                    },
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
        return const ContributionHistoryScreen();
      case 2:
        return const ReceiptsScreen();
      case 3:
        return const NoticesScreen();
      case 4:
        return const ProfileScreen();
      default:
        return _buildDashboardContent(isDesktop, isTablet);
    }
  }

  Widget _buildDashboardContent(bool isDesktop, bool isTablet) {
    final l10n = context.l10n;
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(isDesktop ? 24 : 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Page Title
          Text(
            l10n.get('member_dashboard'),
            style: AppTextStyles.heading2.copyWith(
              fontSize: isDesktop ? 28 : 22,
            ),
          ),
          const SizedBox(height: 20),
          
          // Welcome Card
          const WelcomeCard(
            memberName: 'Ramesh Varma',
            memberId: 'UM0251',
            totalBalance: 41002631,
          ),
          const SizedBox(height: 20),
          
          // Balance Cards Row
          if (isDesktop || isTablet)
            Row(
              children: [
                Expanded(
                  child: BalanceCard(
                    title: 'Total Paid Amount',
                    amount: 38500,
                    pendingAmount: 1500,
                    isPrimary: true,
                    icon: Icons.lock_outline,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: BalanceCard(
                    title: 'Pending Balance',
                    amount: 1500,
                    showPayButton: true,
                    onPayPressed: () => _showUPIPaymentDialog(),
                  ),
                ),
              ],
            )
          else
            Column(
              children: [
                BalanceCard(
                  title: 'Total Paid Amount',
                  amount: 38500,
                  pendingAmount: 1500,
                  isPrimary: true,
                  icon: Icons.lock_outline,
                ),
                const SizedBox(height: 16),
                BalanceCard(
                  title: 'Pending Balance',
                  amount: 1500,
                  showPayButton: true,
                  onPayPressed: () => _showUPIPaymentDialog(),
                ),
              ],
            ),
          const SizedBox(height: 24),
          
          // Payment History & UPI Transaction Section
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Payment History
                Expanded(
                  flex: 3,
                  child: PaymentHistoryTable(
                    onViewAllPressed: () {
                      setState(() => _selectedIndex = 1);
                    },
                  ),
                ),
                const SizedBox(width: 20),
                // UPI Transaction & Notice Board
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      UPITransactionCard(
                        onSubmit: (amount, utrNumber, contributionType) {
                          _submitUPIPayment(amount, utrNumber, contributionType);
                        },
                      ),
                      const SizedBox(height: 20),
                      NoticeBoardWidget(
                        onViewAllPressed: () {
                          setState(() => _selectedIndex = 3);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            )
          else
            Column(
              children: [
                PaymentHistoryTable(
                  onViewAllPressed: () {
                    setState(() => _selectedIndex = 1);
                  },
                ),
                const SizedBox(height: 20),
                UPITransactionCard(
                  onSubmit: (amount, utrNumber, contributionType) {
                    _submitUPIPayment(amount, utrNumber, contributionType);
                  },
                ),
                const SizedBox(height: 20),
                NoticeBoardWidget(
                  onViewAllPressed: () {
                    setState(() => _selectedIndex = 3);
                  },
                ),
              ],
            ),
          const SizedBox(height: 24),
          
          // Recent Receipts
          ReceiptListWidget(
            onViewAllPressed: () {
              setState(() => _selectedIndex = 2);
            },
          ),
        ],
      ),
    );
  }

  void _showUPIPaymentDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(24),
          child: UPITransactionCard(
            isDialog: true,
            onSubmit: (amount, utrNumber, contributionType) {
              Navigator.pop(context);
              _submitUPIPayment(amount, utrNumber, contributionType);
            },
          ),
        ),
      ),
    );
  }

  void _submitUPIPayment(double amount, String utrNumber, String contributionType) {
    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Payment Submitted Successfully!',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'UTR: $utrNumber - Pending admin verification',
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 4),
      ),
    );
  }
}
