import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/localization/language_provider.dart';

class LanguageSelector extends StatelessWidget {
  final bool showFullName;
  final bool isCompact;

  const LanguageSelector({
    super.key,
    this.showFullName = false,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return PopupMenuButton<String>(
      offset: const Offset(0, 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onSelected: (value) {
        if (value == 'en') {
          languageProvider.setEnglish();
        } else if (value == 'ml') {
          languageProvider.setMalayalam();
        }
      },
      itemBuilder: (context) => [
        _buildLanguageItem(
          context,
          code: 'en',
          name: 'English',
          flag: '🇬🇧',
          isSelected: languageProvider.isEnglish,
        ),
        _buildLanguageItem(
          context,
          code: 'ml',
          name: 'മലയാളം',
          flag: '🇮🇳',
          isSelected: languageProvider.isMalayalam,
        ),
      ],
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isCompact ? 8 : 12,
          vertical: isCompact ? 4 : 6,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderLight),
          borderRadius: BorderRadius.circular(isCompact ? 6 : 8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '🇮🇳',
              style: TextStyle(fontSize: isCompact ? 14 : 16),
            ),
            SizedBox(width: isCompact ? 4 : 6),
            Text(
              showFullName 
                  ? languageProvider.currentLanguageName 
                  : languageProvider.currentLanguageCode,
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: isCompact ? 11 : null,
              ),
            ),
            SizedBox(width: isCompact ? 2 : 4),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              size: isCompact ? 16 : 18,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  PopupMenuItem<String> _buildLanguageItem(
    BuildContext context, {
    required String code,
    required String name,
    required String flag,
    required bool isSelected,
  }) {
    return PopupMenuItem<String>(
      value: code,
      child: Row(
        children: [
          Text(flag, style: const TextStyle(fontSize: 18)),
          const SizedBox(width: 12),
          Text(
            name,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              color: isSelected ? AppColors.primaryBlue : AppColors.textPrimary,
            ),
          ),
          const Spacer(),
          if (isSelected)
            const Icon(
              Icons.check_circle,
              color: AppColors.primaryBlue,
              size: 20,
            ),
        ],
      ),
    );
  }
}
