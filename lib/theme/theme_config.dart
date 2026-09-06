import 'package:flutter/material.dart';

import '../foundations/colors/app_colors.dart';
import '../foundations/colors/semantic_colors.dart';
import '../foundations/dimensions/app_dimensions.dart';
import '../foundations/motion/app_motion.dart';
import '../foundations/radius/app_radius.dart';
import '../foundations/shadows/app_shadows.dart';
import '../foundations/spacing/app_spacing.dart';
import '../foundations/typography/app_typography.dart';

/// Central configuration object composing all Sindpad Design System foundations.
///
/// Each consuming Sindpad application (e.g. Tanazah, Miqwad, Sindbad) can
/// instantiate its own [ThemeConfig] by customizing brand colors, typography,
/// radius curvature, and semantic colors while reusing the design system's
/// architecture and components.
@immutable
class ThemeConfig {
  /// Target brightness (light or dark mode).
  final Brightness brightness;

  /// Raw brand color palette.
  final AppColors colors;

  /// Contextual and intent-based semantic colors.
  final SemanticColors semanticColors;

  /// Typographic scale definitions.
  final AppTypography typography;

  /// Spacing scale tokens.
  final AppSpacing spacing;

  /// Corner radius tokens.
  final AppRadius radius;

  /// Elevation and shadow definitions.
  final AppShadows shadows;

  /// Component and layout dimensions.
  final AppDimensions dimensions;

  /// Motion, durations, and animation curves.
  final AppMotion motion;

  const ThemeConfig({
    required this.brightness,
    required this.colors,
    required this.semanticColors,
    required this.typography,
    required this.spacing,
    required this.radius,
    required this.shadows,
    required this.dimensions,
    required this.motion,
  });

  /// Creates a default light-theme configuration.
  ///
  /// Any parameter not provided will use standard brand-agnostic design system defaults.
  factory ThemeConfig.lightDefault({
    AppColors? colors,
    SemanticColors? semanticColors,
    AppTypography? typography,
    AppSpacing? spacing,
    AppRadius? radius,
    AppShadows? shadows,
    AppDimensions? dimensions,
    AppMotion? motion,
  }) {
    final effectiveColors = colors ?? const AppColors.fallback();
    return ThemeConfig(
      brightness: Brightness.light,
      colors: effectiveColors,
      semanticColors: semanticColors ?? const SemanticColors.lightDefault(),
      typography: typography ?? AppTypography.regular(),
      spacing: spacing ?? const AppSpacing.standard(),
      radius: radius ?? const AppRadius.standard(),
      shadows: shadows ?? AppShadows.light,
      dimensions: dimensions ?? const AppDimensions.standard(),
      motion: motion ?? const AppMotion.standard(),
    );
  }

  /// Creates a default dark-theme configuration.
  ///
  /// Any parameter not provided will use standard brand-agnostic design system defaults.
  factory ThemeConfig.darkDefault({
    AppColors? colors,
    SemanticColors? semanticColors,
    AppTypography? typography,
    AppSpacing? spacing,
    AppRadius? radius,
    AppShadows? shadows,
    AppDimensions? dimensions,
    AppMotion? motion,
  }) {
    final effectiveColors = colors ?? const AppColors.fallback();
    return ThemeConfig(
      brightness: Brightness.dark,
      colors: effectiveColors,
      semanticColors: semanticColors ?? const SemanticColors.darkDefault(),
      typography: typography ?? AppTypography.regular(),
      spacing: spacing ?? const AppSpacing.standard(),
      radius: radius ?? const AppRadius.standard(),
      shadows: shadows ?? AppShadows.dark,
      dimensions: dimensions ?? const AppDimensions.standard(),
      motion: motion ?? const AppMotion.standard(),
    );
  }

  /// Creates a copy of this [ThemeConfig] with specified fields replaced.
  ThemeConfig copyWith({
    Brightness? brightness,
    AppColors? colors,
    SemanticColors? semanticColors,
    AppTypography? typography,
    AppSpacing? spacing,
    AppRadius? radius,
    AppShadows? shadows,
    AppDimensions? dimensions,
    AppMotion? motion,
  }) {
    return ThemeConfig(
      brightness: brightness ?? this.brightness,
      colors: colors ?? this.colors,
      semanticColors: semanticColors ?? this.semanticColors,
      typography: typography ?? this.typography,
      spacing: spacing ?? this.spacing,
      radius: radius ?? this.radius,
      shadows: shadows ?? this.shadows,
      dimensions: dimensions ?? this.dimensions,
      motion: motion ?? this.motion,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemeConfig &&
          runtimeType == other.runtimeType &&
          brightness == other.brightness &&
          colors == other.colors &&
          semanticColors == other.semanticColors &&
          typography == other.typography &&
          spacing == other.spacing &&
          radius == other.radius &&
          shadows == other.shadows &&
          dimensions == other.dimensions &&
          motion == other.motion;

  @override
  int get hashCode => Object.hash(
        brightness,
        colors,
        semanticColors,
        typography,
        spacing,
        radius,
        shadows,
        dimensions,
        motion,
      );
}
