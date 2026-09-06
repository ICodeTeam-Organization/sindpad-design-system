import 'package:flutter/material.dart';

import '../foundations/colors/app_colors.dart';
import '../foundations/colors/semantic_colors.dart';
import '../foundations/dimensions/app_dimensions.dart';
import '../foundations/motion/app_motion.dart';
import '../foundations/radius/app_radius.dart';
import '../foundations/shadows/app_shadows.dart';
import '../foundations/spacing/app_spacing.dart';
import '../foundations/typography/app_typography.dart';
import 'theme_config.dart';

/// Flutter [ThemeExtension] exposing Sindpad Design System tokens to the widget tree.
///
/// Attaches custom tokens (semantic colors, spacing, radius, shadows, dimensions,
/// motion) to standard [ThemeData], enabling reactive access and animated transitions
/// during theme switching.
@immutable
class SindpadThemeExtension extends ThemeExtension<SindpadThemeExtension> {
  final AppColors colors;
  final SemanticColors semanticColors;
  final AppTypography typography;
  final AppSpacing spacing;
  final AppRadius radius;
  final AppShadows shadows;
  final AppDimensions dimensions;
  final AppMotion motion;

  const SindpadThemeExtension({
    required this.colors,
    required this.semanticColors,
    required this.typography,
    required this.spacing,
    required this.radius,
    required this.shadows,
    required this.dimensions,
    required this.motion,
  });

  /// Creates a [SindpadThemeExtension] directly from a [ThemeConfig].
  factory SindpadThemeExtension.fromConfig(ThemeConfig config) {
    return SindpadThemeExtension(
      colors: config.colors,
      semanticColors: config.semanticColors,
      typography: config.typography,
      spacing: config.spacing,
      radius: config.radius,
      shadows: config.shadows,
      dimensions: config.dimensions,
      motion: config.motion,
    );
  }

  @override
  SindpadThemeExtension copyWith({
    AppColors? colors,
    SemanticColors? semanticColors,
    AppTypography? typography,
    AppSpacing? spacing,
    AppRadius? radius,
    AppShadows? shadows,
    AppDimensions? dimensions,
    AppMotion? motion,
  }) {
    return SindpadThemeExtension(
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
  SindpadThemeExtension lerp(
    ThemeExtension<SindpadThemeExtension>? other,
    double t,
  ) {
    if (other is! SindpadThemeExtension) {
      return this;
    }

    return SindpadThemeExtension(
      colors: AppColors.lerp(colors, other.colors, t),
      semanticColors: SemanticColors.lerp(semanticColors, other.semanticColors, t),
      typography: AppTypography.lerp(typography, other.typography, t),
      spacing: AppSpacing.lerp(spacing, other.spacing, t),
      radius: AppRadius.lerp(radius, other.radius, t),
      shadows: AppShadows.lerp(shadows, other.shadows, t),
      dimensions: AppDimensions.lerp(dimensions, other.dimensions, t),
      motion: AppMotion.lerp(motion, other.motion, t),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SindpadThemeExtension &&
          runtimeType == other.runtimeType &&
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

/// Convenience extensions on [BuildContext] for ergonomic token access.
extension SindpadThemeContextExtensions on BuildContext {
  /// The [SindpadThemeExtension] registered in the current [ThemeData].
  SindpadThemeExtension get sindpadTheme {
    final extension = Theme.of(this).extension<SindpadThemeExtension>();
    assert(
      extension != null,
      'SindpadThemeExtension not found in current ThemeData. '
      'Ensure the MaterialApp theme was created via AppTheme.light() or AppTheme.dark().',
    );
    return extension!;
  }

  /// Direct access to [SemanticColors].
  SemanticColors get sindpadColors => sindpadTheme.semanticColors;

  /// Direct access to raw [AppColors].
  AppColors get sindpadRawColors => sindpadTheme.colors;

  /// Direct access to [AppTypography].
  AppTypography get sindpadTypography => sindpadTheme.typography;

  /// Direct access to [AppSpacing].
  AppSpacing get sindpadSpacing => sindpadTheme.spacing;

  /// Direct access to [AppRadius].
  AppRadius get sindpadRadius => sindpadTheme.radius;

  /// Direct access to [AppShadows].
  AppShadows get sindpadShadows => sindpadTheme.shadows;

  /// Direct access to [AppDimensions].
  AppDimensions get sindpadDimensions => sindpadTheme.dimensions;

  /// Direct access to [AppMotion].
  AppMotion get sindpadMotion => sindpadTheme.motion;
}
