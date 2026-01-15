import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../shared/widgets/language_selector.dart';
import 'login_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar with language selector
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  LanguageSelector(isCompact: true),
                ],
              ),
            ),
            
            // Main content centered
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Logo
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: AppColors.primaryBlue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: const Icon(
                          Icons.people_alt_rounded,
                          color: AppColors.primaryBlue,
                          size: 56,
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // App Name
                      Text(
                        l10n.get('app_name'),
                        style: AppTextStyles.heading1.copyWith(
                          fontSize: 28,
                          color: AppColors.primaryBlue,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.get('management_system'),
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      
                      SizedBox(height: screenHeight * 0.08),
                      
                      // Login Buttons
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(initialTab: 0),
                              ),
                            );
                          },
                          icon: const Icon(Icons.people_outline, size: 22),
                          label: Text(l10n.get('member_login')),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryBlue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(initialTab: 1),
                              ),
                            );
                          },
                          icon: const Icon(Icons.admin_panel_settings_outlined, size: 22),
                          label: Text(l10n.get('admin_login')),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.primaryBlue,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            side: const BorderSide(color: AppColors.primaryBlue, width: 1.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            // Footer
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                '© 2024 ${l10n.get('app_name')}',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textLight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
