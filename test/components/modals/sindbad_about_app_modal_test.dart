import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sindpad_design_system/sindpad_design_system.dart';

void main() {
  group('SindbadAboutAppModal', () {
    testWidgets('renders all metadata fields, custom labels, and handles close', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    SindbadAboutAppModal.show(
                      context: context,
                      appName: 'سندباد للمندوبين',
                      appSubtitle: 'بوابة الخدمات اللوجستية',
                      version: '3.5.1 (build 42)',
                      systemInfo: 'Android 14 (API 34)',
                      companyName: 'مجموعة سندباد التقنية',
                      copyright: '© 2026 جميع الحقوق محفوظة',
                      closeButtonText: 'إغلاق النافذة',
                      labelVersion: 'إصدار التطبيق',
                      labelSystem: 'النظام',
                      labelCompany: 'المطور',
                    );
                  },
                  child: const Text('Open Modal'),
                );
              },
            ),
          ),
        ),
      );

      // Tap button to open modal
      await tester.tap(find.text('Open Modal'));
      await tester.pumpAndSettle();

      // Verify content
      expect(find.text('سندباد للمندوبين'), findsOneWidget);
      expect(find.text('بوابة الخدمات اللوجستية'), findsOneWidget);
      expect(find.text('إصدار التطبيق'), findsOneWidget);
      expect(find.text('3.5.1 (build 42)'), findsOneWidget);
      expect(find.text('النظام'), findsOneWidget);
      expect(find.text('Android 14 (API 34)'), findsOneWidget);
      expect(find.text('المطور'), findsOneWidget);
      expect(find.text('مجموعة سندباد التقنية'), findsOneWidget);
      expect(find.text('© 2026 جميع الحقوق محفوظة'), findsOneWidget);

      // Verify close button dismisses modal
      final closeButtonFinder = find.text('إغلاق النافذة');
      expect(closeButtonFinder, findsOneWidget);
      await tester.tap(closeButtonFinder);
      await tester.pumpAndSettle();

      expect(find.text('سندباد للمندوبين'), findsNothing);
    });

    testWidgets('renders modal directly as a widget', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SindbadAboutAppModal(
              appName: 'Sindbad Store',
              version: '1.0.0',
            ),
          ),
        ),
      );

      expect(find.text('Sindbad Store'), findsOneWidget);
      expect(find.text('1.0.0'), findsOneWidget);
      expect(find.text('إغلاق'), findsOneWidget);
    });
  });
}
