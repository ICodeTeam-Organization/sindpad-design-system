import 'package:flutter_test/flutter_test.dart';
import 'package:sindpad_design_system/sindpad_design_system.dart';

void main() {
  group('AppDimensions', () {
    test('minimum touch target meets accessibility threshold', () {
      expect(AppDimensions.minTouchTarget, 48.0);
    });

    test('icon sizes follow hierarchical scale', () {
      expect(AppDimensions.iconXs, 12.0);
      expect(AppDimensions.iconSm, 16.0);
      expect(AppDimensions.iconMd, 24.0);
      expect(AppDimensions.iconLg, 32.0);
      expect(AppDimensions.iconXl, 48.0);
    });

    test('control heights follow standard scale', () {
      expect(AppDimensions.controlSm, 32.0);
      expect(AppDimensions.controlMd, 40.0);
      expect(AppDimensions.controlLg, 48.0);
    });

    test('structural component heights are standard', () {
      expect(AppDimensions.appBarHeight, 56.0);
      expect(AppDimensions.bottomNavBarHeight, 64.0);
    });
  });
}
