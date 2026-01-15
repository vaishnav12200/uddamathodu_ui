import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      // App General
      'app_name': 'Uddamthodu Tharavad',
      'management_system': 'Management System',
      'member_portal': 'Member Portal',
      'admin_portal': 'Admin Portal',
      
      // Landing Page
      'welcome_to': 'Welcome to',
      'welcome_description': 'Efficiently manage Tharavad\'s finances, contributions, and notices with ease and transparency.',
      'member_login': 'Member Login',
      'admin_login': 'Admin Login',
      'login': 'Login',
      'sign_up': 'Sign Up',
      
      // Feature Cards
      'safe_transparent': 'Safe & Transparent',
      'financial_management': 'Financial Management',
      'financial_desc': 'Digitally track contributions & expenses. Generate receipts with manual verification.',
      'easy_upi': 'Easy UPI Payments',
      'receipts': 'Receipts',
      'upi_desc': 'Make secure UPI payments & share UTR. Download digital receipts as PDF.',
      'official_notices': 'Official Notices Module',
      'notices_desc': 'Post official notices. Members get text alerts. Manage contributions, donations & expenses.',
      
      // Login Screen
      'welcome_back': 'Welcome Back!',
      'select_role': 'Select Role',
      'are_you_logging_as': 'Are you logging in as?',
      'enter_username': 'Enter your username',
      'password': 'Password',
      'remember_me': 'Remember me',
      'forgot_password': 'Forgot password?',
      'back_to_home': 'Back to Home',
      'no_account': "Don't have an account?",
      'need_help': 'Need help? Contact us',
      
      // Roles
      'member': 'Member',
      'president': 'President',
      'secretary': 'Secretary',
      'treasurer': 'Treasurer',
      
      // Dashboard
      'member_dashboard': 'Member Dashboard',
      'admin_dashboard': 'Admin Dashboard',
      'dashboard': 'Dashboard',
      'contributions': 'Contributions',
      'notices': 'Notices',
      'profile': 'Profile',
      
      // Welcome Card
      'good_morning': 'Good Morning',
      'good_afternoon': 'Good Afternoon',
      'good_evening': 'Good Evening',
      'member_id': 'Member ID',
      'total_family_balance': 'Total Family Balance',
      
      // Balance Card
      'total_paid_amount': 'Total Paid Amount',
      'pending_balance': 'Pending Balance',
      'pay_now': 'Pay Now',
      'pending': 'Pending',
      
      // Payment History
      'payment_history': 'Payment History',
      'contribution_history': 'Contribution History',
      'view_all': 'View All',
      'date': 'Date',
      'amount': 'Amount',
      'type': 'Type',
      'status': 'Status',
      'verified': 'Verified',
      'paid': 'Paid',
      'unpaid': 'Unpaid',
      
      // UPI Transaction
      'submit_upi_payment': 'Submit UPI Payment',
      'enter_amount': 'Enter Amount',
      'utr_number': 'UTR Number',
      'enter_utr': 'Enter 12-digit UTR number',
      'contribution_type': 'Contribution Type',
      'select_type': 'Select Type',
      'monthly_contribution': 'Monthly Contribution',
      'special_contribution': 'Special Contribution',
      'donation': 'Donation',
      'submit_payment': 'Submit Payment',
      'payment_submitted': 'Payment Submitted Successfully!',
      'pending_verification': 'Pending admin verification',
      
      // Notice Board
      'notice_board': 'Notice Board',
      'important': 'Important',
      'new_notice': 'New',
      'new_badge': 'New',
      'read_more': 'Read More',
      
      // Receipts
      'recent_receipts': 'Recent Receipts',
      'download': 'Download',
      'receipt': 'Receipt',
      'receipt_no': 'Receipt No',
      
      // Profile
      'my_profile': 'My Profile',
      'personal_info': 'Personal Information',
      'full_name': 'Full Name',
      'email': 'Email',
      'phone': 'Phone',
      'address': 'Address',
      'edit_profile': 'Edit Profile',
      'change_password': 'Change Password',
      
      // Settings
      'settings': 'Settings',
      'language': 'Language',
      'english': 'English',
      'malayalam': 'മലയാളം',
      'notifications': 'Notifications',
      'dark_mode': 'Dark Mode',
      
      // Actions
      'logout': 'Logout',
      'save': 'Save',
      'cancel': 'Cancel',
      'submit': 'Submit',
      'confirm': 'Confirm',
      'close': 'Close',
      'help': 'Help',
      
      // Messages
      'loading': 'Loading...',
      'error_occurred': 'An error occurred',
      'success': 'Success',
      'coming_soon': 'Coming Soon',
      'feature_coming_soon': 'This feature is coming soon!',
    },
    'ml': {
      // App General
      'app_name': 'ഉദ്ദംതോട് തറവാട്',
      'management_system': 'മാനേജ്‌മെന്റ് സിസ്റ്റം',
      'member_portal': 'അംഗ പോർട്ടൽ',
      'admin_portal': 'അഡ്മിൻ പോർട്ടൽ',
      
      // Landing Page
      'welcome_to': 'സ്വാഗതം',
      'welcome_description': 'തറവാടിന്റെ സാമ്പത്തികം, സംഭാവനകൾ, അറിയിപ്പുകൾ എന്നിവ എളുപ്പത്തിലും സുതാര്യമായും കൈകാര്യം ചെയ്യുക.',
      'member_login': 'അംഗ ലോഗിൻ',
      'admin_login': 'അഡ്മിൻ ലോഗിൻ',
      'login': 'ലോഗിൻ',
      'sign_up': 'സൈൻ അപ്പ്',
      
      // Feature Cards
      'safe_transparent': 'സുരക്ഷിതവും സുതാര്യവും',
      'financial_management': 'സാമ്പത്തിക മാനേജ്‌മെന്റ്',
      'financial_desc': 'സംഭാവനകളും ചെലവുകളും ഡിജിറ്റലായി ട്രാക്ക് ചെയ്യുക. മാനുവൽ പരിശോധനയോടെ രസീതുകൾ ജനറേറ്റ് ചെയ്യുക.',
      'easy_upi': 'എളുപ്പമുള്ള UPI പേയ്‌മെന്റുകൾ',
      'receipts': 'രസീതുകൾ',
      'upi_desc': 'സുരക്ഷിത UPI പേയ്‌മെന്റുകൾ നടത്തുക & UTR പങ്കിടുക. PDF ആയി ഡിജിറ്റൽ രസീതുകൾ ഡൗൺലോഡ് ചെയ്യുക.',
      'official_notices': 'ഔദ്യോഗിക അറിയിപ്പുകൾ',
      'notices_desc': 'ഔദ്യോഗിക അറിയിപ്പുകൾ പോസ്റ്റ് ചെയ്യുക. അംഗങ്ങൾക്ക് ടെക്സ്റ്റ് അലേർട്ടുകൾ ലഭിക്കും. സംഭാവനകൾ, സംഭാവനകൾ, ചെലവുകൾ എന്നിവ കൈകാര്യം ചെയ്യുക.',
      
      // Login Screen
      'welcome_back': 'വീണ്ടും സ്വാഗതം!',
      'select_role': 'റോൾ തിരഞ്ഞെടുക്കുക',
      'are_you_logging_as': 'നിങ്ങൾ ആരായി ലോഗിൻ ചെയ്യുന്നു?',
      'enter_username': 'നിങ്ങളുടെ യൂസർനെയിം നൽകുക',
      'password': 'പാസ്‌വേഡ്',
      'remember_me': 'എന്നെ ഓർക്കുക',
      'forgot_password': 'പാസ്‌വേഡ് മറന്നോ?',
      'back_to_home': 'ഹോമിലേക്ക് മടങ്ങുക',
      'no_account': 'അക്കൗണ്ട് ഇല്ലേ?',
      'need_help': 'സഹായം വേണോ? ഞങ്ങളെ ബന്ധപ്പെടുക',
      
      // Roles
      'member': 'അംഗം',
      'president': 'പ്രസിഡന്റ്',
      'secretary': 'സെക്രട്ടറി',
      'treasurer': 'ട്രഷറർ',
      
      // Dashboard
      'member_dashboard': 'അംഗ ഡാഷ്‌ബോർഡ്',
      'admin_dashboard': 'അഡ്മിൻ ഡാഷ്‌ബോർഡ്',
      'dashboard': 'ഡാഷ്‌ബോർഡ്',
      'contributions': 'സംഭാവനകൾ',
      'notices': 'അറിയിപ്പുകൾ',
      'profile': 'പ്രൊഫൈൽ',
      
      // Welcome Card
      'good_morning': 'സുപ്രഭാതം',
      'good_afternoon': 'ശുഭ ഉച്ച',
      'good_evening': 'ശുഭ സന്ധ്യ',
      'member_id': 'അംഗ ID',
      'total_family_balance': 'മൊത്തം കുടുംബ ബാലൻസ്',
      
      // Balance Card
      'total_paid_amount': 'മൊത്തം അടച്ച തുക',
      'pending_balance': 'ബാക്കി തുക',
      'pay_now': 'ഇപ്പോൾ അടയ്ക്കുക',
      'pending': 'തീർപ്പാക്കാത്തത്',
      
      // Payment History
      'payment_history': 'പേയ്‌മെന്റ് ചരിത്രം',
      'contribution_history': 'സംഭാവന ചരിത്രം',
      'view_all': 'എല്ലാം കാണുക',
      'date': 'തീയതി',
      'amount': 'തുക',
      'type': 'തരം',
      'status': 'സ്ഥിതി',
      'verified': 'പരിശോധിച്ചു',
      'paid': 'അടച്ചു',
      'unpaid': 'അടച്ചിട്ടില്ല',
      
      // UPI Transaction
      'submit_upi_payment': 'UPI പേയ്‌മെന്റ് സമർപ്പിക്കുക',
      'enter_amount': 'തുക നൽകുക',
      'utr_number': 'UTR നമ്പർ',
      'enter_utr': '12 അക്ക UTR നമ്പർ നൽകുക',
      'contribution_type': 'സംഭാവന തരം',
      'select_type': 'തരം തിരഞ്ഞെടുക്കുക',
      'monthly_contribution': 'മാസ സംഭാവന',
      'special_contribution': 'പ്രത്യേക സംഭാവന',
      'donation': 'സംഭാവന',
      'submit_payment': 'പേയ്‌മെന്റ് സമർപ്പിക്കുക',
      'payment_submitted': 'പേയ്‌മെന്റ് വിജയകരമായി സമർപ്പിച്ചു!',
      'pending_verification': 'അഡ്മിൻ പരിശോധന കാത്തിരിക്കുന്നു',
      
      // Notice Board
      'notice_board': 'നോട്ടീസ് ബോർഡ്',
      'important': 'പ്രധാനം',
      'new_notice': 'പുതിയത്',
      'new_badge': 'പുതിയത്',
      'read_more': 'കൂടുതൽ വായിക്കുക',
      
      // Receipts
      'recent_receipts': 'സമീപകാല രസീതുകൾ',
      'download': 'ഡൗൺലോഡ്',
      'receipt': 'രസീത്',
      'receipt_no': 'രസീത് നമ്പർ',
      
      // Profile
      'my_profile': 'എന്റെ പ്രൊഫൈൽ',
      'personal_info': 'വ്യക്തിഗത വിവരങ്ങൾ',
      'full_name': 'മുഴുവൻ പേര്',
      'email': 'ഇമെയിൽ',
      'phone': 'ഫോൺ',
      'address': 'വിലാസം',
      'edit_profile': 'പ്രൊഫൈൽ എഡിറ്റ് ചെയ്യുക',
      'change_password': 'പാസ്‌വേഡ് മാറ്റുക',
      
      // Settings
      'settings': 'ക്രമീകരണങ്ങൾ',
      'language': 'ഭാഷ',
      'english': 'English',
      'malayalam': 'മലയാളം',
      'notifications': 'അറിയിപ്പുകൾ',
      'dark_mode': 'ഡാർക്ക് മോഡ്',
      
      // Actions
      'logout': 'ലോഗൗട്ട്',
      'save': 'സേവ് ചെയ്യുക',
      'cancel': 'റദ്ദാക്കുക',
      'submit': 'സമർപ്പിക്കുക',
      'confirm': 'സ്ഥിരീകരിക്കുക',
      'close': 'അടയ്ക്കുക',
      'help': 'സഹായം',
      
      // Messages
      'loading': 'ലോഡ് ചെയ്യുന്നു...',
      'error_occurred': 'ഒരു പിശക് സംഭവിച്ചു',
      'success': 'വിജയം',
      'coming_soon': 'ഉടൻ വരുന്നു',
      'feature_coming_soon': 'ഈ ഫീച്ചർ ഉടൻ വരുന്നു!',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? 
           _localizedValues['en']?[key] ?? 
           key;
  }

  // Shortcut getter for easy access
  String get(String key) => translate(key);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ml'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

// Extension for easy access
extension LocalizationExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
  String tr(String key) => AppLocalizations.of(this)?.translate(key) ?? key;
}
