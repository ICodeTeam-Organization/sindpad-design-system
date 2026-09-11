import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sindpad_design_system/sindpad_design_system.dart';

void main() {
  testWidgets('renders button variants and sizes', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Wrap(
          children: const [
            AppButton(label: 'Primary'),
            AppButton(label: 'Outlined', variant: AppButtonVariant.outlined),
            AppButton(label: 'Text', variant: AppButtonVariant.text),
            AppButton(label: 'Small', size: AppButtonSize.small),
            AppButton(label: 'Large', size: AppButtonSize.large),
          ],
        ),
      ),
    );

    expect(find.text('Primary'), findsOneWidget);
    expect(find.text('Outlined'), findsOneWidget);
    expect(find.text('Text'), findsOneWidget);
    expect(find.text('Small'), findsOneWidget);
    expect(find.text('Large'), findsOneWidget);
    expect(find.byType(FilledButton), findsNWidgets(3));
    expect(find.byType(OutlinedButton), findsOneWidget);
    expect(find.byType(TextButton), findsOneWidget);
  });

  testWidgets('loading button is disabled and shows progress', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: AppButton(label: 'Saving', isLoading: true)),
    );

    final button = tester.widget<FilledButton>(find.byType(FilledButton));
    expect(button.onPressed, isNull);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Saving'), findsNothing);
  });

  testWidgets('icon button exposes its tooltip', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AppIconButton(
          icon: Icons.favorite_border,
          tooltip: 'Favorite',
          onPressed: () {},
        ),
      ),
    );

    expect(find.byTooltip('Favorite'), findsOneWidget);
  });
}
