# Changelog

## 0.0.1

* Initial foundation scaffolding for the Sindpad Design System.
* Established design tokens:
  * `AppColors` (raw/brand color palette)
  * `SemanticColors` (contextual intent-based color system with light and dark presets)
  * `AppTypography` (configurable typographic scales and `TextTheme` integration)
  * `AppSpacing` (immutable scale from `xxs` to `xxxl`)
  * `AppRadius` (semantic curvature presets and `BorderRadius` helpers)
  * `AppShadows` (box shadow elevation tiers from `none` to `lg`)
  * `AppDimensions` (standardized icon sizes, control heights, and touch target minimum)
  * `AppMotion` (standard durations and animation curves)
* Created theme architecture:
  * `ThemeConfig` composing all foundations
  * `SindpadThemeExtension` implementing Flutter's `ThemeExtension` with `copyWith` and `lerp`
  * `AppTheme` converting `ThemeConfig` to Flutter's native `ThemeData`
* Added component, icon, and asset directory placeholders.
* Added playground example application in `example/`.
* Added comprehensive unit test coverage.
