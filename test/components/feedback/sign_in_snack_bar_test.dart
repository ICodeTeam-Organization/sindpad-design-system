import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sindpad_design_system/sindpad_design_system.dart';

void main() {
  testWidgets('show renders the message and login action', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: ElevatedButton(
              onPressed: () => SignInSnackBar.show(
                context,
                message: 'Sign in required',
                buttonText: 'Sign in',
              ),
              child: const Text('Show'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Show'));
    await tester.pump();

    expect(find.text('Sign in required'), findsOneWidget);
    expect(find.text('Sign in'), findsOneWidget);
  });

  testWidgets('login action invokes the supplied callback', (tester) async {
    var loginPressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: ElevatedButton(
              onPressed: () => SignInSnackBar.show(
                context,
                onLoginPressed: () => loginPressed = true,
              ),
              child: const Text('Show'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Show'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ElevatedButton, 'تسجيل الدخول'));

    expect(loginPressed, isTrue);
  });
}
