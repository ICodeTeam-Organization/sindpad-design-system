import 'package:flutter/material.dart';

import 'theme_config.dart';
import 'theme_extensions.dart';

/// Factory class for building Flutter [ThemeData] from [ThemeConfig].
///
/// Integrates the Sindpad Design System tokens seamlessly into Flutter's
/// standard [ColorScheme], [TextTheme], and [ThemeExtension] architecture.
class AppTheme {
  // Disallow instantiation
  const AppTheme._();

  /// Builds a light [ThemeData] using the provided [ThemeConfig].
  ///
  /// If [config] is omitted, standard brand-agnostic light defaults are applied.
  static ThemeData light([ThemeConfig? config]) {
    final effectiveConfig = config ?? ThemeConfig.lightDefault();
    return _buildTheme(effectiveConfig);
  }

  /// Builds a dark [ThemeData] using the provided [ThemeConfig].
  ///
  /// If [config] is omitted, standard brand-agnostic dark defaults are applied.
  static ThemeData dark([ThemeConfig? config]) {
    final effectiveConfig = config ?? ThemeConfig.darkDefault();
    return _buildTheme(effectiveConfig);
  }

  static ThemeData _buildTheme(ThemeConfig config) {
    final isDark = config.brightness == Brightness.dark;
    final semantic = config.semanticColors;
    final brand = config.colors;
    final textTheme = config.typography.toTextTheme(color: semantic.textPrimary);

    final colorScheme = ColorScheme(
      brightness: config.brightness,
      primary: brand.primary,
      onPrimary: semantic.textInverse,
      primaryContainer: brand.primaryContainer,
      onPrimaryContainer: semantic.textPrimary,
      secondary: brand.secondary,
      onSecondary: semantic.textInverse,
      secondaryContainer: brand.secondaryContainer,
      onSecondaryContainer: semantic.textPrimary,
      tertiary: brand.accent,
      onTertiary: semantic.textInverse,
      error: semantic.error,
      onError: semantic.textInverse,
      errorContainer: semantic.errorSurface,
      onErrorContainer: semantic.error,
      surface: semantic.surface,
      onSurface: semantic.textPrimary,
      onSurfaceVariant: semantic.textSecondary,
      outline: semantic.border,
      outlineVariant: semantic.borderSubtle,
      shadow: isDark ? const Color(0x73000000) : const Color(0x14000000),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: config.brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: semantic.background,
      canvasColor: semantic.surface,
      cardColor: semantic.surface,
      dividerColor: semantic.divider,
      textTheme: textTheme,
      extensions: [
        SindpadThemeExtension.fromConfig(config),
      ],
      appBarTheme: AppBarTheme(
        backgroundColor: semantic.surface,
        foregroundColor: semantic.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 1,
        centerTitle: false,
        titleTextStyle: config.typography.titleLarge.copyWith(
          color: semantic.textPrimary,
        ),
      ),
      cardTheme: CardThemeData(
        color: semantic.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: config.radius.mdBorderRadius,
          side: BorderSide(color: semantic.borderSubtle),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: semantic.divider,
        thickness: 1,
        space: 1,
      ),
    );
  }
}
