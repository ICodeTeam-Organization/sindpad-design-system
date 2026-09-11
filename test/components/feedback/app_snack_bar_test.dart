import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sindpad_design_system/sindpad_design_system.dart';

void main() {
  testWidgets('shows a success snackbar using semantic colors', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: Builder(
          builder: (context) => Scaffold(
            body: ElevatedButton(
              onPressed: () => AppSnackBar.show(
                context,
                message: 'Saved',
                type: AppSnackBarType.success,
              ),
              child: const Text('Show'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Show'));
    await tester.pump();

    final snackBar = tester.widget<SnackBar>(find.byType(SnackBar));
    expect(snackBar.backgroundColor, const Color(0xFF059669));
    expect(find.text('Saved'), findsOneWidget);
  });

  testWidgets('loading snackbar stays visible until explicitly hidden', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark(),
        home: Builder(
          builder: (context) => Scaffold(
            body: ElevatedButton(
              onPressed: () => AppSnackBar.show(
                context,
                message: 'Uploading',
                type: AppSnackBarType.loading,
              ),
              child: const Text('Show'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Show'));
    await tester.pump();
    await tester.pump(const Duration(minutes: 1));

    expect(find.text('Uploading'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    AppSnackBar.hide(tester.element(find.text('Uploading')));
    await tester.pumpAndSettle();
    expect(find.text('Uploading'), findsNothing);
  });

  testWidgets('supports all feedback types', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: Builder(
          builder: (context) => Scaffold(
            body: Column(
              children: [
                for (final type in AppSnackBarType.values)
                  ElevatedButton(
                    onPressed: () => AppSnackBar.show(
                      context,
                      message: type.name,
                      type: type,
                    ),
                    child: Text(type.name),
                  ),
              ],
            ),
          ),
        ),
      ),
    );

    for (final type in AppSnackBarType.values) {
      await tester.tap(find.text(type.name));
      await tester.pump();
      expect(find.byType(SnackBar), findsOneWidget);
      AppSnackBar.hide(tester.element(find.byType(SnackBar)));
      await tester.pumpAndSettle();
    }
  });
}
