import 'package:flutter/material.dart';

/// Pure presentation modal bottom sheet for displaying app metadata,
/// version diagnostics, host system details, and company attribution.
class SindbadAboutAppModal extends StatelessWidget {
  final String appName;
  final String? appSubtitle;
  final String version;
  final String? systemInfo;
  final String? companyName;
  final String? copyright;
  final String closeButtonText;
  final Widget? appIcon;
  final Color? primaryColor;
  final String labelVersion;
  final String labelSystem;
  final String labelCompany;

  const SindbadAboutAppModal({
    super.key,
    required this.appName,
    this.appSubtitle,
    required this.version,
    this.systemInfo,
    this.companyName,
    this.copyright,
    this.closeButtonText = 'إغلاق',
    this.appIcon,
    this.primaryColor,
    this.labelVersion = 'إصدار التطبيق',
    this.labelSystem = 'نظام التشغيل',
    this.labelCompany = 'الشركة المطورة',
  });

  /// Static helper to show the modal bottom sheet
  static Future<T?> show<T>({
    required BuildContext context,
    required String appName,
    String? appSubtitle,
    required String version,
    String? systemInfo,
    String? companyName,
    String? copyright,
    String closeButtonText = 'إغلاق',
    Widget? appIcon,
    Color? primaryColor,
    String labelVersion = 'إصدار التطبيق',
    String labelSystem = 'نظام التشغيل',
    String labelCompany = 'الشركة المطورة',
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final modalBg = isDark ? const Color(0xFF1E1E26) : Colors.white;

    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: modalBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
      builder: (_) {
        return SindbadAboutAppModal(
          appName: appName,
          appSubtitle: appSubtitle,
          version: version,
          systemInfo: systemInfo,
          companyName: companyName,
          copyright: copyright,
          closeButtonText: closeButtonText,
          appIcon: appIcon,
          primaryColor: primaryColor,
          labelVersion: labelVersion,
          labelSystem: labelSystem,
          labelCompany: labelCompany,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = primaryColor ?? Theme.of(context).primaryColor;
    final textPrimary = isDark ? Colors.white : const Color(0xFF141419);
    final textSecondary =
        isDark ? const Color(0xFF9E9EA8) : const Color(0xFF6B7280);
    final handleColor = isDark ? Colors.white24 : Colors.grey[300];
    final dividerColor = isDark ? Colors.white12 : Colors.grey[200]!;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 36.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 40.0,
            height: 4.0,
            decoration: BoxDecoration(
              color: handleColor,
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          const SizedBox(height: 20.0),

          // App Icon Badge
          appIcon ??
              Container(
                width: 72.0,
                height: 72.0,
                decoration: BoxDecoration(
                  color: primary.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: primary.withValues(alpha: 0.25),
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.storefront_rounded,
                    size: 38.0,
                    color: primary,
                  ),
                ),
              ),
          const SizedBox(height: 14.0),

          // App Title
          Text(
            appName,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: textPrimary,
            ),
            textAlign: TextAlign.center,
          ),

          // App Subtitle
          if (appSubtitle != null && appSubtitle!.isNotEmpty) ...[
            const SizedBox(height: 4.0),
            Text(
              appSubtitle!,
              style: TextStyle(
                fontSize: 14.0,
                color: primary,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
          const SizedBox(height: 24.0),

          // Metadata Rows
          _buildRow(
            icon: Icons.tag_rounded,
            label: labelVersion,
            value: version,
            primaryColor: primary,
            textPrimary: textPrimary,
            textSecondary: textSecondary,
          ),

          if (systemInfo != null && systemInfo!.isNotEmpty) ...[
            Divider(height: 20.0, color: dividerColor),
            _buildRow(
              icon: Icons.phone_android_rounded,
              label: labelSystem,
              value: systemInfo!,
              primaryColor: primary,
              textPrimary: textPrimary,
              textSecondary: textSecondary,
            ),
          ],

          if (companyName != null && companyName!.isNotEmpty) ...[
            Divider(height: 20.0, color: dividerColor),
            _buildRow(
              icon: Icons.business_rounded,
              label: labelCompany,
              value: companyName!,
              primaryColor: primary,
              textPrimary: textPrimary,
              textSecondary: textSecondary,
            ),
          ],

          // Copyright
          if (copyright != null && copyright!.isNotEmpty) ...[
            const SizedBox(height: 20.0),
            Text(
              copyright!,
              style: TextStyle(
                fontSize: 12.0,
                color: textSecondary.withValues(alpha: 0.8),
              ),
              textAlign: TextAlign.center,
            ),
          ],
          const SizedBox(height: 20.0),

          // Close Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              onPressed: () => Navigator.pop(context),
              child: Text(
                closeButtonText,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow({
    required IconData icon,
    required String label,
    required String value,
    required Color primaryColor,
    required Color textPrimary,
    required Color textSecondary,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(icon, color: primaryColor, size: 20.0),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontSize: 14.0, color: textSecondary),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        const SizedBox(width: 8.0),
        Flexible(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w700,
              color: textPrimary,
            ),
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
