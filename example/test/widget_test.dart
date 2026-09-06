import 'package:example/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Foundation preview screen loads smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const SindpadPreviewApp());

    expect(find.text('Sindpad Design System'), findsOneWidget);
    expect(find.text('Foundation Preview'), findsOneWidget);
    expect(find.text('1. Colors'), findsOneWidget);

    // Verify theme toggle action button is present and tap works
    final toggleButton = find.byTooltip('Toggle Theme');
    expect(toggleButton, findsOneWidget);
    await tester.tap(toggleButton);
    await tester.pumpAndSettle();
  });
}
