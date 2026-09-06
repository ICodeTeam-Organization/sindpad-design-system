# Sindpad Design System

Shared Flutter design system for Sindpad organization applications (`sindpad_design_system`).

This package provides a unified foundation and architectural contract shared by approximately 7 different Flutter applications across the Sindpad organization (including Tanazah, Miqwad, Sindbad, and others).

---

## Purpose

Sindpad operates multiple mobile applications that need to maintain engineering consistency, robust accessibility standards, and high visual polish without forcing every product into a rigid, identical look and feel.

This design system establishes:
* Shared design token architecture
* Centralized theme configuration contracts
* Unified accessibility standards (such as minimum touch targets)
* Consistent motion, spacing, and elevation primitives
* Future shared UI component libraries

---

## Architecture

The system follows a tiered layered architecture:

```text
Foundations (Colors, Typography, Spacing, Radius, Shadows, Dimensions, Motion)
    ↓
Theme (ThemeConfig, SemanticColors, AppTheme, ThemeExtension)
    ↓
Components (Buttons, Inputs, Cards, Navigation, Dialogs, Feedback, Layouts)
    ↓
Sindpad Applications (Tanazah, Miqwad, Sindbad, App4, App5, App6, App7)
```

1. **Foundations**: Design tokens and primitives (brand-agnostic).
2. **Theme**: Composes foundations via `ThemeConfig`, maps to Flutter `ThemeData` via `AppTheme`, and exposes tokens via `SindpadThemeExtension`.
3. **Components**: Reusable, accessible UI widgets that consume tokens (scheduled for subsequent phases).
4. **Applications**: Products configure their visual identity by supplying application-specific `ThemeConfig` instances.

---

## Design Principle

The design system shares:
* Architecture
* Tokens
* Foundations
* Accessibility principles
* Reusable components

while allowing each application to maintain its own:
* Brand colors
* Typography (font families and scale)
* Corner radii (e.g. sharp vs. pill curves)
* Visual identity
* Application-specific UI

> **Core Rule**: The design system owns the **architecture and APIs**. Each application owns its **brand configuration**.

---

## Current Status

* **Status**: `Foundation scaffolding`
* **Components**: `Components are not implemented yet.`

Directory placeholders for future components (`buttons`, `inputs`, `cards`, `navigation`, `dialogs`, `feedback`, `layouts`), `icons`, and `assets` are established and preserved.

---

## Target Directory Structure

```text
sindpad_design_system/
│
├── lib/
│   │
│   ├── foundations/
│   │   ├── colors/
│   │   │   ├── app_colors.dart
│   │   │   └── semantic_colors.dart
│   │   ├── typography/
│   │   │   └── app_typography.dart
│   │   ├── spacing/
│   │   │   └── app_spacing.dart
│   │   ├── radius/
│   │   │   └── app_radius.dart
│   │   ├── shadows/
│   │   │   └── app_shadows.dart
│   │   ├── dimensions/
│   │   │   └── app_dimensions.dart
│   │   └── motion/
│   │       └── app_motion.dart
│   │
│   ├── theme/
│   │   ├── theme_config.dart
│   │   ├── app_theme.dart
│   │   └── theme_extensions.dart
│   │
│   ├── components/
│   │   ├── buttons/
│   │   ├── inputs/
│   │   ├── cards/
│   │   ├── navigation/
│   │   ├── dialogs/
│   │   ├── feedback/
│   │   └── layouts/
│   │
│   ├── icons/
│   ├── assets/
│   └── sindpad_design_system.dart
│
├── test/
│   ├── foundations/
│   └── theme/
│
├── example/
│
├── README.md
├── CHANGELOG.md
├── LICENSE
├── analysis_options.yaml
└── pubspec.yaml
```

---

## Preliminary Usage

### 1. Import the package

```dart
import 'package:flutter/material.dart';
import 'package:sindpad_design_system/sindpad_design_system.dart';
```

### 2. Configure application themes

Each Sindpad application creates its brand `ThemeConfig`:

```dart
// Example: Customizing brand colors and radius for an app
final customAppConfig = ThemeConfig.lightDefault(
  colors: const AppColors.fallback().copyWith(
    primary: const Color(0xFF0066CC),
    secondary: const Color(0xFFFF9900),
  ),
  radius: const AppRadius.rounded(),
  typography: AppTypography.regular(fontFamily: 'AppBrandFont'),
);

void main() {
  runApp(
    MaterialApp(
      theme: AppTheme.light(customAppConfig),
      darkTheme: AppTheme.dark(customAppConfig.copyWith(brightness: Brightness.dark)),
      home: const HomeScreen(),
    ),
  );
}
```

### 3. Access tokens in widgets

Tokens can be accessed statically or reactively via `BuildContext` extensions:

```dart
Widget build(BuildContext context) {
  // Direct static spacing
  const padding = EdgeInsets.all(AppSpacing.md);

  // Context-aware semantic tokens
  final colors = context.sindpadColors;
  final typography = context.sindpadTypography;
  final radius = context.sindpadRadius;
  final shadows = context.sindpadShadows;

  return Container(
    padding: padding,
    decoration: BoxDecoration(
      color: colors.surface,
      borderRadius: radius.asBorderRadius(radius.rMd),
      boxShadow: shadows.sm,
      border: Border.all(color: colors.borderSubtle),
    ),
    child: Text(
      'Sindpad Design System',
      style: typography.titleMedium.copyWith(color: colors.textPrimary),
    ),
  );
}
```

---

## Running the Example Playground

```bash
cd example
flutter pub get
flutter run
```

The example application demonstrates all foundational tokens (colors, typography, spacing, radius, shadows, dimensions, motion) in both light and dark modes.

---

## Running Tests & Analysis

```bash
# Analyze package
flutter analyze

# Run unit tests
flutter test

# Analyze example app
cd example
flutter analyze
```
