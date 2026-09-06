import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sindpad_design_system/sindpad_design_system.dart';

void main() {
  group('AppTypography', () {
    test('regular constructor sets up all scale levels', () {
      final typography = AppTypography.regular();

      expect(typography.displayLarge.fontSize, 57);
      expect(typography.headlineLarge.fontSize, 32);
      expect(typography.titleLarge.fontSize, 22);
      expect(typography.bodyLarge.fontSize, 16);
      expect(typography.labelLarge.fontSize, 14);
      expect(typography.caption.fontSize, 12);
    });

    test('accepts custom fontFamily', () {
      final typography = AppTypography.regular(fontFamily: 'CustomFont');

      expect(typography.fontFamily, 'CustomFont');
      expect(typography.displayLarge.fontFamily, 'CustomFont');
      expect(typography.bodyMedium.fontFamily, 'CustomFont');
    });

    test('toTextTheme correctly generates Flutter TextTheme', () {
      final typography = AppTypography.regular();
      final textTheme = typography.toTextTheme(color: const Color(0xFF123456));

      expect(textTheme.displayLarge?.fontSize, 57);
      expect(textTheme.displayLarge?.color, const Color(0xFF123456));
      expect(textTheme.bodyMedium?.fontSize, 14);
      expect(textTheme.bodyMedium?.color, const Color(0xFF123456));
    });

    test('copyWith updates individual text style', () {
      final typography = AppTypography.regular();
      final updated = typography.copyWith(
        bodyMedium: typography.bodyMedium.copyWith(fontSize: 18),
      );

      expect(updated.bodyMedium.fontSize, 18);
      expect(updated.bodyLarge.fontSize, 16);
    });
  });
}
