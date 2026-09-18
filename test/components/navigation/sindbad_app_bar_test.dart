import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sindpad_design_system/sindpad_design_system.dart';

void main() {
  group('SindbadAppBar', () {
    testWidgets('renders single title', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            appBar: SindbadAppBar(
              title: 'الرئيسية',
            ),
            body: SizedBox.shrink(),
          ),
        ),
      );

      expect(find.text('الرئيسية'), findsOneWidget);
    });

    testWidgets('renders title and subtitle dual hierarchy', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            appBar: SindbadAppBar(
              title: 'إدارة الطلبات',
              subtitle: 'فرع الرياض - النرجس',
            ),
            body: SizedBox.shrink(),
          ),
        ),
      );

      expect(find.text('إدارة الطلبات'), findsOneWidget);
      expect(find.text('فرع الرياض - النرجس'), findsOneWidget);
    });

    testWidgets('custom titleWidget takes precedence over text title', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const Scaffold(
            appBar: SindbadAppBar(
              title: 'Ignored Title',
              titleWidget: Text('Custom Title Widget'),
            ),
            body: SizedBox.shrink(),
          ),
        ),
      );

      expect(find.text('Custom Title Widget'), findsOneWidget);
      expect(find.text('Ignored Title'), findsNothing);
    });

    testWidgets('renders leading and action widgets', (tester) async {
      bool leadingTapped = false;
      bool actionTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            appBar: SindbadAppBar(
              title: 'المتجر',
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  leadingTapped = true;
                },
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    actionTapped = true;
                  },
                ),
              ],
            ),
            body: const SizedBox.shrink(),
          ),
        ),
      );

      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);

      await tester.tap(find.byIcon(Icons.arrow_back));
      expect(leadingTapped, isTrue);

      await tester.tap(find.byIcon(Icons.search));
      expect(actionTapped, isTrue);
    });

    testWidgets('preferredSize calculates height with bottom widget and divider', (
      tester,
    ) async {
      const bottomWidget = PreferredSize(
        preferredSize: Size.fromHeight(48.0),
        child: SizedBox(height: 48.0),
      );

      const standardBar = SindbadAppBar(title: 'Test');
      expect(standardBar.preferredSize.height, 56.0);

      const barWithBottom = SindbadAppBar(
        title: 'Test',
        bottom: bottomWidget,
      );
      expect(barWithBottom.preferredSize.height, 56.0 + 48.0);

      const barWithDivider = SindbadAppBar(
        title: 'Test',
        showBottomDivider: true,
      );
      expect(barWithDivider.preferredSize.height, 56.0 + 1.0);

      const barWithBottomAndDivider = SindbadAppBar(
        title: 'Test',
        bottom: bottomWidget,
        showBottomDivider: true,
      );
      expect(barWithBottomAndDivider.preferredSize.height, 56.0 + 48.0 + 1.0);
    });

    testWidgets('adapts to dark theme mode', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: const Scaffold(
            appBar: SindbadAppBar(
              title: 'الوضع الليلي',
              subtitle: 'نظام التصميم',
            ),
            body: SizedBox.shrink(),
          ),
        ),
      );

      final titleFinder = find.text('الوضع الليلي');
      expect(titleFinder, findsOneWidget);

      final Text titleText = tester.widget<Text>(titleFinder);
      expect(titleText.style?.color, isNotNull);
    });
  });
}
