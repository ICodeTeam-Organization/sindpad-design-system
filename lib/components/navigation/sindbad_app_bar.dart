import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../foundations/dimensions/app_dimensions.dart';
import '../../theme/theme_extensions.dart';

/// Standard, theme-adaptive application bar for Sindbad applications.
///
/// Implements [PreferredSizeWidget] with support for title, subtitle,
/// leading and action widgets, bottom widgets, and optional subtle bottom divider.
class SindbadAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Primary text title.
  final String? title;

  /// Optional custom title widget. If provided, overrides [title] and [subtitle].
  final Widget? titleWidget;

  /// Secondary subtitle displayed below [title].
  final String? subtitle;

  /// Custom text style for the title. Defaults to design system `titleLarge`.
  final TextStyle? titleTextStyle;

  /// Custom text style for the subtitle. Defaults to design system `bodySmall`.
  final TextStyle? subtitleTextStyle;

  /// Leading widget displayed before the title.
  final Widget? leading;

  /// Whether to automatically imply a leading widget (back button / drawer trigger).
  final bool automaticallyImplyLeading;

  /// Action widgets displayed after the title.
  final List<Widget>? actions;

  /// Optional widget displayed at the bottom of the app bar (e.g. tabs or search bar).
  final PreferredSizeWidget? bottom;

  /// Whether the title should be centered.
  final bool? centerTitle;

  /// Background color override. Defaults to theme surface color.
  final Color? backgroundColor;

  /// Foreground/content color override for title and icons.
  final Color? foregroundColor;

  /// Elevation of the app bar.
  final double? elevation;

  /// Elevation when content is scrolled underneath.
  final double? scrolledUnderElevation;

  /// Whether to display a subtle 1px divider at the bottom edge.
  final bool showBottomDivider;

  /// Custom color for the bottom divider.
  final Color? dividerColor;

  /// Height of the toolbar part of the app bar. Defaults to [AppDimensions.appBarHeight] (56.0).
  final double toolbarHeight;

  /// System UI overlay style (status bar icon brightness, etc.).
  final SystemUiOverlayStyle? systemOverlayStyle;

  /// Shape of the app bar.
  final ShapeBorder? shape;

  const SindbadAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.subtitle,
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.actions,
    this.bottom,
    this.centerTitle,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 0,
    this.scrolledUnderElevation = 1,
    this.showBottomDivider = false,
    this.dividerColor,
    this.toolbarHeight = AppDimensions.appBarHeight,
    this.systemOverlayStyle,
    this.shape,
  });

  @override
  Size get preferredSize {
    final bottomHeight = bottom?.preferredSize.height ?? 0.0;
    final dividerHeight = showBottomDivider ? 1.0 : 0.0;
    return Size.fromHeight(toolbarHeight + bottomHeight + dividerHeight);
  }

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<SindpadThemeExtension>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bg = backgroundColor ??
        ext?.semanticColors.surface ??
        Theme.of(context).appBarTheme.backgroundColor ??
        (isDark ? const Color(0xFF141419) : Colors.white);

    final fg = foregroundColor ??
        ext?.semanticColors.textPrimary ??
        Theme.of(context).appBarTheme.foregroundColor ??
        (isDark ? Colors.white : const Color(0xFF141419));

    final textSecondary = ext?.semanticColors.textSecondary ??
        (isDark ? const Color(0xFF9E9EA8) : const Color(0xFF6B7280));

    final defaultDividerColor = ext?.semanticColors.borderSubtle ??
        (isDark ? Colors.white12 : const Color(0xFFE5E7EB));

    final resolvedDividerColor = dividerColor ?? defaultDividerColor;

    final isCentered = centerTitle ?? Theme.of(context).appBarTheme.centerTitle ?? false;

    // Resolve title layout
    final Widget? resolvedTitle = titleWidget ?? _buildTitle(
      context,
      ext,
      fg,
      textSecondary,
      isCentered,
    );

    // Resolve bottom widget with divider if enabled
    final PreferredSizeWidget? resolvedBottom = _buildBottom(resolvedDividerColor);

    return AppBar(
      title: resolvedTitle,
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      actions: actions,
      bottom: resolvedBottom,
      centerTitle: isCentered,
      backgroundColor: bg,
      foregroundColor: fg,
      elevation: elevation,
      scrolledUnderElevation: scrolledUnderElevation,
      toolbarHeight: toolbarHeight,
      systemOverlayStyle: systemOverlayStyle,
      shape: shape,
    );
  }

  Widget? _buildTitle(
    BuildContext context,
    SindpadThemeExtension? ext,
    Color textPrimary,
    Color textSecondary,
    bool isCentered,
  ) {
    if (title == null) return null;

    final resolvedTitleStyle = titleTextStyle ??
        ext?.typography.titleLarge.copyWith(
          fontWeight: FontWeight.bold,
          color: textPrimary,
        ) ??
        Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: textPrimary,
        ) ??
        TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: textPrimary,
        );

    if (subtitle == null || subtitle!.isEmpty) {
      return Text(
        title!,
        style: resolvedTitleStyle,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      );
    }

    final resolvedSubtitleStyle = subtitleTextStyle ??
        ext?.typography.bodySmall.copyWith(
          color: textSecondary,
        ) ??
        Theme.of(context).textTheme.bodySmall?.copyWith(
          color: textSecondary,
        ) ??
        TextStyle(
          fontSize: 12.0,
          color: textSecondary,
        );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment:
          isCentered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          title!,
          style: resolvedTitleStyle,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        const SizedBox(height: 2.0),
        Text(
          subtitle!,
          style: resolvedSubtitleStyle,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    );
  }

  PreferredSizeWidget? _buildBottom(Color resolvedDividerColor) {
    if (!showBottomDivider) {
      return bottom;
    }

    if (bottom == null) {
      return PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: resolvedDividerColor,
          height: 1.0,
        ),
      );
    }

    return _BottomWithDivider(
      bottom: bottom!,
      dividerColor: resolvedDividerColor,
    );
  }
}

class _BottomWithDivider extends StatelessWidget implements PreferredSizeWidget {
  final PreferredSizeWidget bottom;
  final Color dividerColor;

  const _BottomWithDivider({
    required this.bottom,
    required this.dividerColor,
  });

  @override
  Size get preferredSize => Size.fromHeight(bottom.preferredSize.height + 1.0);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        bottom,
        Container(
          color: dividerColor,
          height: 1.0,
        ),
      ],
    );
  }
}
