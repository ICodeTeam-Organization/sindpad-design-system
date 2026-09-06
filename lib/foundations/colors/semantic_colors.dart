import 'package:flutter/widgets.dart';

/// Contextual and intent-based semantic colors for an application.
///
/// Unlike [AppColors], which defines brand palette values, [SemanticColors]
/// defines functional meaning within a user interface (e.g., surface,
/// error, textPrimary, disabled).
@immutable
class SemanticColors {
  /// The primary canvas/scaffold background color.
  final Color background;

  /// Surface color for elevated cards, sheets, or dialogs.
  final Color surface;

  /// Subtle variation of surface for grouping or zebra striping.
  final Color surfaceSubtle;

  /// Primary readable text color.
  final Color textPrimary;

  /// Secondary/muted text color for captions, subtitles, and hints.
  final Color textSecondary;

  /// Text color applied when an element is disabled.
  final Color textDisabled;

  /// Text color placed on high-contrast/inverse surfaces or primary fills.
  final Color textInverse;

  /// Standard border color for form controls, dividers, and outlines.
  final Color border;

  /// Subtle border color for gentle separations.
  final Color borderSubtle;

  /// Dedicated divider line color.
  final Color divider;

  /// Semantic error/danger color.
  final Color error;

  /// Tinted surface background for error banners and toast notifications.
  final Color errorSurface;

  /// Semantic warning color.
  final Color warning;

  /// Tinted surface background for warning banners and alerts.
  final Color warningSurface;

  /// Semantic success color.
  final Color success;

  /// Tinted surface background for success messages and confirmations.
  final Color successSurface;

  /// Semantic informational color.
  final Color info;

  /// Tinted surface background for informational notes.
  final Color infoSurface;

  /// Color used for disabled controls, icons, and indicators.
  final Color disabled;

  /// Background surface color used for disabled buttons and inputs.
  final Color disabledSurface;

  const SemanticColors({
    required this.background,
    required this.surface,
    required this.surfaceSubtle,
    required this.textPrimary,
    required this.textSecondary,
    required this.textDisabled,
    required this.textInverse,
    required this.border,
    required this.borderSubtle,
    required this.divider,
    required this.error,
    required this.errorSurface,
    required this.warning,
    required this.warningSurface,
    required this.success,
    required this.successSurface,
    required this.info,
    required this.infoSurface,
    required this.disabled,
    required this.disabledSurface,
  });

  /// Default semantic color tokens for light mode.
  const SemanticColors.lightDefault()
      : background = const Color(0xFFF8FAFC),
        surface = const Color(0xFFFFFFFF),
        surfaceSubtle = const Color(0xFFF8FAFC),
        textPrimary = const Color(0xFF0F172A),
        textSecondary = const Color(0xFF334155),
        textDisabled = const Color(0xFFCBD5E1),
        textInverse = const Color(0xFFFFFFFF),
        border = const Color(0xFFE2E8F0),
        borderSubtle = const Color(0xFFF1F5F9),
        divider = const Color(0xFFF1F5F9),
        error = const Color(0xFFDC2626),
        errorSurface = const Color(0xFFFEF2F2),
        warning = const Color(0xFFF59E0B),
        warningSurface = const Color(0xFFFFFBEB),
        success = const Color(0xFF059669),
        successSurface = const Color(0xFFECFDF5),
        info = const Color(0xFF0284C7),
        infoSurface = const Color(0xFFF0F9FF),
        disabled = const Color(0xFFCBD5E1),
        disabledSurface = const Color(0xFFF1F5F9);

  /// Default semantic color tokens for dark mode.
  const SemanticColors.darkDefault()
      : background = const Color(0xFF111827),
        surface = const Color(0xFF1F2937),
        surfaceSubtle = const Color(0xFF374151),
        textPrimary = const Color(0xFFF9FAFB),
        textSecondary = const Color(0xFF9CA3AF),
        textDisabled = const Color(0xFF6B7280),
        textInverse = const Color(0xFF111827),
        border = const Color(0xFF374151),
        borderSubtle = const Color(0xFF1F2937),
        divider = const Color(0xFF374151),
        error = const Color(0xFFEF4444),
        errorSurface = const Color(0xFF450A0A),
        warning = const Color(0xFFF59E0B),
        warningSurface = const Color(0xFF451A03),
        success = const Color(0xFF22C55E),
        successSurface = const Color(0xFF052E16),
        info = const Color(0xFF3B82F6),
        infoSurface = const Color(0xFF172554),
        disabled = const Color(0xFF6B7280),
        disabledSurface = const Color(0xFF374151);

  /// Creates a copy of this [SemanticColors] with given fields replaced.
  SemanticColors copyWith({
    Color? background,
    Color? surface,
    Color? surfaceSubtle,
    Color? textPrimary,
    Color? textSecondary,
    Color? textDisabled,
    Color? textInverse,
    Color? border,
    Color? borderSubtle,
    Color? divider,
    Color? error,
    Color? errorSurface,
    Color? warning,
    Color? warningSurface,
    Color? success,
    Color? successSurface,
    Color? info,
    Color? infoSurface,
    Color? disabled,
    Color? disabledSurface,
  }) {
    return SemanticColors(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceSubtle: surfaceSubtle ?? this.surfaceSubtle,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textDisabled: textDisabled ?? this.textDisabled,
      textInverse: textInverse ?? this.textInverse,
      border: border ?? this.border,
      borderSubtle: borderSubtle ?? this.borderSubtle,
      divider: divider ?? this.divider,
      error: error ?? this.error,
      errorSurface: errorSurface ?? this.errorSurface,
      warning: warning ?? this.warning,
      warningSurface: warningSurface ?? this.warningSurface,
      success: success ?? this.success,
      successSurface: successSurface ?? this.successSurface,
      info: info ?? this.info,
      infoSurface: infoSurface ?? this.infoSurface,
      disabled: disabled ?? this.disabled,
      disabledSurface: disabledSurface ?? this.disabledSurface,
    );
  }

  /// Linearly interpolates between two [SemanticColors].
  static SemanticColors lerp(SemanticColors a, SemanticColors b, double t) {
    return SemanticColors(
      background: Color.lerp(a.background, b.background, t)!,
      surface: Color.lerp(a.surface, b.surface, t)!,
      surfaceSubtle: Color.lerp(a.surfaceSubtle, b.surfaceSubtle, t)!,
      textPrimary: Color.lerp(a.textPrimary, b.textPrimary, t)!,
      textSecondary: Color.lerp(a.textSecondary, b.textSecondary, t)!,
      textDisabled: Color.lerp(a.textDisabled, b.textDisabled, t)!,
      textInverse: Color.lerp(a.textInverse, b.textInverse, t)!,
      border: Color.lerp(a.border, b.border, t)!,
      borderSubtle: Color.lerp(a.borderSubtle, b.borderSubtle, t)!,
      divider: Color.lerp(a.divider, b.divider, t)!,
      error: Color.lerp(a.error, b.error, t)!,
      errorSurface: Color.lerp(a.errorSurface, b.errorSurface, t)!,
      warning: Color.lerp(a.warning, b.warning, t)!,
      warningSurface: Color.lerp(a.warningSurface, b.warningSurface, t)!,
      success: Color.lerp(a.success, b.success, t)!,
      successSurface: Color.lerp(a.successSurface, b.successSurface, t)!,
      info: Color.lerp(a.info, b.info, t)!,
      infoSurface: Color.lerp(a.infoSurface, b.infoSurface, t)!,
      disabled: Color.lerp(a.disabled, b.disabled, t)!,
      disabledSurface: Color.lerp(a.disabledSurface, b.disabledSurface, t)!,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SemanticColors &&
          runtimeType == other.runtimeType &&
          background == other.background &&
          surface == other.surface &&
          surfaceSubtle == other.surfaceSubtle &&
          textPrimary == other.textPrimary &&
          textSecondary == other.textSecondary &&
          textDisabled == other.textDisabled &&
          textInverse == other.textInverse &&
          border == other.border &&
          borderSubtle == other.borderSubtle &&
          divider == other.divider &&
          error == other.error &&
          errorSurface == other.errorSurface &&
          warning == other.warning &&
          warningSurface == other.warningSurface &&
          success == other.success &&
          successSurface == other.successSurface &&
          info == other.info &&
          infoSurface == other.infoSurface &&
          disabled == other.disabled &&
          disabledSurface == other.disabledSurface;

  @override
  int get hashCode => Object.hashAll([
        background,
        surface,
        surfaceSubtle,
        textPrimary,
        textSecondary,
        textDisabled,
        textInverse,
        border,
        borderSubtle,
        divider,
        error,
        errorSurface,
        warning,
        warningSurface,
        success,
        successSurface,
        info,
        infoSurface,
        disabled,
        disabledSurface,
      ]);
}
