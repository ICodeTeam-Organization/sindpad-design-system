import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sindpad_design_system/sindpad_design_system.dart';

Widget _buildTestApp({
  required Widget child,
  TextDirection textDirection = TextDirection.rtl,
  ThemeData? theme,
}) {
  return MaterialApp(
    theme: theme ?? AppTheme.light(),
    home: Directionality(
      textDirection: textDirection,
      child: Scaffold(body: child),
    ),
  );
}

void main() {
  group('LoginCredentials & AppLoginConfig Models', () {
    test('LoginCredentials equality, hashCode, and masked toString', () {
      const creds1 = LoginCredentials(
        identifier: 'user@example.com',
        password: 'secret_password_123',
      );
      const creds2 = LoginCredentials(
        identifier: 'user@example.com',
        password: 'secret_password_123',
      );
      const creds3 = LoginCredentials(
        identifier: 'other@example.com',
        password: 'secret_password_123',
      );

      expect(creds1, equals(creds2));
      expect(creds1.hashCode, equals(creds2.hashCode));
      expect(creds1 == creds3, isFalse);
      expect(creds1.toString(), contains('user@example.com'));
      expect(creds1.toString(), isNot(contains('secret_password_123')));
      expect(creds1.toString(), contains('[PROTECTED]'));
    });

    test('AppLoginConfig copyWith updates specified fields', () {
      const config = AppLoginConfig(
        title: 'Original Title',
        credentialType: LoginCredentialType.phone,
      );

      final updated = config.copyWith(
        title: 'Updated Title',
        showForgotPassword: false,
      );

      expect(updated.title, 'Updated Title');
      expect(updated.credentialType, LoginCredentialType.phone);
      expect(updated.showForgotPassword, isFalse);
      expect(updated.showSignUp, isTrue);
    });

    test('AppLoginConfig English preset provides appropriate defaults', () {
      const englishConfig = AppLoginConfig.english();

      expect(englishConfig.title, 'Sign In');
      expect(englishConfig.passwordLabel, 'Password');
      expect(englishConfig.getEffectiveCredentialLabel(isRtl: false),
          'Phone or Email');
    });
  });

  group('AppLoginForm Rendering', () {
    testWidgets('renders all standard elements in default configuration',
        (tester) async {
      await tester.pumpWidget(
        _buildTestApp(
          child: AppLoginForm(
            config: const AppLoginConfig(
              logo: Icon(Icons.shopping_bag, key: Key('test_logo')),
            ),
          ),
        ),
      );

      // Logo
      expect(find.byKey(const Key('test_logo')), findsOneWidget);

      // Title & Subtitle
      expect(find.text('تسجيل الدخول'), findsWidgets); // Title and button
      expect(find.text('قم بتسجيل الدخول لكي تتصفح خدمات التطبيق بكل سهولة'),
          findsOneWidget);

      // Fields
      expect(find.byKey(const Key('login_identifier_field')), findsOneWidget);
      expect(find.byKey(const Key('login_password_field')), findsOneWidget);

      // Action Links & Buttons
      expect(
          find.byKey(const Key('login_forgot_password_button')), findsOneWidget);
      expect(find.byKey(const Key('login_submit_button')), findsOneWidget);
      expect(find.byKey(const Key('login_signup_button')), findsOneWidget);

      // Social section
      expect(find.text('أو قم بتسجيل الدخول باستخدام'), findsOneWidget);
      expect(find.byKey(const Key('login_google_button')), findsOneWidget);
      expect(find.byKey(const Key('login_facebook_button')), findsOneWidget);
    });
  });

  group('AppLoginForm Interactions', () {
    testWidgets('password visibility toggle changes obscureText',
        (tester) async {
      await tester.pumpWidget(
        _buildTestApp(
          child: const AppLoginForm(),
        ),
      );

      final passwordFieldFinder = find.byKey(const Key('login_password_field'));
      final toggleFinder =
          find.byKey(const Key('login_password_visibility_button'));

      // Initially obscured
      EditableText editable = tester.widget<EditableText>(
        find.descendant(
            of: passwordFieldFinder, matching: find.byType(EditableText)),
      );
      expect(editable.obscureText, isTrue);

      // Tap toggle -> unobscured
      await tester.tap(toggleFinder);
      await tester.pumpAndSettle();

      editable = tester.widget<EditableText>(
        find.descendant(
            of: passwordFieldFinder, matching: find.byType(EditableText)),
      );
      expect(editable.obscureText, isFalse);

      // Tap toggle again -> obscured
      await tester.tap(toggleFinder);
      await tester.pumpAndSettle();

      editable = tester.widget<EditableText>(
        find.descendant(
            of: passwordFieldFinder, matching: find.byType(EditableText)),
      );
      expect(editable.obscureText, isTrue);
    });

    testWidgets(
        'validating and submitting invokes onLogin with entered credentials',
        (tester) async {
      LoginCredentials? submittedCredentials;

      await tester.pumpWidget(
        _buildTestApp(
          child: AppLoginForm(
            onLogin: (creds) {
              submittedCredentials = creds;
            },
          ),
        ),
      );

      final submitFinder = find.byKey(const Key('login_submit_button'));

      // Tapping submit with empty fields triggers validation and does NOT call onLogin
      await tester.tap(submitFinder);
      await tester.pumpAndSettle();

      expect(submittedCredentials, isNull);
      expect(find.text('هذا الحقل مطلوب'), findsOneWidget);
      expect(find.text('كلمة المرور مطلوبة'), findsOneWidget);

      // Enter valid values
      await tester.enterText(
        find.byKey(const Key('login_identifier_field')),
        '0512345678',
      );
      await tester.enterText(
        find.byKey(const Key('login_password_field')),
        'mypassword123',
      );
      await tester.pumpAndSettle();

      // Tap submit again
      await tester.tap(submitFinder);
      await tester.pumpAndSettle();

      expect(submittedCredentials, isNotNull);
      expect(submittedCredentials!.identifier, '0512345678');
      expect(submittedCredentials!.password, 'mypassword123');
    });

    testWidgets('action callbacks are triggered upon tap', (tester) async {
      bool forgotPasswordTapped = false;
      bool signUpTapped = false;
      bool googleTapped = false;
      bool facebookTapped = false;

      await tester.pumpWidget(
        _buildTestApp(
          child: AppLoginForm(
            onForgotPassword: () => forgotPasswordTapped = true,
            onSignUp: () => signUpTapped = true,
            onGoogleLogin: () => googleTapped = true,
            onFacebookLogin: () => facebookTapped = true,
          ),
        ),
      );

      await tester.tap(find.byKey(const Key('login_forgot_password_button')));
      expect(forgotPasswordTapped, isTrue);

      await tester.tap(find.byKey(const Key('login_signup_button')));
      expect(signUpTapped, isTrue);

      await tester.tap(find.byKey(const Key('login_google_button')));
      expect(googleTapped, isTrue);

      await tester.tap(find.byKey(const Key('login_facebook_button')));
      expect(facebookTapped, isTrue);
    });
  });

  group('AppLoginForm Configuration Options', () {
    testWidgets('hides elements when corresponding flags are false',
        (tester) async {
      await tester.pumpWidget(
        _buildTestApp(
          child: const AppLoginForm(
            config: AppLoginConfig(
              showForgotPassword: false,
              showSignUp: false,
              showSocialLogin: false,
            ),
          ),
        ),
      );

      expect(find.byKey(const Key('login_forgot_password_button')), findsNothing);
      expect(find.byKey(const Key('login_signup_button')), findsNothing);
      expect(find.byKey(const Key('login_google_button')), findsNothing);
      expect(find.byKey(const Key('login_facebook_button')), findsNothing);
      expect(find.text('أو قم بتسجيل الدخول باستخدام'), findsNothing);
    });

    testWidgets('individually hides Google or Facebook buttons',
        (tester) async {
      await tester.pumpWidget(
        _buildTestApp(
          child: const AppLoginForm(
            config: AppLoginConfig(
              showGoogleLogin: false,
              showFacebookLogin: true,
            ),
          ),
        ),
      );

      expect(find.byKey(const Key('login_google_button')), findsNothing);
      expect(find.byKey(const Key('login_facebook_button')), findsOneWidget);
    });

    testWidgets('different credential types configure appropriate labels',
        (tester) async {
      await tester.pumpWidget(
        _buildTestApp(
          child: const AppLoginForm(
            config: AppLoginConfig(
              credentialType: LoginCredentialType.email,
            ),
          ),
        ),
      );

      expect(find.text('البريد الإلكتروني'), findsOneWidget);

      await tester.pumpWidget(
        _buildTestApp(
          child: const AppLoginForm(
            config: AppLoginConfig(
              credentialType: LoginCredentialType.phone,
            ),
          ),
        ),
      );

      expect(find.text('رقم الهاتف'), findsOneWidget);
    });

    testWidgets('displays custom labels when provided', (tester) async {
      await tester.pumpWidget(
        _buildTestApp(
          child: const AppLoginForm(
            config: AppLoginConfig(
              title: 'Custom Title',
              subtitle: 'Custom Subtitle',
              credentialLabel: 'Custom Identifier',
              passwordLabel: 'Custom Password',
              loginButtonLabel: 'Custom Submit',
              forgotPasswordLabel: 'Custom Reset',
              signUpPrompt: 'Custom Prompt',
              signUpLabel: 'Custom Register',
              dividerText: 'Custom Divider',
              googleButtonLabel: 'Sign in with Google Account',
              facebookButtonLabel: 'Sign in with Meta',
            ),
          ),
        ),
      );

      expect(find.text('Custom Title'), findsOneWidget);
      expect(find.text('Custom Subtitle'), findsOneWidget);
      expect(find.text('Custom Identifier'), findsOneWidget);
      expect(find.text('Custom Password'), findsOneWidget);
      expect(find.text('Custom Submit'), findsOneWidget);
      expect(find.text('Custom Reset'), findsOneWidget);
      expect(find.text('Custom Prompt'), findsOneWidget);
      expect(find.text('Custom Register'), findsOneWidget);
      expect(find.text('Custom Divider'), findsOneWidget);
      expect(find.text('Sign in with Google Account'), findsOneWidget);
      expect(find.text('Sign in with Meta'), findsOneWidget);
    });
  });

  group('AppLoginForm State Handling', () {
    testWidgets('loading state disables button and shows progress indicator',
        (tester) async {
      bool loginCalled = false;

      await tester.pumpWidget(
        _buildTestApp(
          child: AppLoginForm(
            isLoading: true,
            onLogin: (_) => loginCalled = true,
          ),
        ),
      );

      // Loading indicator should be visible
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Tapping login button while loading does not submit
      await tester.tap(find.byKey(const Key('login_submit_button')));
      await tester.pump();

      expect(loginCalled, isFalse);
    });

    testWidgets('disabled state prevents submission and callbacks',
        (tester) async {
      bool loginCalled = false;

      await tester.pumpWidget(
        _buildTestApp(
          child: AppLoginForm(
            enabled: false,
            onLogin: (_) => loginCalled = true,
          ),
        ),
      );

      await tester.tap(find.byKey(const Key('login_submit_button')));
      await tester.pumpAndSettle();

      expect(loginCalled, isFalse);
    });

    testWidgets('error message displays in dedicated error banner',
        (tester) async {
      await tester.pumpWidget(
        _buildTestApp(
          child: const AppLoginForm(
            errorMessage: 'اسم المستخدم أو كلمة المرور غير صحيحة',
          ),
        ),
      );

      expect(find.byKey(const Key('login_error_banner')), findsOneWidget);
      expect(find.text('اسم المستخدم أو كلمة المرور غير صحيحة'), findsOneWidget);
    });
  });

  group('AppLoginForm RTL and LTR Support', () {
    testWidgets('renders cleanly in RTL (Arabic)', (tester) async {
      await tester.pumpWidget(
        _buildTestApp(
          textDirection: TextDirection.rtl,
          child: const AppLoginForm(
            config: AppLoginConfig.arabic(),
          ),
        ),
      );

      expect(find.text('تسجيل الدخول'), findsWidgets);
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders cleanly in LTR (English)', (tester) async {
      await tester.pumpWidget(
        _buildTestApp(
          textDirection: TextDirection.ltr,
          child: const AppLoginForm(
            config: AppLoginConfig.english(),
          ),
        ),
      );

      expect(find.text('Sign In'), findsWidgets);
      expect(find.text('Forgot password?'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
