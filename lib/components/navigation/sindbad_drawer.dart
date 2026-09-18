import 'package:flutter/material.dart';

/// Representation of an account or diagnostic info item shown in [SindbadDrawer].
class SindbadDrawerInfo {
  final String label;
  final String value;
  final IconData? icon;

  const SindbadDrawerInfo({
    required this.label,
    required this.value,
    this.icon,
  });
}

/// Action item displayed in the quick actions section of [SindbadDrawer].
class SindbadDrawerAction {
  final String title;
  final VoidCallback? onTap;
  final Widget? trailing;
  final Color? textColor;
  final IconData? icon;

  const SindbadDrawerAction({
    required this.title,
    this.onTap,
    this.trailing,
    this.textColor,
    this.icon,
  });
}

/// Pure presentation, state-decoupled navigation and administrative drawer
/// designed for Sindbad applications.
class SindbadDrawer extends StatelessWidget {
  final String userName;
  final String? subtitle;
  final String? avatarLetter;
  final List<SindbadDrawerInfo> info;
  final List<SindbadDrawerAction> actions;
  final String? version;
  final String? versionFooterText;
  final Widget? header;
  final double? width;
  final VoidCallback? onVersionTap;

  // Settings Section Options (Decoupled from state management)
  final bool showSettings;
  final Widget? settingsSection;
  final bool isDarkMode;
  final ValueChanged<bool>? onThemeChanged;
  final String? currentLanguageCode;
  final ValueChanged<String>? onLanguageChanged;
  final String settingsTitle;
  final String darkModeLabel;
  final String languageLabel;
  final String arabicLabel;
  final String englishLabel;
  final Color? primaryColor;

  const SindbadDrawer({
    super.key,
    this.userName = '',
    this.subtitle,
    this.avatarLetter,
    this.info = const [],
    this.actions = const [],
    this.version,
    this.versionFooterText,
    this.header,
    this.width,
    this.onVersionTap,
    this.showSettings = true,
    this.settingsSection,
    this.isDarkMode = false,
    this.onThemeChanged,
    this.currentLanguageCode = 'ar',
    this.onLanguageChanged,
    this.settingsTitle = 'الإعدادات والمظهر',
    this.darkModeLabel = 'الوضع الليلي',
    this.languageLabel = 'اللغة',
    this.arabicLabel = 'عربي',
    this.englishLabel = 'English',
    this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    final drawerWidth = width ?? MediaQuery.sizeOf(context).width * 0.84;
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final primary = primaryColor ?? Theme.of(context).primaryColor;
    final textPrimary = isDarkTheme ? Colors.white : const Color(0xFF141419);
    final textSecondary =
        isDarkTheme ? const Color(0xFF9E9EA8) : const Color(0xFF6B7280);

    return Drawer(
      backgroundColor:
          isDarkTheme ? const Color(0xFF141419) : const Color(0xFFF9FAFB),
      width: drawerWidth.clamp(280.0, 360.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          bottomLeft: Radius.circular(20.0),
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header
              header ?? _buildDefaultHeader(context, textPrimary, primary),

              // Account Information Section
              if (info.isNotEmpty) ...[
                const SizedBox(height: 16.0),
                _DrawerSection(
                  title: 'معلومات الحساب',
                  child: Column(
                    children: info.asMap().entries.map((entry) {
                      final index = entry.key;
                      final item = entry.value;
                      final isLast = index == info.length - 1;
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                if (item.icon != null) ...[
                                  Icon(
                                    item.icon,
                                    size: 18.0,
                                    color: textSecondary,
                                  ),
                                  const SizedBox(width: 8.0),
                                ],
                                Expanded(
                                  child: Text(
                                    item.label,
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      color: textSecondary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                Flexible(
                                  child: Text(
                                    item.value,
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      color: textPrimary,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (!isLast)
                            Divider(
                              height: 1.0,
                              color: isDarkTheme
                                  ? Colors.white12
                                  : const Color(0xFFE5E7EB),
                            ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],

              // Actions Section
              if (actions.isNotEmpty) ...[
                const SizedBox(height: 14.0),
                _DrawerSection(
                  title: 'إجراءات سريعة',
                  child: Column(
                    children: actions.asMap().entries.map((entry) {
                      final index = entry.key;
                      final action = entry.value;
                      final isLast = index == actions.length - 1;
                      final color = action.textColor ?? textPrimary;

                      return Column(
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(10.0),
                            onTap: action.onTap,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10.0,
                                horizontal: 4.0,
                              ),
                              child: Row(
                                children: [
                                  if (action.icon != null) ...[
                                    Icon(action.icon, size: 20.0, color: color),
                                    const SizedBox(width: 10.0),
                                  ],
                                  Expanded(
                                    child: Text(
                                      action.title,
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: color,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  action.trailing ??
                                      Icon(
                                        Icons.arrow_back_ios_new_rounded,
                                        size: 14.0,
                                        color: color.withValues(alpha: 0.6),
                                      ),
                                ],
                              ),
                            ),
                          ),
                          if (!isLast)
                            Divider(
                              height: 1.0,
                              color: isDarkTheme
                                  ? Colors.white10
                                  : const Color(0xFFE5E7EB).withValues(
                                      alpha: 0.4,
                                    ),
                            ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],

              // Settings & Appearance Section
              if (showSettings) ...[
                const SizedBox(height: 14.0),
                settingsSection ??
                    _buildSettingsSection(
                      context,
                      isDarkTheme,
                      textPrimary,
                      textSecondary,
                      primary,
                    ),
              ],

              // Version / Branding Footer
              if (version != null) ...[
                const SizedBox(height: 24.0),
                InkWell(
                  borderRadius: BorderRadius.circular(8.0),
                  onTap: onVersionTap,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 4.0,
                    ),
                    child: Text(
                      versionFooterText != null
                          ? 'v$version • $versionFooterText'
                          : 'v$version',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: textSecondary.withValues(alpha: 0.7),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDefaultHeader(
    BuildContext context,
    Color textPrimary,
    Color primary,
  ) {
    final letter = avatarLetter ??
        (userName.trim().isNotEmpty ? userName.trim()[0].toUpperCase() : 'م');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: primary, width: 2.0),
            ),
            child: CircleAvatar(
              radius: 36.0,
              backgroundColor: primary,
              child: Text(
                letter,
                style: const TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            userName.isNotEmpty ? userName : 'المستخدم',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4.0),
            Text(
              subtitle!,
              style: TextStyle(
                fontSize: 12.0,
                color: primary,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSettingsSection(
    BuildContext context,
    bool isDarkTheme,
    Color textPrimary,
    Color textSecondary,
    Color primary,
  ) {
    final isArabic = currentLanguageCode == 'ar';

    return _DrawerSection(
      title: settingsTitle,
      child: Column(
        children: [
          // Theme Switch
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 4.0,
              horizontal: 4.0,
            ),
            child: Row(
              children: [
                Icon(
                  isDarkMode ? Icons.nightlight_round : Icons.wb_sunny_rounded,
                  size: 20.0,
                  color: isDarkMode
                      ? const Color(0xFFFFB74D)
                      : const Color(0xFFFFA000),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    darkModeLabel,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Switch.adaptive(
                  value: isDarkMode,
                  activeTrackColor: primary,
                  onChanged: onThemeChanged,
                ),
              ],
            ),
          ),
          Divider(
            height: 1.0,
            color: isDarkTheme ? Colors.white12 : const Color(0xFFE5E7EB),
          ),
          // Language Switch
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 4.0,
            ),
            child: Row(
              children: [
                Icon(Icons.language_rounded, size: 20.0, color: primary),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    languageLabel,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(20.0),
                  onTap: () {
                    final next = isArabic ? 'en' : 'ar';
                    onLanguageChanged?.call(next);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4.0,
                      vertical: 4.0,
                    ),
                    decoration: BoxDecoration(
                      color: isDarkTheme
                          ? const Color(0xFF282834)
                          : const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        color: primary.withValues(alpha: 0.3),
                        width: 1.0,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 4.0,
                          ),
                          decoration: BoxDecoration(
                            color: isArabic ? primary : Colors.transparent,
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          child: Text(
                            arabicLabel,
                            style: TextStyle(
                              fontSize: 12.0,
                              color: isArabic
                                  ? Colors.white
                                  : (isDarkTheme
                                      ? Colors.white60
                                      : textSecondary),
                              fontWeight:
                                  isArabic ? FontWeight.bold : FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 4.0,
                          ),
                          decoration: BoxDecoration(
                            color: !isArabic ? primary : Colors.transparent,
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          child: Text(
                            englishLabel,
                            style: TextStyle(
                              fontSize: 12.0,
                              color: !isArabic
                                  ? Colors.white
                                  : (isDarkTheme
                                      ? Colors.white60
                                      : textSecondary),
                              fontWeight:
                                  !isArabic ? FontWeight.bold : FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerSection extends StatelessWidget {
  final String title;
  final Widget child;

  const _DrawerSection({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? const Color(0xFF1E1E26) : Colors.white;
    final borderColor = isDark ? Colors.white12 : const Color(0xFFE5E7EB);
    final titleColor =
        isDark ? const Color(0xFFA0A0B0) : const Color(0xFF6B7280);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
                color: titleColor,
                letterSpacing: 0.3,
              ),
            ),
          ),
          const SizedBox(height: 4.0),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14.0,
              vertical: 6.0,
            ),
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: borderColor, width: 1.0),
              boxShadow: isDark
                  ? null
                  : [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 8.0,
                        offset: const Offset(0, 2.0),
                      ),
                    ],
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}
