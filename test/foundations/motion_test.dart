import 'package:flutter/animation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sindpad_design_system/sindpad_design_system.dart';

void main() {
  group('AppMotion', () {
    test('duration constants follow ascending scale', () {
      expect(AppMotion.instant, Duration.zero);
      expect(AppMotion.fast, const Duration(milliseconds: 150));
      expect(AppMotion.normal, const Duration(milliseconds: 300));
      expect(AppMotion.slow, const Duration(milliseconds: 500));
    });

    test('curves follow standard Flutter animation curves', () {
      expect(AppMotion.curveStandard, Curves.easeInOut);
      expect(AppMotion.curveAccelerate, Curves.easeIn);
      expect(AppMotion.curveDecelerate, Curves.easeOut);
      expect(AppMotion.curveEmphasized, Curves.easeInOutCubicEmphasized);
    });
  });
}
