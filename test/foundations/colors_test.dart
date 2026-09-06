import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sindpad_design_system/sindpad_design_system.dart';

void main() {
  group('AppColors', () {
    test('fallback palette has expected default colors', () {
      const colors = AppColors.fallback();

      expect(colors.primary, const Color(0xFFFF8527));
      expect(colors.secondary, const Color(0xFF093456));
      expect(colors.accent, const Color(0xFFF59E0B));
      expect(colors.neutralLightest, const Color(0xFFFFFFFF));
    });

    test('copyWith updates specified color', () {
      const colors = AppColors.fallback();
      final updated = colors.copyWith(primary: const Color(0xFFFF0000));

      expect(updated.primary, const Color(0xFFFF0000));
      expect(updated.secondary, colors.secondary);
    });

    test('lerp correctly blends colors', () {
      const a = AppColors.fallback();
      final b = a.copyWith(primary: const Color(0xFFFFFFFF));
      final lerped = AppColors.lerp(a, b, 1.0);

      expect(lerped.primary, const Color(0xFFFFFFFF));
    });
  });

  group('SemanticColors', () {
    test('lightDefault and darkDefault have distinct background and surface', () {
      const light = SemanticColors.lightDefault();
      const dark = SemanticColors.darkDefault();

      expect(light.background, isNot(equals(dark.background)));
      expect(light.surface, isNot(equals(dark.surface)));
      expect(light.textPrimary, isNot(equals(dark.textPrimary)));
    });

    test('copyWith updates individual semantic tokens', () {
      const light = SemanticColors.lightDefault();
      final updated = light.copyWith(error: const Color(0xFF990000));

      expect(updated.error, const Color(0xFF990000));
      expect(updated.background, light.background);
    });

    test('lerp transitions between semantic palettes', () {
      const light = SemanticColors.lightDefault();
      const dark = SemanticColors.darkDefault();
      final mid = SemanticColors.lerp(light, dark, 0.5);

      expect(mid.background, isNotNull);
      expect(mid.textPrimary, isNotNull);
    });
  });
}
