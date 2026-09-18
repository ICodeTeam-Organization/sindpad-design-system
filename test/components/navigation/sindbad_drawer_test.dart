import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sindpad_design_system/sindpad_design_system.dart';

void main() {
  group('SindbadDrawer', () {
    testWidgets('renders default user header, account info, and actions', (
      tester,
    ) async {
      bool actionTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            drawer: SindbadDrawer(
              userName: 'أحمد علي',
              subtitle: 'مدير النظام',
              info: const [
                SindbadDrawerInfo(
                  label: 'رقم الهاتف',
                  value: '+966500000000',
                  icon: Icons.phone,
                ),
                SindbadDrawerInfo(
                  label: 'المتجر',
                  value: 'فرع الرياض',
                  icon: Icons.store,
                ),
              ],
              actions: [
                SindbadDrawerAction(
                  title: 'إدارة المنتجات',
                  icon: Icons.inventory_2,
                  onTap: () {
                    actionTapped = true;
                  },
                ),
              ],
              version: '1.2.0',
              versionFooterText: 'سندباد',
            ),
            body: const Placeholder(),
          ),
        ),
      );

      // Open drawer
      final scaffoldState = tester.state<ScaffoldState>(find.byType(Scaffold));
      scaffoldState.openDrawer();
      await tester.pumpAndSettle();

      // Check header
      expect(find.text('أحمد علي'), findsOneWidget);
      expect(find.text('مدير النظام'), findsOneWidget);
      expect(find.text('أ'), findsOneWidget); // Avatar letter

      // Check account info
      expect(find.text('رقم الهاتف'), findsOneWidget);
      expect(find.text('+966500000000'), findsOneWidget);
      expect(find.text('المتجر'), findsOneWidget);
      expect(find.text('فرع الرياض'), findsOneWidget);

      // Check quick action and tap
      expect(find.text('إدارة المنتجات'), findsOneWidget);
      await tester.tap(find.text('إدارة المنتجات'));
      expect(actionTapped, isTrue);

      // Check version footer
      expect(find.text('v1.2.0 • سندباد'), findsOneWidget);
    });

    testWidgets('triggers theme and language callbacks in settings section', (
      tester,
    ) async {
      bool? toggledTheme;
      String? changedLanguage;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            drawer: SindbadDrawer(
              userName: 'مستخدم تجريبي',
              isDarkMode: false,
              onThemeChanged: (val) {
                toggledTheme = val;
              },
              currentLanguageCode: 'ar',
              onLanguageChanged: (lang) {
                changedLanguage = lang;
              },
            ),
            body: const Placeholder(),
          ),
        ),
      );

      final scaffoldState = tester.state<ScaffoldState>(find.byType(Scaffold));
      scaffoldState.openDrawer();
      await tester.pumpAndSettle();

      // Test theme switch
      final switchFinder = find.byType(Switch);
      expect(switchFinder, findsOneWidget);
      await tester.tap(switchFinder);
      await tester.pumpAndSettle();
      expect(toggledTheme, isTrue);

      // Test language change tap (English pill)
      final englishFinder = find.text('English');
      expect(englishFinder, findsOneWidget);
      await tester.tap(englishFinder);
      await tester.pumpAndSettle();
      expect(changedLanguage, 'en');
    });

    testWidgets('triggers onVersionTap callback', (tester) async {
      bool versionTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            drawer: SindbadDrawer(
              version: '2.0.0',
              onVersionTap: () {
                versionTapped = true;
              },
            ),
            body: const Placeholder(),
          ),
        ),
      );

      final scaffoldState = tester.state<ScaffoldState>(find.byType(Scaffold));
      scaffoldState.openDrawer();
      await tester.pumpAndSettle();

      final versionFinder = find.text('v2.0.0');
      expect(versionFinder, findsOneWidget);
      await tester.tap(versionFinder);
      expect(versionTapped, isTrue);
    });

    testWidgets('supports custom header and settingsSection', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            drawer: SindbadDrawer(
              header: Text('Custom Header View'),
              settingsSection: Text('Custom Settings View'),
            ),
            body: Placeholder(),
          ),
        ),
      );

      final scaffoldState = tester.state<ScaffoldState>(find.byType(Scaffold));
      scaffoldState.openDrawer();
      await tester.pumpAndSettle();

      expect(find.text('Custom Header View'), findsOneWidget);
      expect(find.text('Custom Settings View'), findsOneWidget);
    });
  });
}
