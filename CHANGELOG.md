# Changelog

## 2.1.0

* Added reusable, production-ready `AppLoginForm` component:
  * Responsive layout with `LayoutBuilder` and `ConstrainedBox` support across phones, tablets, and desktop.
  * Full Arabic (RTL) and English (LTR) localization support.
  * Inputs for Email, Phone, and combined Phone/Email credentials.
  * Obscure/visible password toggle with accessibility semantics.
  * In-form error banner presentation without intrusive SnackBars.
  * Primary action button with disabled state and loading indicator.
  * Forgot password and registration links with customizable visibility and callbacks.
  * Social authentication buttons for Google and Facebook with `font_awesome_flutter`.
  * `GoogleMultiColorIcon` with authentic 4-quadrant brand colors via `ShaderMask` and `SweepGradient`.
* Added configuration and value models:
  * `AppLoginConfig` with `.arabic()` and `.english()` factory presets.
  * `LoginCredentials` immutable model and `LoginCredentialType` enum.
* Aligned design tokens with the official Sindbad Store Design System:
  * Primary (`#FF8527`), Secondary (`#093456`), Accent (`#F59E0B`).
  * Surface and semantic palette (`#F8FAFC`, `#FFFFFF`, `#E2E8F0`, `#F1F5F9`).
  * Component radii: Button (`12dp`), Input (`12dp`), Card/Badge (`16dp`).
  * Stored `sindbad_design_system.json` specification in repository.
* Added interactive Login Form preview in `example/lib/main.dart`.
* Added comprehensive widget test suite with 51 passing tests.

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
