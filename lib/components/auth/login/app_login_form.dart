import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../../../foundations/colors/app_colors.dart';
import '../../../foundations/colors/semantic_colors.dart';
import '../../../foundations/dimensions/app_dimensions.dart';
import '../../../foundations/radius/app_radius.dart';
import '../../../foundations/spacing/app_spacing.dart';
import '../../../foundations/typography/app_typography.dart';
import '../../../theme/theme_extensions.dart';
import 'app_login_config.dart';
import 'app_login_models.dart';

/// Production-ready, reusable login form component for Sindpad applications.
///
/// Implements a fully configurable presentation layer for authentication with:
/// - Responsive layout supporting phones, tablets, and desktop
/// - Full RTL (Arabic) and LTR (English) support
/// - Credential input (Email, Phone, or Phone/Email combined)
/// - Obscure/visible password toggle with accessibility semantics
/// - Built-in validation with customizable validator hooks
/// - Loading state with disabled controls and activity indicator
/// - External error banner presentation (no unexpected SnackBars)
/// - Optional Forgot Password and Sign Up links
/// - Optional Google and Facebook social login buttons with self-contained vector logos
///
/// Follows strict architecture boundaries: Presentation + UI State + Callbacks only.
/// All backend, BLoC, Cubit, token, and navigation logic are owned by the consuming app.
class AppLoginForm extends StatefulWidget {
  /// Visual and content configuration for the login form.
  final AppLoginConfig config;

  /// Callback invoked when the user submits valid credentials.
  final ValueChanged<LoginCredentials>? onLogin;

  /// Callback invoked when the user taps "Forgot Password".
  final VoidCallback? onForgotPassword;

  /// Callback invoked when the user taps "Sign Up" / "Create Account".
  final VoidCallback? onSignUp;

  /// Callback invoked when the user taps the Google login button.
  final VoidCallback? onGoogleLogin;

  /// Callback invoked when the user taps the Facebook login button.
  final VoidCallback? onFacebookLogin;

  /// When true, disables submission and displays a loading indicator on the primary button.
  final bool isLoading;

  /// Optional error message displayed in a prominent error banner.
  final String? errorMessage;

  /// Optional controller for the identifier input field.
  final TextEditingController? identifierController;

  /// Optional controller for the password input field.
  final TextEditingController? passwordController;

  /// Optional custom validator for the identifier input field.
  final FormFieldValidator<String>? identifierValidator;

  /// Optional custom validator for the password input field.
  final FormFieldValidator<String>? passwordValidator;

  /// Optional focus node for the identifier input field.
  final FocusNode? identifierFocusNode;

  /// Optional focus node for the password input field.
  final FocusNode? passwordFocusNode;

  /// Optional form key for external validation control.
  final GlobalKey<FormState>? formKey;

  /// Whether form inputs and buttons are interactive.
  final bool enabled;

  /// Optional slot widget placed above the logo/title.
  final Widget? header;

  /// Optional slot widget placed at the bottom of the form (e.g. app version).
  final Widget? footer;

  const AppLoginForm({
    super.key,
    this.config = const AppLoginConfig(),
    this.onLogin,
    this.onForgotPassword,
    this.onSignUp,
    this.onGoogleLogin,
    this.onFacebookLogin,
    this.isLoading = false,
    this.errorMessage,
    this.identifierController,
    this.passwordController,
    this.identifierValidator,
    this.passwordValidator,
    this.identifierFocusNode,
    this.passwordFocusNode,
    this.formKey,
    this.enabled = true,
    this.header,
    this.footer,
  });

  @override
  State<AppLoginForm> createState() => _AppLoginFormState();
}

class _AppLoginFormState extends State<AppLoginForm> {
  late final GlobalKey<FormState> _formKey;
  TextEditingController? _internalIdentifierController;
  TextEditingController? _internalPasswordController;
  FocusNode? _internalIdentifierFocusNode;
  FocusNode? _internalPasswordFocusNode;

  bool _obscurePassword = true;

  TextEditingController get _effectiveIdentifierController =>
      widget.identifierController ??
      (_internalIdentifierController ??= TextEditingController());

  TextEditingController get _effectivePasswordController =>
      widget.passwordController ??
      (_internalPasswordController ??= TextEditingController());

  FocusNode get _effectiveIdentifierFocusNode =>
      widget.identifierFocusNode ??
      (_internalIdentifierFocusNode ??= FocusNode());

  FocusNode get _effectivePasswordFocusNode =>
      widget.passwordFocusNode ??
      (_internalPasswordFocusNode ??= FocusNode());

  @override
  void initState() {
    super.initState();
    _formKey = widget.formKey ?? GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _internalIdentifierController?.dispose();
    _internalPasswordController?.dispose();
    _internalIdentifierFocusNode?.dispose();
    _internalPasswordFocusNode?.dispose();
    super.dispose();
  }

  void _submit() {
    if (!widget.enabled || widget.isLoading) return;

    final form = _formKey.currentState;
    if (form != null && form.validate()) {
      FocusScope.of(context).unfocus();
      final credentials = LoginCredentials(
        identifier: _effectiveIdentifierController.text.trim(),
        password: _effectivePasswordController.text,
      );
      widget.onLogin?.call(credentials);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Safe retrieval of design system tokens with robust fallbacks
    final ext = theme.extension<SindpadThemeExtension>();
    final semantic = ext?.semanticColors ??
        (isDark
            ? const SemanticColors.darkDefault()
            : const SemanticColors.lightDefault());
    final raw = ext?.colors ??
        (theme.colorScheme.primary != const Color(0xff6750a4)
            ? AppColors.fallback().copyWith(primary: theme.colorScheme.primary)
            : const AppColors.fallback());
    final typography = ext?.typography ?? AppTypography.regular();
    final spacing = ext?.spacing ?? const AppSpacing.standard();
    final radius = ext?.radius ?? const AppRadius.standard();
    final dimensions = ext?.dimensions ?? const AppDimensions.standard();

    final config = widget.config;

    final effectivePadding = config.contentPadding ??
        EdgeInsets.symmetric(
          horizontal: spacing.sLg,
          vertical: spacing.sXl,
        );

    final inputBorderRadius = BorderRadius.circular(
      config.inputRadius ?? radius.rSm,
    );

    final buttonBorderRadius = BorderRadius.circular(
      config.buttonRadius ?? radius.rLg,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).unfocus(),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: config.maxContentWidth,
              ),
              child: SingleChildScrollView(
                padding: effectivePadding,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Header slot
                      if (widget.header != null) ...[
                        widget.header!,
                        SizedBox(height: spacing.sMd),
                      ],

                      // Logo Badge
                      if (config.showLogo && config.logo != null) ...[
                        Center(
                          child: _buildLogoBadge(
                            config: config,
                            semantic: semantic,
                            radius: radius,
                          ),
                        ),
                        SizedBox(height: spacing.sLg),
                      ],

                      // Title & Subtitle
                      if (config.title != null && config.title!.isNotEmpty) ...[
                        Text(
                          config.title!,
                          textAlign: TextAlign.center,
                          style: typography.headlineMedium.copyWith(
                            color: semantic.textPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                          ),
                        ),
                        if (config.subtitle != null &&
                            config.subtitle!.isNotEmpty) ...[
                          SizedBox(height: spacing.sXs),
                          Text(
                            config.subtitle!,
                            textAlign: TextAlign.center,
                            style: typography.bodyMedium.copyWith(
                              color: semantic.textSecondary,
                              fontSize: 14,
                            ),
                          ),
                        ],
                        SizedBox(height: spacing.sXl),
                      ],

                      // Error Banner
                      if (widget.errorMessage != null &&
                          widget.errorMessage!.trim().isNotEmpty) ...[
                        _buildErrorBanner(
                          errorMessage: widget.errorMessage!.trim(),
                          semantic: semantic,
                          typography: typography,
                          spacing: spacing,
                          radius: radius,
                        ),
                        SizedBox(height: spacing.sMd),
                      ],

                      // Credential Input Field
                      _buildCredentialField(
                        config: config,
                        semantic: semantic,
                        raw: raw,
                        typography: typography,
                        spacing: spacing,
                        borderRadius: inputBorderRadius,
                        isRtl: isRtl,
                      ),
                      SizedBox(height: spacing.sMd),

                      // Password Input Field
                      _buildPasswordField(
                        config: config,
                        semantic: semantic,
                        raw: raw,
                        typography: typography,
                        spacing: spacing,
                        borderRadius: inputBorderRadius,
                        isRtl: isRtl,
                      ),

                      // Forgot Password Link
                      if (config.showForgotPassword) ...[
                        SizedBox(height: spacing.sXs),
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: _buildForgotPasswordButton(
                            config: config,
                            raw: raw,
                            semantic: semantic,
                            typography: typography,
                            dimensions: dimensions,
                            isRtl: isRtl,
                          ),
                        ),
                        SizedBox(height: spacing.sSm),
                      ] else ...[
                        SizedBox(height: spacing.sLg),
                      ],

                      // Primary Login Action Button
                      _buildLoginButton(
                        config: config,
                        raw: raw,
                        semantic: semantic,
                        typography: typography,
                        borderRadius: buttonBorderRadius,
                        isRtl: isRtl,
                      ),

                      // Sign Up Prompt & Link
                      if (config.showSignUp) ...[
                        SizedBox(height: spacing.sMd),
                        _buildSignUpSection(
                          config: config,
                          raw: raw,
                          semantic: semantic,
                          typography: typography,
                          spacing: spacing,
                          isRtl: isRtl,
                        ),
                      ],

                      // Social Login Section
                      if (config.showSocialLogin &&
                          (config.showGoogleLogin ||
                              config.showFacebookLogin)) ...[
                        SizedBox(height: spacing.sLg),
                        _buildDivider(
                          config: config,
                          semantic: semantic,
                          typography: typography,
                          spacing: spacing,
                          isRtl: isRtl,
                        ),
                        SizedBox(height: spacing.sLg),
                        if (config.showGoogleLogin) ...[
                          _buildSocialButton(
                            key: const Key('login_google_button'),
                            label: config.googleButtonLabel ?? 'Google',
                            icon: config.googleIcon ??
                                const _GoogleVectorLogo(size: 22),
                            onTap: (widget.enabled && !widget.isLoading)
                                ? widget.onGoogleLogin
                                : null,
                            config: config,
                            semantic: semantic,
                            typography: typography,
                            borderRadius: buttonBorderRadius,
                            spacing: spacing,
                          ),
                        ],
                        if (config.showGoogleLogin &&
                            config.showFacebookLogin) ...[
                          SizedBox(height: spacing.sSm),
                        ],
                        if (config.showFacebookLogin) ...[
                          _buildSocialButton(
                            key: const Key('login_facebook_button'),
                            label: config.facebookButtonLabel ?? 'Facebook',
                            icon: config.facebookIcon ??
                                const _FacebookVectorLogo(size: 22),
                            onTap: (widget.enabled && !widget.isLoading)
                                ? widget.onFacebookLogin
                                : null,
                            config: config,
                            semantic: semantic,
                            typography: typography,
                            borderRadius: buttonBorderRadius,
                            spacing: spacing,
                          ),
                        ],
                      ],

                      // Footer slot
                      if (widget.footer != null || config.footer != null) ...[
                        SizedBox(height: spacing.sXl),
                        Center(child: widget.footer ?? config.footer!),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLogoBadge({
    required AppLoginConfig config,
    required SemanticColors semantic,
    required AppRadius radius,
  }) {
    final size = config.logoBadgeSize;
    final badgeRadius = config.logoBadgeRadius ?? radius.rLg;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: semantic.surfaceSubtle,
        borderRadius: BorderRadius.circular(badgeRadius),
        border: Border.all(
          color: semantic.borderSubtle,
          width: 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.center,
      child: config.logo,
    );
  }

  Widget _buildErrorBanner({
    required String errorMessage,
    required SemanticColors semantic,
    required AppTypography typography,
    required AppSpacing spacing,
    required AppRadius radius,
  }) {
    return Container(
      key: const Key('login_error_banner'),
      padding: EdgeInsets.symmetric(
        horizontal: spacing.sMd,
        vertical: spacing.sSm,
      ),
      decoration: BoxDecoration(
        color: semantic.errorSurface,
        borderRadius: BorderRadius.circular(radius.rSm),
        border: Border.all(
          color: semantic.error.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline_rounded,
            color: semantic.error,
            size: 20,
          ),
          SizedBox(width: spacing.sSm),
          Expanded(
            child: Text(
              errorMessage,
              style: typography.bodyMedium.copyWith(
                color: semantic.error,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCredentialField({
    required AppLoginConfig config,
    required SemanticColors semantic,
    required AppColors raw,
    required AppTypography typography,
    required AppSpacing spacing,
    required BorderRadius borderRadius,
    required bool isRtl,
  }) {
    final isFieldEnabled = widget.enabled && !widget.isLoading;
    final effectiveKeyboardType = config.credentialKeyboardType ??
        _resolveKeyboardType(config.credentialType);

    final effectivePrefix = config.credentialPrefix ??
        _defaultCredentialIcon(config.credentialType, semantic.textSecondary);

    return TextFormField(
      key: const Key('login_identifier_field'),
      controller: _effectiveIdentifierController,
      focusNode: _effectiveIdentifierFocusNode,
      enabled: isFieldEnabled,
      keyboardType: effectiveKeyboardType,
      textInputAction: TextInputAction.next,
      autofillHints: _resolveAutofillHints(config.credentialType),
      style: typography.bodyLarge.copyWith(color: semantic.textPrimary),
      validator: widget.identifierValidator ??
          (val) => _defaultIdentifierValidator(val, isRtl),
      decoration: InputDecoration(
        labelText: config.getEffectiveCredentialLabel(isRtl: isRtl),
        hintText: config.getEffectiveCredentialHint(isRtl: isRtl),
        labelStyle: typography.bodyMedium.copyWith(
          color: isFieldEnabled
              ? semantic.textSecondary
              : semantic.textDisabled,
        ),
        hintStyle: typography.bodyMedium.copyWith(
          color: semantic.textDisabled,
        ),
        prefixIcon: effectivePrefix,
        suffixIcon: config.credentialSuffix,
        filled: true,
        fillColor:
            isFieldEnabled ? semantic.surfaceSubtle : semantic.disabledSurface,
        contentPadding: EdgeInsets.symmetric(
          horizontal: spacing.sMd,
          vertical: 14.0,
        ),
        border: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: semantic.borderSubtle),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: semantic.borderSubtle),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: raw.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: semantic.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: semantic.error, width: 1.5),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: semantic.borderSubtle),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required AppLoginConfig config,
    required SemanticColors semantic,
    required AppColors raw,
    required AppTypography typography,
    required AppSpacing spacing,
    required BorderRadius borderRadius,
    required bool isRtl,
  }) {
    final isFieldEnabled = widget.enabled && !widget.isLoading;

    final toggleSemantics = _obscurePassword
        ? (isRtl ? 'إظهار كلمة المرور' : 'Show password')
        : (isRtl ? 'إخفاء كلمة المرور' : 'Hide password');

    return TextFormField(
      key: const Key('login_password_field'),
      controller: _effectivePasswordController,
      focusNode: _effectivePasswordFocusNode,
      enabled: isFieldEnabled,
      obscureText: _obscurePassword,
      textInputAction: TextInputAction.done,
      autofillHints: const [AutofillHints.password],
      onFieldSubmitted: (_) => _submit(),
      style: typography.bodyLarge.copyWith(color: semantic.textPrimary),
      validator: widget.passwordValidator ??
          (val) => _defaultPasswordValidator(val, isRtl),
      decoration: InputDecoration(
        labelText: config.passwordLabel ?? (isRtl ? 'كلمة المرور' : 'Password'),
        hintText: config.passwordHint,
        labelStyle: typography.bodyMedium.copyWith(
          color: isFieldEnabled
              ? semantic.textSecondary
              : semantic.textDisabled,
        ),
        hintStyle: typography.bodyMedium.copyWith(
          color: semantic.textDisabled,
        ),
        prefixIcon: Icon(
          Icons.lock_outline_rounded,
          color: semantic.textSecondary,
        ),
        suffixIcon: Semantics(
          label: toggleSemantics,
          button: true,
          child: IconButton(
            key: const Key('login_password_visibility_button'),
            icon: Icon(
              _obscurePassword
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: semantic.textSecondary,
            ),
            onPressed: isFieldEnabled
                ? () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  }
                : null,
          ),
        ),
        filled: true,
        fillColor:
            isFieldEnabled ? semantic.surfaceSubtle : semantic.disabledSurface,
        contentPadding: EdgeInsets.symmetric(
          horizontal: spacing.sMd,
          vertical: 14.0,
        ),
        border: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: semantic.borderSubtle),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: semantic.borderSubtle),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: raw.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: semantic.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: semantic.error, width: 1.5),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: semantic.borderSubtle),
        ),
      ),
    );
  }

  Widget _buildForgotPasswordButton({
    required AppLoginConfig config,
    required AppColors raw,
    required SemanticColors semantic,
    required AppTypography typography,
    required AppDimensions dimensions,
    required bool isRtl,
  }) {
    final isActionEnabled = widget.enabled && !widget.isLoading;
    final label = config.forgotPasswordLabel ??
        (isRtl ? 'هل نسيت كلمة المرور؟' : 'Forgot password?');

    return TextButton(
      key: const Key('login_forgot_password_button'),
      onPressed: isActionEnabled ? widget.onForgotPassword : null,
      style: TextButton.styleFrom(
        minimumSize: Size(0, dimensions.touchTargetMin),
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        label,
        style: typography.bodySmall.copyWith(
          color: isActionEnabled ? raw.primary : semantic.textDisabled,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildLoginButton({
    required AppLoginConfig config,
    required AppColors raw,
    required SemanticColors semantic,
    required AppTypography typography,
    required BorderRadius borderRadius,
    required bool isRtl,
  }) {
    final isActionEnabled = widget.enabled && !widget.isLoading;
    final label = config.loginButtonLabel ?? (isRtl ? 'تسجيل الدخول' : 'Sign In');

    return SizedBox(
      height: config.buttonHeight,
      child: ElevatedButton(
        key: const Key('login_submit_button'),
        onPressed: isActionEnabled ? _submit : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: raw.primary,
          disabledBackgroundColor: semantic.disabledSurface,
          foregroundColor: semantic.textInverse,
          disabledForegroundColor: semantic.textDisabled,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
          ),
        ),
        child: widget.isLoading
            ? SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    semantic.textInverse,
                  ),
                ),
              )
            : Text(
                label,
                style: typography.titleMedium.copyWith(
                  color: isActionEnabled
                      ? semantic.textInverse
                      : semantic.textDisabled,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }

  Widget _buildSignUpSection({
    required AppLoginConfig config,
    required AppColors raw,
    required SemanticColors semantic,
    required AppTypography typography,
    required AppSpacing spacing,
    required bool isRtl,
  }) {
    final isActionEnabled = widget.enabled && !widget.isLoading;
    final prompt =
        config.signUpPrompt ?? (isRtl ? 'ليس لديك حساب؟' : "Don't have an account?");
    final label = config.signUpLabel ?? (isRtl ? 'إنشاء حساب جديد' : 'Sign up');

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          prompt,
          style: typography.bodyMedium.copyWith(
            color: semantic.textSecondary,
          ),
        ),
        SizedBox(width: spacing.sXs),
        GestureDetector(
          key: const Key('login_signup_button'),
          onTap: isActionEnabled ? widget.onSignUp : null,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: spacing.sXs,
              horizontal: spacing.sXxs,
            ),
            child: Text(
              label,
              style: typography.bodyMedium.copyWith(
                color: isActionEnabled ? raw.primary : semantic.textDisabled,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDivider({
    required AppLoginConfig config,
    required SemanticColors semantic,
    required AppTypography typography,
    required AppSpacing spacing,
    required bool isRtl,
  }) {
    final dividerText = config.dividerText ??
        (isRtl ? 'أو قم بتسجيل الدخول باستخدام' : 'Or sign in with');

    return Row(
      children: [
        Expanded(
          child: Divider(
            color: semantic.divider,
            thickness: 1,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: spacing.sMd),
          child: Text(
            dividerText,
            style: typography.bodySmall.copyWith(
              color: semantic.textSecondary,
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: semantic.divider,
            thickness: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required Key key,
    required String label,
    required Widget icon,
    required VoidCallback? onTap,
    required AppLoginConfig config,
    required SemanticColors semantic,
    required AppTypography typography,
    required BorderRadius borderRadius,
    required AppSpacing spacing,
  }) {
    final isActionEnabled = onTap != null;

    return SizedBox(
      height: config.socialButtonHeight,
      child: OutlinedButton(
        key: key,
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: semantic.surface,
          disabledBackgroundColor: semantic.disabledSurface.withValues(alpha: 0.5),
          side: BorderSide(
            color: isActionEnabled ? semantic.border : semantic.borderSubtle,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            SizedBox(width: spacing.sSm),
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: typography.titleSmall.copyWith(
                  color: isActionEnabled
                      ? semantic.textPrimary
                      : semantic.textDisabled,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextInputType _resolveKeyboardType(LoginCredentialType type) {
    switch (type) {
      case LoginCredentialType.email:
        return TextInputType.emailAddress;
      case LoginCredentialType.phone:
        return TextInputType.phone;
      case LoginCredentialType.phoneOrEmail:
        return TextInputType.emailAddress;
    }
  }

  List<String>? _resolveAutofillHints(LoginCredentialType type) {
    switch (type) {
      case LoginCredentialType.email:
        return const [AutofillHints.email];
      case LoginCredentialType.phone:
        return const [AutofillHints.telephoneNumber];
      case LoginCredentialType.phoneOrEmail:
        return const [AutofillHints.username];
    }
  }

  Widget _defaultCredentialIcon(LoginCredentialType type, Color color) {
    switch (type) {
      case LoginCredentialType.email:
        return Icon(Icons.alternate_email_rounded, color: color);
      case LoginCredentialType.phone:
        return Icon(Icons.phone_outlined, color: color);
      case LoginCredentialType.phoneOrEmail:
        return Icon(Icons.person_outline_rounded, color: color);
    }
  }

  String? _defaultIdentifierValidator(String? value, bool isRtl) {
    if (value == null || value.trim().isEmpty) {
      return isRtl ? 'هذا الحقل مطلوب' : 'This field is required';
    }
    return null;
  }

  String? _defaultPasswordValidator(String? value, bool isRtl) {
    if (value == null || value.isEmpty) {
      return isRtl
          ? 'كلمة المرور مطلوبة'
          : 'Password is required';
    }
    return null;
  }
}

/// Self-contained, brand-accurate vector Google "G" logo painter.
class _GoogleVectorLogo extends StatelessWidget {
  final double size;

  const _GoogleVectorLogo({this.size = 24.0});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: const _GoogleLogoPainter(),
    );
  }
}

class _GoogleLogoPainter extends CustomPainter {
  const _GoogleLogoPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final double s = size.width;
    final double center = s / 2;
    final double radius = s * 0.45;
    final double strokeWidth = s * 0.19;

    final rect = Rect.fromCircle(center: Offset(center, center), radius: radius);

    final paintBlue = Paint()
      ..color = const Color(0xFF4285F4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    final paintGreen = Paint()
      ..color = const Color(0xFF34A853)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    final paintYellow = Paint()
      ..color = const Color(0xFFFBBC05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    final paintRed = Paint()
      ..color = const Color(0xFFEA4335)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    // Blue arc (top-right and bar)
    canvas.drawArc(rect, -math.pi / 4, math.pi / 4 + 0.1, false, paintBlue);

    // Green arc (bottom-right to bottom)
    canvas.drawArc(rect, 0, math.pi / 2, false, paintGreen);

    // Yellow arc (bottom-left)
    canvas.drawArc(rect, math.pi / 2, math.pi / 2, false, paintYellow);

    // Red arc (top-left)
    canvas.drawArc(rect, math.pi, math.pi * 3 / 4, false, paintRed);

    // Google horizontal bar
    final barPaint = Paint()
      ..color = const Color(0xFF4285F4)
      ..style = PaintingStyle.fill;

    final barRect = Rect.fromLTRB(
      center - (strokeWidth * 0.1),
      center - (strokeWidth / 2),
      center + radius + (strokeWidth / 2),
      center + (strokeWidth / 2),
    );
    canvas.drawRect(barRect, barPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Self-contained, brand-accurate vector Facebook "f" logo.
class _FacebookVectorLogo extends StatelessWidget {
  final double size;

  const _FacebookVectorLogo({this.size = 24.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Color(0xFF1877F2),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        'f',
        style: TextStyle(
          color: Colors.white,
          fontSize: size * 0.72,
          fontWeight: FontWeight.bold,
          fontFamily: 'sans-serif',
          height: 1.0,
        ),
      ),
    );
  }
}
