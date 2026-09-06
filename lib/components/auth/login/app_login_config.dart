import 'package:flutter/widgets.dart';

import 'app_login_models.dart';

/// Comprehensive configuration for presentation and behavior of [AppLoginForm].
///
/// Controls all texts, visibility flags, widget slots, and layout parameters
/// while keeping the login component brand-agnostic and customizable across apps.
@immutable
class AppLoginConfig {
  /// Primary screen title.
  final String? title;

  /// Explanatory subtitle below the title.
  final String? subtitle;

  /// Custom logo widget displayed inside the styled badge container.
  final Widget? logo;

  /// Size (width and height) of the logo badge container.
  final double logoBadgeSize;

  /// Corner radius of the logo badge container.
  final double? logoBadgeRadius;

  /// Whether to show the logo badge container.
  final bool showLogo;

  /// The input identifier mode (email, phone, or phoneOrEmail).
  final LoginCredentialType credentialType;

  /// Custom label for the credential input field.
  final String? credentialLabel;

  /// Custom placeholder/hint for the credential input field.
  final String? credentialHint;

  /// Label for the password field.
  final String? passwordLabel;

  /// Placeholder/hint for the password field.
  final String? passwordHint;

  /// Label for the primary login action button.
  final String? loginButtonLabel;

  /// Text for the "Forgot Password" action link.
  final String? forgotPasswordLabel;

  /// Prompt text preceding the signup link (e.g. "Don't have an account?").
  final String? signUpPrompt;

  /// Action text for the signup link (e.g. "Create account").
  final String? signUpLabel;

  /// Divider text separating standard login from social login options.
  final String? dividerText;

  /// Whether to display the "Forgot Password" button.
  final bool showForgotPassword;

  /// Whether to display the sign-up prompt and link.
  final bool showSignUp;

  /// Whether to display the social login section (divider + social buttons).
  final bool showSocialLogin;

  /// Whether to display the Google login button within the social login section.
  final bool showGoogleLogin;

  /// Whether to display the Facebook login button within the social login section.
  final bool showFacebookLogin;

  /// Custom label for the Google login button.
  final String? googleButtonLabel;

  /// Custom label for the Facebook login button.
  final String? facebookButtonLabel;

  /// Custom icon widget for Google login button.
  final Widget? googleIcon;

  /// Custom icon widget for Facebook login button.
  final Widget? facebookIcon;

  /// Optional prefix widget for credential input (e.g. country dial code picker or custom icon).
  final Widget? credentialPrefix;

  /// Optional suffix widget for credential input.
  final Widget? credentialSuffix;

  /// Override keyboard type for the credential input field.
  final TextInputType? credentialKeyboardType;

  /// Maximum content width to constrain layout on tablets and desktops.
  final double maxContentWidth;

  /// Content padding inside the scroll view.
  final EdgeInsetsGeometry? contentPadding;

  /// Optional footer slot widget (e.g. app version, copyright, or terms of service).
  final Widget? footer;

  /// Custom input field border radius.
  final double? inputRadius;

  /// Custom button border radius.
  final double? buttonRadius;

  /// Height of the primary login action button.
  final double buttonHeight;

  /// Height of the social login buttons.
  final double socialButtonHeight;

  const AppLoginConfig({
    this.title = 'تسجيل الدخول',
    this.subtitle = 'قم بتسجيل الدخول لكي تتصفح خدمات التطبيق بكل سهولة',
    this.logo,
    this.logoBadgeSize = 72.0,
    this.logoBadgeRadius,
    this.showLogo = true,
    this.credentialType = LoginCredentialType.phoneOrEmail,
    this.credentialLabel,
    this.credentialHint,
    this.passwordLabel = 'كلمة المرور',
    this.passwordHint,
    this.loginButtonLabel = 'تسجيل الدخول',
    this.forgotPasswordLabel = 'هل نسيت كلمة المرور؟',
    this.signUpPrompt = 'ليس لديك حساب؟',
    this.signUpLabel = 'إنشاء حساب جديد',
    this.dividerText = 'أو قم بتسجيل الدخول باستخدام',
    this.showForgotPassword = true,
    this.showSignUp = true,
    this.showSocialLogin = true,
    this.showGoogleLogin = true,
    this.showFacebookLogin = true,
    this.googleButtonLabel = 'Google',
    this.facebookButtonLabel = 'Facebook',
    this.googleIcon,
    this.facebookIcon,
    this.credentialPrefix,
    this.credentialSuffix,
    this.credentialKeyboardType,
    this.maxContentWidth = 480.0,
    this.contentPadding,
    this.footer,
    this.inputRadius,
    this.buttonRadius,
    this.buttonHeight = 54.0,
    this.socialButtonHeight = 54.0,
  });

  /// Factory for Arabic locale defaults.
  const AppLoginConfig.arabic({
    this.title = 'تسجيل الدخول',
    this.subtitle = 'قم بتسجيل الدخول لكي تتصفح خدمات التطبيق بكل سهولة',
    this.logo,
    this.logoBadgeSize = 72.0,
    this.logoBadgeRadius,
    this.showLogo = true,
    this.credentialType = LoginCredentialType.phoneOrEmail,
    this.credentialLabel,
    this.credentialHint,
    this.passwordLabel = 'كلمة المرور',
    this.passwordHint,
    this.loginButtonLabel = 'تسجيل الدخول',
    this.forgotPasswordLabel = 'هل نسيت كلمة المرور؟',
    this.signUpPrompt = 'ليس لديك حساب؟',
    this.signUpLabel = 'إنشاء حساب جديد',
    this.dividerText = 'أو قم بتسجيل الدخول باستخدام',
    this.showForgotPassword = true,
    this.showSignUp = true,
    this.showSocialLogin = true,
    this.showGoogleLogin = true,
    this.showFacebookLogin = true,
    this.googleButtonLabel = 'Google',
    this.facebookButtonLabel = 'Facebook',
    this.googleIcon,
    this.facebookIcon,
    this.credentialPrefix,
    this.credentialSuffix,
    this.credentialKeyboardType,
    this.maxContentWidth = 480.0,
    this.contentPadding,
    this.footer,
    this.inputRadius,
    this.buttonRadius,
    this.buttonHeight = 54.0,
    this.socialButtonHeight = 54.0,
  });

  /// Factory for English locale defaults.
  const AppLoginConfig.english({
    this.title = 'Sign In',
    this.subtitle = 'Sign in to easily browse all app services',
    this.logo,
    this.logoBadgeSize = 72.0,
    this.logoBadgeRadius,
    this.showLogo = true,
    this.credentialType = LoginCredentialType.phoneOrEmail,
    this.credentialLabel,
    this.credentialHint,
    this.passwordLabel = 'Password',
    this.passwordHint,
    this.loginButtonLabel = 'Sign In',
    this.forgotPasswordLabel = 'Forgot password?',
    this.signUpPrompt = "Don't have an account?",
    this.signUpLabel = 'Sign up',
    this.dividerText = 'Or sign in with',
    this.showForgotPassword = true,
    this.showSignUp = true,
    this.showSocialLogin = true,
    this.showGoogleLogin = true,
    this.showFacebookLogin = true,
    this.googleButtonLabel = 'Google',
    this.facebookButtonLabel = 'Facebook',
    this.googleIcon,
    this.facebookIcon,
    this.credentialPrefix,
    this.credentialSuffix,
    this.credentialKeyboardType,
    this.maxContentWidth = 480.0,
    this.contentPadding,
    this.footer,
    this.inputRadius,
    this.buttonRadius,
    this.buttonHeight = 54.0,
    this.socialButtonHeight = 54.0,
  });

  /// Resolves the effective label for the credential input field.
  String getEffectiveCredentialLabel({bool isRtl = true}) {
    if (credentialLabel != null && credentialLabel!.isNotEmpty) {
      return credentialLabel!;
    }
    if (isRtl) {
      switch (credentialType) {
        case LoginCredentialType.email:
          return 'البريد الإلكتروني';
        case LoginCredentialType.phone:
          return 'رقم الهاتف';
        case LoginCredentialType.phoneOrEmail:
          return 'رقم الهاتف أو البريد الإلكتروني';
      }
    } else {
      switch (credentialType) {
        case LoginCredentialType.email:
          return 'Email';
        case LoginCredentialType.phone:
          return 'Phone number';
        case LoginCredentialType.phoneOrEmail:
          return 'Phone or Email';
      }
    }
  }

  /// Resolves the effective hint for the credential input field.
  String? getEffectiveCredentialHint({bool isRtl = true}) {
    if (credentialHint != null && credentialHint!.isNotEmpty) {
      return credentialHint;
    }
    if (isRtl) {
      switch (credentialType) {
        case LoginCredentialType.email:
          return 'example@domain.com';
        case LoginCredentialType.phone:
          return '05XXXXXXXX';
        case LoginCredentialType.phoneOrEmail:
          return 'example@domain.com أو 05XXXXXXXX';
      }
    } else {
      switch (credentialType) {
        case LoginCredentialType.email:
          return 'example@domain.com';
        case LoginCredentialType.phone:
          return '+1 234 567 890';
        case LoginCredentialType.phoneOrEmail:
          return 'example@domain.com or phone';
      }
    }
  }

  AppLoginConfig copyWith({
    String? title,
    String? subtitle,
    Widget? logo,
    double? logoBadgeSize,
    double? logoBadgeRadius,
    bool? showLogo,
    LoginCredentialType? credentialType,
    String? credentialLabel,
    String? credentialHint,
    String? passwordLabel,
    String? passwordHint,
    String? loginButtonLabel,
    String? forgotPasswordLabel,
    String? signUpPrompt,
    String? signUpLabel,
    String? dividerText,
    bool? showForgotPassword,
    bool? showSignUp,
    bool? showSocialLogin,
    bool? showGoogleLogin,
    bool? showFacebookLogin,
    String? googleButtonLabel,
    String? facebookButtonLabel,
    Widget? googleIcon,
    Widget? facebookIcon,
    Widget? credentialPrefix,
    Widget? credentialSuffix,
    TextInputType? credentialKeyboardType,
    double? maxContentWidth,
    EdgeInsetsGeometry? contentPadding,
    Widget? footer,
    double? inputRadius,
    double? buttonRadius,
    double? buttonHeight,
    double? socialButtonHeight,
  }) {
    return AppLoginConfig(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      logo: logo ?? this.logo,
      logoBadgeSize: logoBadgeSize ?? this.logoBadgeSize,
      logoBadgeRadius: logoBadgeRadius ?? this.logoBadgeRadius,
      showLogo: showLogo ?? this.showLogo,
      credentialType: credentialType ?? this.credentialType,
      credentialLabel: credentialLabel ?? this.credentialLabel,
      credentialHint: credentialHint ?? this.credentialHint,
      passwordLabel: passwordLabel ?? this.passwordLabel,
      passwordHint: passwordHint ?? this.passwordHint,
      loginButtonLabel: loginButtonLabel ?? this.loginButtonLabel,
      forgotPasswordLabel: forgotPasswordLabel ?? this.forgotPasswordLabel,
      signUpPrompt: signUpPrompt ?? this.signUpPrompt,
      signUpLabel: signUpLabel ?? this.signUpLabel,
      dividerText: dividerText ?? this.dividerText,
      showForgotPassword: showForgotPassword ?? this.showForgotPassword,
      showSignUp: showSignUp ?? this.showSignUp,
      showSocialLogin: showSocialLogin ?? this.showSocialLogin,
      showGoogleLogin: showGoogleLogin ?? this.showGoogleLogin,
      showFacebookLogin: showFacebookLogin ?? this.showFacebookLogin,
      googleButtonLabel: googleButtonLabel ?? this.googleButtonLabel,
      facebookButtonLabel: facebookButtonLabel ?? this.facebookButtonLabel,
      googleIcon: googleIcon ?? this.googleIcon,
      facebookIcon: facebookIcon ?? this.facebookIcon,
      credentialPrefix: credentialPrefix ?? this.credentialPrefix,
      credentialSuffix: credentialSuffix ?? this.credentialSuffix,
      credentialKeyboardType:
          credentialKeyboardType ?? this.credentialKeyboardType,
      maxContentWidth: maxContentWidth ?? this.maxContentWidth,
      contentPadding: contentPadding ?? this.contentPadding,
      footer: footer ?? this.footer,
      inputRadius: inputRadius ?? this.inputRadius,
      buttonRadius: buttonRadius ?? this.buttonRadius,
      buttonHeight: buttonHeight ?? this.buttonHeight,
      socialButtonHeight: socialButtonHeight ?? this.socialButtonHeight,
    );
  }
}
