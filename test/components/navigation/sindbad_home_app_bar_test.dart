import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sindpad_design_system/sindpad_design_system.dart';

void main() {
  group('SindbadHomeAppBar', () {
    testWidgets('normal app bar renders drawer button, title, notification and NO search field', (tester) async {
      bool drawerTapped = false;
      const normalBar = SindbadHomeAppBar(
        title: 'متجر سندباد',
        notificationCount: 3,
        showBottomDivider: true,
      );

      expect(normalBar.preferredSize.height, 57.0);

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            appBar: SindbadHomeAppBar.normal(
              title: 'متجر سندباد',
              notificationCount: 3,
              showBottomDivider: true,
              onDrawerTap: () {
                drawerTapped = true;
              },
            ),
            body: const SizedBox.shrink(),
          ),
        ),
      );

      expect(find.byType(SindbadMenuIcon), findsOneWidget);
      expect(find.text('متجر سندباد'), findsOneWidget);
      expect(find.byType(Badge), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
      expect(find.byType(SindbadAnimatedSearchField), findsNothing);

      await tester.tap(find.byType(SindbadMenuIcon));
      expect(drawerTapped, isTrue);
    });

    testWidgets('notification icon displays badge count and fires onNotificationTap', (
      tester,
    ) async {
      bool notificationTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            appBar: SindbadHomeAppBar(
              title: 'الرئيسية',
              notificationCount: 5,
              onNotificationTap: () {
                notificationTapped = true;
              },
            ),
            body: const SizedBox.shrink(),
          ),
        ),
      );

      expect(find.byType(Badge), findsOneWidget);
      expect(find.text('5'), findsOneWidget);

      await tester.tap(find.byType(Badge));
      expect(notificationTapped, isTrue);
    });

    testWidgets('notification badge shows 9+ when count exceeds 9', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            appBar: SindbadHomeAppBar(
              title: 'الرئيسية',
              notificationCount: 14,
            ),
            body: SizedBox.shrink(),
          ),
        ),
      );

      expect(find.text('9+'), findsOneWidget);
    });

    testWidgets('search bar accepts typing and triggers callbacks', (tester) async {
      String? changedText;
      String? submittedText;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            appBar: SindbadHomeAppBar(
              showSearchBar: true,
              searchHint: 'ابحث عن منتج...',
              onSearchChanged: (val) {
                changedText = val;
              },
              onSearch: (val) {
                submittedText = val;
              },
            ),
            body: const SizedBox.shrink(),
          ),
        ),
      );

      expect(find.byType(SindbadAnimatedSearchField), findsOneWidget);

      // Enter text
      await tester.enterText(find.byType(TextField), 'عطر فاخر');
      await tester.pump();
      expect(changedText, 'عطر فاخر');

      // Submit text via keyboard search action
      await tester.showKeyboard(find.byType(TextField));
      await tester.testTextInput.receiveAction(TextInputAction.search);
      await tester.pump();
      expect(submittedText, 'عطر فاخر');

      // Clear text
      expect(find.byIcon(Icons.close_rounded), findsOneWidget);
      await tester.tap(find.byIcon(Icons.close_rounded));
      await tester.pump();

      expect(find.text('عطر فاخر'), findsNothing);
      expect(changedText, '');
    });

    testWidgets('dual-row layout calculates preferredSize and displays both rows', (
      tester,
    ) async {
      const dualRowBar = SindbadHomeAppBar.withSearch(
        title: 'الرئيسية',
        showBottomDivider: true,
      );

      // 56.0 (top) + 50.0 (bottom search) + 1.0 (divider) = 107.0
      expect(dualRowBar.preferredSize.height, 107.0);

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            appBar: dualRowBar,
            body: SizedBox.shrink(),
          ),
        ),
      );

      expect(find.text('الرئيسية'), findsOneWidget);
      expect(find.byType(SindbadAnimatedSearchField), findsOneWidget);
    });

    testWidgets('supports centerTitle in normal app bar', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            appBar: SindbadHomeAppBar(
              title: 'عنوان في المنتصف',
              centerTitle: true,
            ),
            body: SizedBox.shrink(),
          ),
        ),
      );

      expect(find.text('عنوان في المنتصف'), findsOneWidget);
    });

    testWidgets('adapts to dark mode seamlessly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: const Scaffold(
            appBar: SindbadHomeAppBar(
              title: 'الوضع الليلي',
              notificationCount: 2,
            ),
            body: SizedBox.shrink(),
          ),
        ),
      );

      expect(find.text('2'), findsOneWidget);
      expect(find.text('الوضع الليلي'), findsOneWidget);
    });
  });
}
