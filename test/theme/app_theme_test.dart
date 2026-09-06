import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sindpad_design_system/sindpad_design_system.dart';

void main() {
  group('AppTheme', () {
    test('AppTheme.light creates valid ThemeData with SindpadThemeExtension', () {
      final theme = AppTheme.light();

      expect(theme.brightness, Brightness.light);
      expect(theme.useMaterial3, isTrue);

      final ext = theme.extension<SindpadThemeExtension>();
      expect(ext, isNotNull);
      expect(ext!.spacing.sMd, AppSpacing.md);
      expect(ext.radius.rMd, AppRadius.md);
      expect(ext.semanticColors.surface, const Color(0xFFFFFFFF));
    });

    test('AppTheme.dark creates valid ThemeData with dark semantic colors', () {
      final theme = AppTheme.dark();

      expect(theme.brightness, Brightness.dark);
      expect(theme.useMaterial3, isTrue);

      final ext = theme.extension<SindpadThemeExtension>();
      expect(ext, isNotNull);
      expect(ext!.semanticColors.background, const Color(0xFF111827));
    });

    testWidgets('context extensions retrieve tokens properly', (tester) async {
      late BuildContext capturedContext;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Builder(
            builder: (context) {
              capturedContext = context;
              return const SizedBox();
            },
          ),
        ),
      );

      expect(capturedContext.sindpadSpacing.sMd, AppSpacing.md);
      expect(capturedContext.sindpadRadius.rMd, AppRadius.md);
      expect(capturedContext.sindpadColors.surface, const Color(0xFFFFFFFF));
      expect(capturedContext.sindpadDimensions.touchTargetMin, 48.0);
      expect(capturedContext.sindpadMotion.normalDuration, const Duration(milliseconds: 300));
    });
  });
}
