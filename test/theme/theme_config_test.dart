import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sindpad_design_system/sindpad_design_system.dart';

void main() {
  group('ThemeConfig', () {
    test('lightDefault sets light brightness and light semantic defaults', () {
      final config = ThemeConfig.lightDefault();

      expect(config.brightness, Brightness.light);
      expect(config.semanticColors.background, const SemanticColors.lightDefault().background);
      expect(config.spacing.sMd, AppSpacing.md);
      expect(config.radius.rMd, AppRadius.md);
    });

    test('darkDefault sets dark brightness and dark semantic defaults', () {
      final config = ThemeConfig.darkDefault();

      expect(config.brightness, Brightness.dark);
      expect(config.semanticColors.background, const SemanticColors.darkDefault().background);
    });

    test('copyWith allows overriding sub-tokens', () {
      final config = ThemeConfig.lightDefault();
      final updated = config.copyWith(
        radius: const AppRadius.sharp(),
      );

      expect(updated.radius.rMd, 4.0);
      expect(updated.spacing.sMd, AppSpacing.md);
    });
  });
}
