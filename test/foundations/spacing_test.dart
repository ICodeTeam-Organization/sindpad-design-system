import 'package:flutter_test/flutter_test.dart';
import 'package:sindpad_design_system/sindpad_design_system.dart';

void main() {
  group('AppSpacing', () {
    test('static constants follow expected scale', () {
      expect(AppSpacing.xxs, 2.0);
      expect(AppSpacing.xs, 4.0);
      expect(AppSpacing.sm, 8.0);
      expect(AppSpacing.md, 16.0);
      expect(AppSpacing.lg, 24.0);
      expect(AppSpacing.xl, 32.0);
      expect(AppSpacing.xxl, 48.0);
      expect(AppSpacing.xxxl, 64.0);
    });

    test('standard instance defaults match static values', () {
      const spacing = AppSpacing.standard();
      expect(spacing.sXxs, AppSpacing.xxs);
      expect(spacing.sXs, AppSpacing.xs);
      expect(spacing.sSm, AppSpacing.sm);
      expect(spacing.sMd, AppSpacing.md);
      expect(spacing.sLg, AppSpacing.lg);
      expect(spacing.sXl, AppSpacing.xl);
      expect(spacing.sXxl, AppSpacing.xxl);
      expect(spacing.sXxxl, AppSpacing.xxxl);
    });

    test('copyWith updates specified properties', () {
      const spacing = AppSpacing.standard();
      final updated = spacing.copyWith(sMd: 20.0, sLg: 30.0);

      expect(updated.sMd, 20.0);
      expect(updated.sLg, 30.0);
      expect(updated.sSm, AppSpacing.sm);
    });

    test('lerp correctly interpolates between two spacings', () {
      const a = AppSpacing(sMd: 10.0);
      const b = AppSpacing(sMd: 20.0);
      final lerped = AppSpacing.lerp(a, b, 0.5);

      expect(lerped.sMd, 15.0);
    });

    test('equality and hashCode are consistent', () {
      const a = AppSpacing.standard();
      const b = AppSpacing.standard();
      const c = AppSpacing(sMd: 99.0);

      expect(a, equals(b));
      expect(a.hashCode, equals(b.hashCode));
      expect(a, isNot(equals(c)));
    });
  });
}
