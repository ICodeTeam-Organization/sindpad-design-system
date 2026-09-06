import 'package:flutter/widgets.dart';

/// Represents raw and brand-level color palettes for an application.
///
/// Unlike [SemanticColors], which map to contextual intent (e.g. error, surface),
/// [AppColors] holds the direct brand tones such as primary, secondary, accent,
/// and neutral shades.
@immutable
class AppColors {
  /// The primary brand color.
  final Color primary;

  /// A lighter or alternative tint of the primary color.
  final Color primaryContainer;

  /// The secondary brand color.
  final Color secondary;

  /// A lighter or alternative tint of the secondary color.
  final Color secondaryContainer;

  /// Accent color used for highlights, badges, or special focus areas.
  final Color accent;

  /// Neutral palette used for backgrounds, borders, and general structure.
  final Color neutral;

  /// Lightest neutral tone (typically near pure white).
  final Color neutralLightest;

  /// Lighter neutral tone (subtle borders, dividers, subtle fills).
  final Color neutralLighter;

  /// Mid-tone neutral (borders, inactive icons, placeholder text).
  final Color neutralMid;

  /// Dark neutral tone (secondary text, subtle dark elements).
  final Color neutralDark;

  /// Darkest neutral tone (typically near pure black or dark navy).
  final Color neutralDarkest;

  const AppColors({
    required this.primary,
    required this.primaryContainer,
    required this.secondary,
    required this.secondaryContainer,
    required this.accent,
    required this.neutral,
    required this.neutralLightest,
    required this.neutralLighter,
    required this.neutralMid,
    required this.neutralDark,
    required this.neutralDarkest,
  });

  /// A neutral, brand-agnostic default palette suitable for initialization
  /// or fallback before an app provides its customized branding.
  const AppColors.fallback()
      : primary = const Color(0xFF1E3A8A),
        primaryContainer = const Color(0xFFDBEAFE),
        secondary = const Color(0xFF0D9488),
        secondaryContainer = const Color(0xFFCCFBF1),
        accent = const Color(0xFFF59E0B),
        neutral = const Color(0xFF6B7280),
        neutralLightest = const Color(0xFFFFFFFF),
        neutralLighter = const Color(0xFFF3F4F6),
        neutralMid = const Color(0xFF9CA3AF),
        neutralDark = const Color(0xFF374151),
        neutralDarkest = const Color(0xFF111827);

  /// Creates a copy of this [AppColors] with the given fields replaced.
  AppColors copyWith({
    Color? primary,
    Color? primaryContainer,
    Color? secondary,
    Color? secondaryContainer,
    Color? accent,
    Color? neutral,
    Color? neutralLightest,
    Color? neutralLighter,
    Color? neutralMid,
    Color? neutralDark,
    Color? neutralDarkest,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      primaryContainer: primaryContainer ?? this.primaryContainer,
      secondary: secondary ?? this.secondary,
      secondaryContainer: secondaryContainer ?? this.secondaryContainer,
      accent: accent ?? this.accent,
      neutral: neutral ?? this.neutral,
      neutralLightest: neutralLightest ?? this.neutralLightest,
      neutralLighter: neutralLighter ?? this.neutralLighter,
      neutralMid: neutralMid ?? this.neutralMid,
      neutralDark: neutralDark ?? this.neutralDark,
      neutralDarkest: neutralDarkest ?? this.neutralDarkest,
    );
  }

  /// Linearly interpolates between two [AppColors].
  static AppColors lerp(AppColors a, AppColors b, double t) {
    return AppColors(
      primary: Color.lerp(a.primary, b.primary, t)!,
      primaryContainer: Color.lerp(a.primaryContainer, b.primaryContainer, t)!,
      secondary: Color.lerp(a.secondary, b.secondary, t)!,
      secondaryContainer: Color.lerp(a.secondaryContainer, b.secondaryContainer, t)!,
      accent: Color.lerp(a.accent, b.accent, t)!,
      neutral: Color.lerp(a.neutral, b.neutral, t)!,
      neutralLightest: Color.lerp(a.neutralLightest, b.neutralLightest, t)!,
      neutralLighter: Color.lerp(a.neutralLighter, b.neutralLighter, t)!,
      neutralMid: Color.lerp(a.neutralMid, b.neutralMid, t)!,
      neutralDark: Color.lerp(a.neutralDark, b.neutralDark, t)!,
      neutralDarkest: Color.lerp(a.neutralDarkest, b.neutralDarkest, t)!,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppColors &&
          runtimeType == other.runtimeType &&
          primary == other.primary &&
          primaryContainer == other.primaryContainer &&
          secondary == other.secondary &&
          secondaryContainer == other.secondaryContainer &&
          accent == other.accent &&
          neutral == other.neutral &&
          neutralLightest == other.neutralLightest &&
          neutralLighter == other.neutralLighter &&
          neutralMid == other.neutralMid &&
          neutralDark == other.neutralDark &&
          neutralDarkest == other.neutralDarkest;

  @override
  int get hashCode => Object.hash(
        primary,
        primaryContainer,
        secondary,
        secondaryContainer,
        accent,
        neutral,
        neutralLightest,
        neutralLighter,
        neutralMid,
        neutralDark,
        neutralDarkest,
      );
}
