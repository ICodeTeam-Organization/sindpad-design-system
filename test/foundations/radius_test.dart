import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sindpad_design_system/sindpad_design_system.dart';

void main() {
  group('AppRadius', () {
    test('static constants follow expected scale', () {
      expect(AppRadius.none, 0.0);
      expect(AppRadius.xs, 2.0);
      expect(AppRadius.sm, 4.0);
      expect(AppRadius.md, 8.0);
      expect(AppRadius.lg, 12.0);
      expect(AppRadius.xl, 16.0);
      expect(AppRadius.xxl, 24.0);
      expect(AppRadius.full, 9999.0);
    });

    test('border radius helpers produce correct BorderRadius instances', () {
      const radius = AppRadius.standard();

      expect(radius.asBorderRadius(8.0), BorderRadius.circular(8.0));
      expect(radius.noneBorderRadius, BorderRadius.circular(0.0));
      expect(radius.smBorderRadius, BorderRadius.circular(4.0));
      expect(radius.mdBorderRadius, BorderRadius.circular(8.0));
      expect(radius.lgBorderRadius, BorderRadius.circular(12.0));
      expect(radius.fullBorderRadius, BorderRadius.circular(9999.0));
    });

    test('sharp and rounded presets configure radii appropriately', () {
      const sharp = AppRadius.sharp();
      expect(sharp.rMd, 4.0);

      const rounded = AppRadius.rounded();
      expect(rounded.rMd, 16.0);
    });

    test('lerp correctly interpolates between two radii', () {
      const a = AppRadius(rMd: 10.0);
      const b = AppRadius(rMd: 20.0);
      final lerped = AppRadius.lerp(a, b, 0.5);

      expect(lerped.rMd, 15.0);
    });

    test('equality and hashCode are consistent', () {
      const a = AppRadius.standard();
      const b = AppRadius.standard();
      const c = AppRadius.sharp();

      expect(a, equals(b));
      expect(a.hashCode, equals(b.hashCode));
      expect(a, isNot(equals(c)));
    });
  });
}
