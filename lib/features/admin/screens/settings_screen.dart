import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _emailNotifications = true;
  bool _pushNotifications = true;
  bool _paymentReminders = true;
  bool _monthlyReports = false;
  String _currency = '₹ INR';
  String _language = 'English';
  String _dateFormat = 'DD/MM/YYYY';

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;

    return SingleChildScrollView(
      padding: EdgeInsets.all(isDesktop ? 24 : 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Settings',
            style: AppTextStyles.heading2.copyWith(
              fontSize: isDesktop ? 28 : 22,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Manage your account and application preferences',
            style: AppTextStyles.bodyMedium,
          ),
          const SizedBox(height: 24),

          // Settings Sections
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      _buildProfileSection(),
                      const SizedBox(height: 20),
                      _buildOrganizationSection(),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    children: [
                      _buildNotificationSection(),
                      const SizedBox(height: 20),
                      _buildPreferencesSection(),
                    ],
                  ),
                ),
              ],
            )
          else
            Column(
              children: [
                _buildProfileSection(),
                const SizedBox(height: 20),
                _buildOrganizationSection(),
                const SizedBox(height: 20),
                _buildNotificationSection(),
                const SizedBox(height: 20),
                _buildPreferencesSection(),
              ],
            ),
          const SizedBox(height: 20),

          // Security and Account Actions
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildSecuritySection()),
                const SizedBox(width: 20),
                Expanded(child: _buildAccountActionsSection()),
              ],
            )
          else
            Column(
              children: [
                _buildSecuritySection(),
                const SizedBox(height: 20),
                _buildAccountActionsSection(),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildProfileSection() {
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
            children: [
              Icon(Icons.person_rounded, color: AppColors.primaryBlue),
              const SizedBox(width: 8),
              Text(
                'Profile Settings',
                style: AppTextStyles.heading3.copyWith(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Center(
            child: Stack(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      'KM',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.camera_alt_rounded,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildTextField(
            label: 'Full Name',
            value: 'Krishnan Menon',
            icon: Icons.person_outline,
          ),
          const SizedBox(height: 12),
          _buildTextField(
            label: 'Email',
            value: 'krishnan@uddamthodu.com',
            icon: Icons.email_outlined,
          ),
          const SizedBox(height: 12),
          _buildTextField(
            label: 'Phone',
            value: '+91 98765 43210',
            icon: Icons.phone_outlined,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Update Profile'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrganizationSection() {
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
            children: [
              Icon(Icons.business_rounded, color: AppColors.primaryBlue),
              const SizedBox(width: 8),
              Text(
                'Organization Settings',
                style: AppTextStyles.heading3.copyWith(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildTextField(
            label: 'Organization Name',
            value: 'Uddamthodu',
            icon: Icons.home_rounded,
          ),
          const SizedBox(height: 12),
          _buildTextField(
            label: 'Monthly Contribution',
            value: '₹500',
            icon: Icons.payments_rounded,
          ),
          const SizedBox(height: 12),
          _buildTextField(
            label: 'UPI ID',
            value: 'uddamthodu@upi',
            icon: Icons.qr_code_rounded,
          ),
          const SizedBox(height: 12),
          _buildTextField(
            label: 'Address',
            value: 'Tharavad, Kerala, India',
            icon: Icons.location_on_outlined,
            maxLines: 2,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Save Changes'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationSection() {
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
            children: [
              Icon(Icons.notifications_rounded, color: AppColors.primaryBlue),
              const SizedBox(width: 8),
              Text(
                'Notifications',
                style: AppTextStyles.heading3.copyWith(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildSwitchTile(
            title: 'Email Notifications',
            subtitle: 'Receive updates via email',
            icon: Icons.email_outlined,
            value: _emailNotifications,
            onChanged: (value) => setState(() => _emailNotifications = value),
          ),
          const Divider(height: 24),
          _buildSwitchTile(
            title: 'Push Notifications',
            subtitle: 'Get instant alerts',
            icon: Icons.notifications_active_outlined,
            value: _pushNotifications,
            onChanged: (value) => setState(() => _pushNotifications = value),
          ),
          const Divider(height: 24),
          _buildSwitchTile(
            title: 'Payment Reminders',
            subtitle: 'Send automatic reminders to members',
            icon: Icons.schedule_rounded,
            value: _paymentReminders,
            onChanged: (value) => setState(() => _paymentReminders = value),
          ),
          const Divider(height: 24),
          _buildSwitchTile(
            title: 'Monthly Reports',
            subtitle: 'Auto-generate monthly reports',
            icon: Icons.analytics_outlined,
            value: _monthlyReports,
            onChanged: (value) => setState(() => _monthlyReports = value),
          ),
        ],
      ),
    );
  }

  Widget _buildPreferencesSection() {
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
            children: [
              Icon(Icons.tune_rounded, color: AppColors.primaryBlue),
              const SizedBox(width: 8),
              Text(
                'Preferences',
                style: AppTextStyles.heading3.copyWith(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildDropdownTile(
            title: 'Currency',
            value: _currency,
            icon: Icons.currency_rupee_rounded,
            options: ['₹ INR', '\$ USD', '€ EUR', '£ GBP'],
            onChanged: (value) => setState(() => _currency = value),
          ),
          const Divider(height: 24),
          _buildDropdownTile(
            title: 'Language',
            value: _language,
            icon: Icons.language_rounded,
            options: ['English', 'Malayalam', 'Hindi', 'Tamil'],
            onChanged: (value) => setState(() => _language = value),
          ),
          const Divider(height: 24),
          _buildDropdownTile(
            title: 'Date Format',
            value: _dateFormat,
            icon: Icons.calendar_today_rounded,
            options: ['DD/MM/YYYY', 'MM/DD/YYYY', 'YYYY-MM-DD'],
            onChanged: (value) => setState(() => _dateFormat = value),
          ),
        ],
      ),
    );
  }

  Widget _buildSecuritySection() {
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
            children: [
              Icon(Icons.security_rounded, color: AppColors.primaryBlue),
              const SizedBox(width: 8),
              Text(
                'Security',
                style: AppTextStyles.heading3.copyWith(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildActionTile(
            title: 'Change Password',
            subtitle: 'Update your account password',
            icon: Icons.lock_outline_rounded,
            onTap: () => _showChangePasswordDialog(),
          ),
          const Divider(height: 16),
          _buildActionTile(
            title: 'Two-Factor Authentication',
            subtitle: 'Add extra security to your account',
            icon: Icons.phonelink_lock_rounded,
            onTap: () {},
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.warning.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'Not Set',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.warning,
                ),
              ),
            ),
          ),
          const Divider(height: 16),
          _buildActionTile(
            title: 'Login History',
            subtitle: 'View your recent login activity',
            icon: Icons.history_rounded,
            onTap: () {},
          ),
          const Divider(height: 16),
          _buildActionTile(
            title: 'Active Sessions',
            subtitle: 'Manage devices where you\'re logged in',
            icon: Icons.devices_rounded,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildAccountActionsSection() {
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
            children: [
              Icon(Icons.manage_accounts_rounded, color: AppColors.primaryBlue),
              const SizedBox(width: 8),
              Text(
                'Account Actions',
                style: AppTextStyles.heading3.copyWith(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildActionTile(
            title: 'Export Data',
            subtitle: 'Download all your organization data',
            icon: Icons.download_rounded,
            onTap: () {},
          ),
          const Divider(height: 16),
          _buildActionTile(
            title: 'Backup Settings',
            subtitle: 'Configure automatic backups',
            icon: Icons.backup_rounded,
            onTap: () {},
          ),
          const Divider(height: 16),
          _buildActionTile(
            title: 'Admin Management',
            subtitle: 'Manage admin users and roles',
            icon: Icons.admin_panel_settings_rounded,
            onTap: () {},
          ),
          const Divider(height: 16),
          _buildActionTile(
            title: 'Audit Log',
            subtitle: 'View system activity log',
            icon: Icons.receipt_long_rounded,
            onTap: () {},
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => _showLogoutConfirmation(),
              icon: Icon(Icons.logout_rounded, color: AppColors.error),
              label: Text(
                'Logout',
                style: TextStyle(color: AppColors.error),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.error.withOpacity(0.5)),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String value,
    required IconData icon,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: TextEditingController(text: value),
          maxLines: maxLines,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, size: 20, color: AppColors.textLight),
            filled: true,
            fillColor: AppColors.backgroundLight,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.primaryBlue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.primaryBlue, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                subtitle,
                style: AppTextStyles.bodySmall,
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.primaryBlue,
        ),
      ],
    );
  }

  Widget _buildDropdownTile({
    required String title,
    required String value,
    required IconData icon,
    required List<String> options,
    required Function(String) onChanged,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.primaryBlue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.primaryBlue, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.backgroundLight,
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 20),
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w500,
              ),
              items: options.map((option) {
                return DropdownMenuItem(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              onChanged: (newValue) {
                if (newValue != null) {
                  onChanged(newValue);
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppColors.primaryBlue, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: AppTextStyles.bodySmall,
                  ),
                ],
              ),
            ),
            trailing ??
                const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.textLight,
                ),
          ],
        ),
      ),
    );
  }

  void _showChangePasswordDialog() {
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
              Text('Change Password', style: AppTextStyles.heading3),
              const SizedBox(height: 24),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Current Password',
                  prefixIcon: const Icon(Icons.lock_outline, size: 20),
                  filled: true,
                  fillColor: AppColors.backgroundLight,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  prefixIcon: const Icon(Icons.lock_outline, size: 20),
                  filled: true,
                  fillColor: AppColors.backgroundLight,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm New Password',
                  prefixIcon: const Icon(Icons.lock_outline, size: 20),
                  filled: true,
                  fillColor: AppColors.backgroundLight,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
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
                            content: const Text('Password changed successfully'),
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
                      child: const Text('Change Password'),
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

  void _showLogoutConfirmation() {
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
                Icons.logout_rounded,
                color: AppColors.error,
              ),
            ),
            const SizedBox(width: 12),
            const Text('Logout'),
          ],
        ),
        content: const Text(
          'Are you sure you want to logout from your account?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigate to login screen
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Logged out successfully'),
                  backgroundColor: AppColors.success,
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
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
