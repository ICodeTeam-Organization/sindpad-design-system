import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sindpad_design_system/sindpad_design_system.dart';

void main() {
  testWidgets('renders an empty state with an optional action', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AppEmptyWidget(
          title: 'No results',
          message: 'Try another search.',
          action: TextButton(
            onPressed: () {},
            child: const Text('Clear filters'),
          ),
        ),
      ),
    );

    expect(find.text('No results'), findsOneWidget);
    expect(find.text('Try another search.'), findsOneWidget);
    expect(find.text('Clear filters'), findsOneWidget);
    expect(find.byIcon(Icons.inbox_outlined), findsOneWidget);
  });
}
