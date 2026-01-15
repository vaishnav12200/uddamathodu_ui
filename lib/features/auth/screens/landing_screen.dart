import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../shared/widgets/language_selector.dart';
import '../widgets/feature_card.dart';
import 'login_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              _buildHeader(context),
              
              // Hero Section
              _buildHeroSection(context),
              
              // Feature Cards
              _buildFeatureCards(context),
              
              // House Illustration & Features
              _buildBottomSection(context),
              
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final l10n = context.l10n;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: AppColors.backgroundWhite,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Logo
          GestureDetector(
            onTap: () {
              // Already on home, show feedback
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(l10n.get('app_name')),
                  duration: const Duration(seconds: 1),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.people_alt_rounded,
                color: AppColors.primaryBlue,
                size: 24,
              ),
            ),
          ),
          const SizedBox(width: 10),
          // App Name
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.get('app_name'),
                  style: AppTextStyles.heading3.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  l10n.get('management_system'),
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          // Language Selector
          const LanguageSelector(isCompact: true),
          const SizedBox(width: 8),
          // Notification Bell
          IconButton(
            onPressed: () {
              _showComingSoonDialog(context, l10n.get('notifications'));
            },
            icon: const Icon(
              Icons.notifications_outlined,
              color: AppColors.textSecondary,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 8),
          // Login Button
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
            icon: const Icon(Icons.person_outline, size: 18),
            label: Text(l10n.get('login')),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    final l10n = context.l10n;
    
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Text
          RichText(
            text: TextSpan(
              style: AppTextStyles.heading1.copyWith(fontSize: 26),
              children: [
                TextSpan(text: '${l10n.get('welcome_to')} '),
                TextSpan(
                  text: '${l10n.get('app_name').split(' ').first}\n',
                  style: const TextStyle(color: AppColors.primaryBlue),
                ),
                TextSpan(
                  text: '${l10n.get('app_name').split(' ').last} ',
                  style: const TextStyle(color: AppColors.primaryBlue),
                ),
                TextSpan(text: l10n.get('management_system')),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            l10n.get('welcome_description'),
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 24),
          
          // Login Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(initialTab: 0),
                      ),
                    );
                  },
                  icon: const Icon(Icons.people_outline, size: 20),
                  label: Text(l10n.get('member_login')),
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
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(initialTab: 1),
                      ),
                    );
                  },
                  icon: const Icon(Icons.admin_panel_settings_outlined, size: 20),
                  label: Text(l10n.get('admin_login')),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primaryBlue,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: const BorderSide(color: AppColors.primaryBlue, width: 1.5),
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
    );
  }

  Widget _buildFeatureCards(BuildContext context) {
    final l10n = context.l10n;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: FeatureCard(
                  icon: Icons.account_balance_wallet_outlined,
                  title: l10n.get('safe_transparent'),
                  subtitle: l10n.get('financial_management'),
                  description: l10n.get('financial_desc'),
                  iconColor: AppColors.primaryBlue,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(initialTab: 0),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FeatureCard(
                  icon: Icons.payment_outlined,
                  title: l10n.get('easy_upi'),
                  subtitle: '& ${l10n.get('receipts')}',
                  description: l10n.get('upi_desc'),
                  iconColor: Colors.orange,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(initialTab: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          FeatureCard(
            icon: Icons.campaign_outlined,
            title: l10n.get('official_notices'),
            subtitle: '',
            description: l10n.get('notices_desc'),
            iconColor: AppColors.primaryBlue,
            isFullWidth: true,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(initialTab: 0),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSection(BuildContext context) {
    final l10n = context.l10n;
    
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Features List
          _buildFeatureItem(
            icon: Icons.check_circle,
            text: l10n.get('safe_transparent'),
          ),
          const SizedBox(height: 8),
          _buildFeatureItem(
            icon: Icons.check_circle,
            text: l10n.get('financial_management'),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem({required IconData icon, required String text}) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.primaryBlue,
          size: 20,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.bodyMedium,
          ),
        ),
      ],
    );
  }

  void _showComingSoonDialog(BuildContext context, String feature) {
    final l10n = context.l10n;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature - ${l10n.get('feature_coming_soon')}'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
