import 'package:flutter_test/flutter_test.dart';
import 'package:sindpad_design_system/sindpad_design_system.dart';

void main() {
  group('AppShadows', () {
    test('light presets define elevation tiers', () {
      const shadows = AppShadows.light;

      expect(shadows.none, isEmpty);
      expect(shadows.sm, isNotEmpty);
      expect(shadows.md, isNotEmpty);
      expect(shadows.lg, isNotEmpty);
      expect(shadows.lg.first.blurRadius, greaterThan(shadows.sm.first.blurRadius));
    });

    test('dark presets define elevation tiers', () {
      const shadows = AppShadows.dark;

      expect(shadows.none, isEmpty);
      expect(shadows.sm, isNotEmpty);
      expect(shadows.md, isNotEmpty);
      expect(shadows.lg, isNotEmpty);
    });

    test('equality and lerp work as expected', () {
      const a = AppShadows.light;
      const b = AppShadows.dark;
      final lerped = AppShadows.lerp(a, b, 0.5);

      expect(lerped.sm, isNotEmpty);
      expect(a, isNot(equals(b)));
    });
  });
}
