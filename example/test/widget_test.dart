import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Foundation preview screen loads smoke test', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const SindpadPreviewApp());

    expect(find.text('Sindpad Design System'), findsOneWidget);
    expect(find.text('Foundation Preview'), findsOneWidget);
    expect(find.text('1. Colors'), findsOneWidget);

    // Verify theme toggle action button is present and tap works
    final toggleButton = find.byTooltip('Toggle Theme');
    expect(toggleButton, findsOneWidget);
    await tester.tap(toggleButton);
    await tester.pump();

    // Switch to Login Form tab
    final loginTab = find.text('Login Form');
    expect(loginTab, findsOneWidget);
    await tester.tap(loginTab);
    await tester.pump();

    // Verify Login Preview Screen loads
    expect(find.text('تسجيل الدخول'), findsWidgets);
    expect(find.byKey(const Key('login_submit_button')), findsOneWidget);

    // Switch to the Components preview tab.
    await tester.tap(find.text('Components'));
    await tester.pump();

    expect(find.text('Reusable component preview'), findsOneWidget);
    for (final label in [
      'Success',
      'Error',
      'Warning',
      'Info',
      'Loading',
      'Default',
    ]) {
      expect(find.widgetWithText(FilledButton, label), findsOneWidget);
    }
    expect(find.widgetWithText(OutlinedButton, 'Hide'), findsOneWidget);
  });
}
