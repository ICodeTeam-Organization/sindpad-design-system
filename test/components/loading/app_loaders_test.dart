import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sindpad_design_system/sindpad_design_system.dart';

void main() {
  testWidgets('renders the loading component family', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: SingleChildScrollView(
          child: Column(
            children: const [
              AppLoader(message: 'Loading'),
              CircularLoader(),
              LinearLoader(value: 0.5),
              Skeleton(),
              ProductSkeleton(),
              ListSkeleton(itemCount: 2),
              CardSkeleton(),
              PageLoader(),
            ],
          ),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsNWidgets(3));
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
    expect(find.byType(Skeleton), findsWidgets);
    expect(find.text('Loading'), findsOneWidget);
    expect(find.text('Loading...'), findsOneWidget);
  });
}
