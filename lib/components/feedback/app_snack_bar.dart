import 'package:flutter/material.dart';

import '../../foundations/colors/semantic_colors.dart';
import '../../theme/theme_extensions.dart';

/// The visual and behavioral intent of an [AppSnackBar].
enum AppSnackBarType {
  /// A neutral message with no special intent.
  defaultMessage,

  /// An operation completed successfully.
  success,

  /// Something went wrong.
  error,

  /// An important caution requires attention.
  warning,

  /// General information for the user.
  info,

  /// An operation is still running.
  loading,
}

/// A theme-aware, reusable snackbar for common application feedback states.
class AppSnackBar extends SnackBar {
  AppSnackBar({
    super.key,
    required String message,
    AppSnackBarType type = AppSnackBarType.defaultMessage,
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 4),
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    ShapeBorder? shape,
    required Color backgroundColor,
    required Color foregroundColor,
    Color? indicatorColor,
    bool? showProgress,
  }) : super(
         content: Row(
           children: [
             if (showProgress ?? type == AppSnackBarType.loading) ...[
               SizedBox(
                 width: 18,
                 height: 18,
                 child: CircularProgressIndicator(
                   strokeWidth: 2,
                   color: foregroundColor,
                 ),
               ),
               const SizedBox(width: 12),
             ] else if (indicatorColor != null) ...[
               Icon(Icons.circle, size: 10, color: indicatorColor),
               const SizedBox(width: 10),
             ],
             Expanded(
               child: Text(
                 message,
                 maxLines: 3,
                 overflow: TextOverflow.ellipsis,
                 style: TextStyle(color: foregroundColor),
               ),
             ),
           ],
         ),
         backgroundColor: backgroundColor,
         action: actionLabel == null
             ? null
             : SnackBarAction(
                 label: actionLabel,
                 textColor: foregroundColor,
                 onPressed: onAction ?? () {},
               ),
         duration: type == AppSnackBarType.loading
             ? const Duration(days: 1)
             : duration,
         behavior: behavior,
         shape:
             shape ??
             RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
         showCloseIcon: type == AppSnackBarType.loading,
         closeIconColor: foregroundColor,
       );

  /// Shows a snackbar using the nearest [ScaffoldMessenger].
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> show(
    BuildContext context, {
    required String message,
    AppSnackBarType type = AppSnackBarType.defaultMessage,
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 4),
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    ShapeBorder? shape,
    bool replaceCurrent = true,
  }) {
    final messenger = ScaffoldMessenger.of(context);
    if (replaceCurrent) messenger.hideCurrentSnackBar();

    return messenger.showSnackBar(
      _fromContext(
        context,
        message: message,
        type: type,
        actionLabel: actionLabel,
        onAction: onAction,
        duration: duration,
        behavior: behavior,
        shape: shape,
      ),
    );
  }

  /// Shows a snackbar through a supplied application-level messenger key.
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>? showGlobal({
    required GlobalKey<ScaffoldMessengerState> messengerKey,
    required BuildContext context,
    required String message,
    AppSnackBarType type = AppSnackBarType.defaultMessage,
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 4),
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    ShapeBorder? shape,
    bool replaceCurrent = true,
  }) {
    final messenger = messengerKey.currentState;
    if (messenger == null) return null;
    if (replaceCurrent) messenger.hideCurrentSnackBar();

    return messenger.showSnackBar(
      _fromContext(
        context,
        message: message,
        type: type,
        actionLabel: actionLabel,
        onAction: onAction,
        duration: duration,
        behavior: behavior,
        shape: shape,
      ),
    );
  }

  /// Hides the current snackbar and returns the messenger to its idle state.
  static void hide(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  static AppSnackBar _fromContext(
    BuildContext context, {
    required String message,
    required AppSnackBarType type,
    String? actionLabel,
    VoidCallback? onAction,
    required Duration duration,
    required SnackBarBehavior behavior,
    ShapeBorder? shape,
  }) {
    final theme = Theme.of(context);
    final colors = theme.extension<SindpadThemeExtension>()?.semanticColors;
    final scheme = theme.colorScheme;
    final palette = _SnackBarPalette.from(type, colors, scheme);

    return AppSnackBar(
      message: message,
      type: type,
      actionLabel: actionLabel,
      onAction: onAction,
      duration: duration,
      behavior: behavior,
      shape: shape,
      backgroundColor: palette.background,
      foregroundColor: palette.foreground,
      indicatorColor: palette.indicator,
    );
  }
}

class _SnackBarPalette {
  const _SnackBarPalette({
    required this.background,
    required this.foreground,
    required this.indicator,
  });

  final Color background;
  final Color foreground;
  final Color indicator;

  factory _SnackBarPalette.from(
    AppSnackBarType type,
    SemanticColors? colors,
    ColorScheme scheme,
  ) {
    if (colors == null) {
      final background = switch (type) {
        AppSnackBarType.success => scheme.primary,
        AppSnackBarType.error => scheme.error,
        AppSnackBarType.warning => scheme.tertiary,
        AppSnackBarType.info => scheme.secondary,
        AppSnackBarType.loading => scheme.primary,
        AppSnackBarType.defaultMessage => scheme.inverseSurface,
      };
      return _SnackBarPalette(
        background: background,
        foreground: scheme.onInverseSurface,
        indicator: scheme.onInverseSurface,
      );
    }

    final background = switch (type) {
      AppSnackBarType.success => colors.success,
      AppSnackBarType.error => colors.error,
      AppSnackBarType.warning => colors.warning,
      AppSnackBarType.info => colors.info,
      AppSnackBarType.loading => colors.surface,
      AppSnackBarType.defaultMessage => colors.surface,
    };
    final foreground = switch (type) {
      AppSnackBarType.loading ||
      AppSnackBarType.defaultMessage => colors.textPrimary,
      _ => colors.textInverse,
    };

    return _SnackBarPalette(
      background: background,
      foreground: foreground,
      indicator: foreground,
    );
  }
}
