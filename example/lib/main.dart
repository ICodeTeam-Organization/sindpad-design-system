import 'package:flutter/material.dart';
import 'package:sindpad_design_system/sindpad_design_system.dart';

void main() {
  runApp(const SindpadPreviewApp());
}

class SindpadPreviewApp extends StatefulWidget {
  const SindpadPreviewApp({super.key});

  @override
  State<SindpadPreviewApp> createState() => _SindpadPreviewAppState();
}

class _SindpadPreviewAppState extends State<SindpadPreviewApp> {
  ThemeMode _themeMode = ThemeMode.light;
  int _currentTab = 0;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sindpad Design System Preview',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: _themeMode,
      home: Scaffold(
        body: IndexedStack(
          index: _currentTab,
          children: [
            FoundationPreviewScreen(
              onToggleTheme: _toggleTheme,
              isDarkMode: _themeMode == ThemeMode.dark,
            ),
            LoginPreviewScreen(
              onToggleTheme: _toggleTheme,
              isDarkMode: _themeMode == ThemeMode.dark,
            ),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _currentTab,
          onDestinationSelected: (index) {
            setState(() {
              _currentTab = index;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.palette_outlined),
              selectedIcon: Icon(Icons.palette),
              label: 'Foundations',
            ),
            NavigationDestination(
              icon: Icon(Icons.login_outlined),
              selectedIcon: Icon(Icons.login),
              label: 'Login Form',
            ),
          ],
        ),
      ),
    );
  }
}

class FoundationPreviewScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final bool isDarkMode;

  const FoundationPreviewScreen({
    super.key,
    required this.onToggleTheme,
    required this.isDarkMode,
  });

  @override
  State<FoundationPreviewScreen> createState() => _FoundationPreviewScreenState();
}

class _FoundationPreviewScreenState extends State<FoundationPreviewScreen> {
  bool _motionExpanded = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.sindpadColors;
    final typography = context.sindpadTypography;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sindpad Design System',
              style: typography.titleLarge.copyWith(
                fontWeight: FontWeight.bold,
                color: colors.textPrimary,
              ),
            ),
            Text(
              'Foundation Preview',
              style: typography.bodySmall.copyWith(
                color: colors.textSecondary,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              widget.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            tooltip: 'Toggle Theme',
            onPressed: widget.onToggleTheme,
          ),
          const SizedBox(width: AppSpacing.sm),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          _buildIntroBanner(context),
          const SizedBox(height: AppSpacing.lg),
          _buildSectionHeader(context, '1. Colors', 'Raw palettes and semantic tokens'),
          _buildColorsPreview(context),
          const SizedBox(height: AppSpacing.lg),
          _buildSectionHeader(context, '2. Typography', 'Type scale and font hierarchy'),
          _buildTypographyPreview(context),
          const SizedBox(height: AppSpacing.lg),
          _buildSectionHeader(context, '3. Spacing', 'Scale from xxs (2px) to xxxl (64px)'),
          _buildSpacingPreview(context),
          const SizedBox(height: AppSpacing.lg),
          _buildSectionHeader(context, '4. Radius', 'Border radius presets from none to full'),
          _buildRadiusPreview(context),
          const SizedBox(height: AppSpacing.lg),
          _buildSectionHeader(context, '5. Shadows', 'Elevation tiers from none to lg'),
          _buildShadowsPreview(context),
          const SizedBox(height: AppSpacing.lg),
          _buildSectionHeader(context, '6. Dimensions', 'Icon sizing and touch target accessibility'),
          _buildDimensionsPreview(context),
          const SizedBox(height: AppSpacing.lg),
          _buildSectionHeader(context, '7. Motion', 'Durations and animation curves'),
          _buildMotionPreview(context),
          const SizedBox(height: AppSpacing.xxl),
        ],
      ),
    );
  }

  Widget _buildIntroBanner(BuildContext context) {
    final colors = context.sindpadColors;
    final typography = context.sindpadTypography;
    final radius = context.sindpadRadius;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.surfaceSubtle,
        borderRadius: radius.asBorderRadius(radius.rMd),
        border: Border.all(color: colors.borderSubtle),
      ),
      child: Text(
        'This playground displays the design system primitives (tokens) shared across 7 Sindpad applications. '
        'Components will be layered on top of these foundations.',
        style: typography.bodyMedium.copyWith(color: colors.textSecondary),
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title,
    String subtitle,
  ) {
    final colors = context.sindpadColors;
    final typography = context.sindpadTypography;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: typography.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            subtitle,
            style: typography.bodySmall.copyWith(color: colors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildColorsPreview(BuildContext context) {
    final semantic = context.sindpadColors;
    final raw = context.sindpadRawColors;

    final colorCards = [
      ('Primary', raw.primary),
      ('Secondary', raw.secondary),
      ('Accent', raw.accent),
      ('Background', semantic.background),
      ('Surface', semantic.surface),
      ('Surface Subtle', semantic.surfaceSubtle),
      ('Text Primary', semantic.textPrimary),
      ('Text Secondary', semantic.textSecondary),
      ('Border', semantic.border),
      ('Success', semantic.success),
      ('Warning', semantic.warning),
      ('Error', semantic.error),
      ('Info', semantic.info),
      ('Disabled', semantic.disabled),
    ];

    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: colorCards.map((item) {
        return _buildColorChip(context, item.$1, item.$2);
      }).toList(),
    );
  }

  Widget _buildColorChip(BuildContext context, String label, Color color) {
    final colors = context.sindpadColors;
    final typography = context.sindpadTypography;
    final radius = context.sindpadRadius;

    final hex = '#${color.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase().substring(2)}';

    return Container(
      width: 140,
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: radius.asBorderRadius(radius.rSm),
        border: Border.all(color: colors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 48,
            decoration: BoxDecoration(
              color: color,
              borderRadius: radius.asBorderRadius(radius.rXs),
              border: Border.all(color: colors.borderSubtle),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            label,
            style: typography.labelMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: colors.textPrimary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            hex,
            style: typography.caption.copyWith(color: colors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildTypographyPreview(BuildContext context) {
    final typography = context.sindpadTypography;
    final colors = context.sindpadColors;
    final radius = context.sindpadRadius;

    final samples = [
      ('Display Large', typography.displayLarge),
      ('Headline Medium', typography.headlineMedium),
      ('Title Large', typography.titleLarge),
      ('Title Medium', typography.titleMedium),
      ('Body Large', typography.bodyLarge),
      ('Body Medium', typography.bodyMedium),
      ('Label Large', typography.labelLarge),
      ('Caption', typography.caption),
    ];

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: radius.asBorderRadius(radius.rMd),
        border: Border.all(color: colors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: samples.map((sample) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                SizedBox(
                  width: 120,
                  child: Text(
                    sample.$1,
                    style: typography.caption.copyWith(color: colors.textSecondary),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Sindpad Design',
                    style: sample.$2.copyWith(color: colors.textPrimary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSpacingPreview(BuildContext context) {
    final colors = context.sindpadColors;
    final typography = context.sindpadTypography;
    final radius = context.sindpadRadius;

    final spacings = [
      ('xxs', AppSpacing.xxs),
      ('xs', AppSpacing.xs),
      ('sm', AppSpacing.sm),
      ('md', AppSpacing.md),
      ('lg', AppSpacing.lg),
      ('xl', AppSpacing.xl),
      ('xxl', AppSpacing.xxl),
      ('xxxl', AppSpacing.xxxl),
    ];

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: radius.asBorderRadius(radius.rMd),
        border: Border.all(color: colors.borderSubtle),
      ),
      child: Column(
        children: spacings.map((s) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
            child: Row(
              children: [
                SizedBox(
                  width: 60,
                  child: Text(
                    s.$1,
                    style: typography.labelMedium.copyWith(color: colors.textPrimary),
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: Text(
                    '${s.$2.toInt()}px',
                    style: typography.caption.copyWith(color: colors.textSecondary),
                  ),
                ),
                Container(
                  height: 16,
                  width: s.$2 * 2,
                  decoration: BoxDecoration(
                    color: colors.info,
                    borderRadius: radius.asBorderRadius(radius.rXs),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildRadiusPreview(BuildContext context) {
    final colors = context.sindpadColors;
    final raw = context.sindpadRawColors;
    final typography = context.sindpadTypography;
    final radius = context.sindpadRadius;

    final radii = [
      ('none (0)', radius.rNone),
      ('xs (2)', radius.rXs),
      ('sm (4)', radius.rSm),
      ('md (8)', radius.rMd),
      ('lg (12)', radius.rLg),
      ('xl (16)', radius.rXl),
      ('full (9999)', radius.rFull),
    ];

    return Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.md,
      children: radii.map((r) {
        return Column(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: colors.surfaceSubtle,
                borderRadius: radius.asBorderRadius(r.$2),
                border: Border.all(color: raw.primary, width: 2),
              ),
              alignment: Alignment.center,
              child: Text(
                r.$1.split(' ')[0],
                style: typography.labelSmall.copyWith(color: colors.textPrimary),
              ),
            ),
            const SizedBox(height: AppSpacing.xxs),
            Text(
              '${r.$2.toInt()}px',
              style: typography.caption.copyWith(color: colors.textSecondary),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildShadowsPreview(BuildContext context) {
    final colors = context.sindpadColors;
    final typography = context.sindpadTypography;
    final shadows = context.sindpadShadows;
    final radius = context.sindpadRadius;

    final tiers = [
      ('none', shadows.none),
      ('sm', shadows.sm),
      ('md', shadows.md),
      ('lg', shadows.lg),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: tiers.map((tier) {
        return Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: radius.asBorderRadius(radius.rMd),
            boxShadow: tier.$2,
          ),
          alignment: Alignment.center,
          child: Text(
            tier.$1,
            style: typography.labelMedium.copyWith(color: colors.textPrimary),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDimensionsPreview(BuildContext context) {
    final colors = context.sindpadColors;
    final raw = context.sindpadRawColors;
    final typography = context.sindpadTypography;
    final dims = context.sindpadDimensions;
    final radius = context.sindpadRadius;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: radius.asBorderRadius(radius.rMd),
        border: Border.all(color: colors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Icon Sizes:',
            style: typography.labelLarge.copyWith(color: colors.textPrimary),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Icon(Icons.star, size: dims.iconSizeXs, color: raw.primary),
              const SizedBox(width: AppSpacing.md),
              Icon(Icons.star, size: dims.iconSizeSm, color: raw.primary),
              const SizedBox(width: AppSpacing.md),
              Icon(Icons.star, size: dims.iconSizeMd, color: raw.primary),
              const SizedBox(width: AppSpacing.md),
              Icon(Icons.star, size: dims.iconSizeLg, color: raw.primary),
              const SizedBox(width: AppSpacing.md),
              Icon(Icons.star, size: dims.iconSizeXl, color: raw.primary),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Accessibility Touch Target Minimum (${dims.touchTargetMin.toInt()}x${dims.touchTargetMin.toInt()} dp):',
            style: typography.labelLarge.copyWith(color: colors.textPrimary),
          ),
          const SizedBox(height: AppSpacing.sm),
          Container(
            width: dims.touchTargetMin,
            height: dims.touchTargetMin,
            decoration: BoxDecoration(
              border: Border.all(color: colors.error, width: 2),
              borderRadius: radius.asBorderRadius(radius.rSm),
              color: colors.errorSurface,
            ),
            alignment: Alignment.center,
            child: Text(
              '48dp',
              style: typography.caption.copyWith(color: colors.error),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMotionPreview(BuildContext context) {
    final colors = context.sindpadColors;
    final raw = context.sindpadRawColors;
    final typography = context.sindpadTypography;
    final motion = context.sindpadMotion;
    final radius = context.sindpadRadius;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: radius.asBorderRadius(radius.rMd),
        border: Border.all(color: colors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                _motionExpanded = !_motionExpanded;
              });
            },
            child: Text(_motionExpanded ? 'Reset Animation' : 'Trigger Motion (${motion.normalDuration.inMilliseconds}ms)'),
          ),
          const SizedBox(height: AppSpacing.md),
          AnimatedContainer(
            duration: motion.normalDuration,
            curve: motion.standardCurve,
            width: _motionExpanded ? 240 : 100,
            height: 48,
            decoration: BoxDecoration(
              color: raw.primary,
              borderRadius: radius.asBorderRadius(
                _motionExpanded ? radius.rFull : radius.rSm,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              _motionExpanded ? 'Expanded' : 'Normal',
              style: typography.labelMedium.copyWith(color: colors.textInverse),
            ),
          ),
        ],
      ),
    );
  }
}

enum _LoginDemoState { normal, loading, error }

class LoginPreviewScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final bool isDarkMode;

  const LoginPreviewScreen({
    super.key,
    required this.onToggleTheme,
    required this.isDarkMode,
  });

  @override
  State<LoginPreviewScreen> createState() => _LoginPreviewScreenState();
}

class _LoginPreviewScreenState extends State<LoginPreviewScreen> {
  bool _isArabic = true;
  _LoginDemoState _demoState = _LoginDemoState.normal;
  LoginCredentialType _credentialType = LoginCredentialType.phoneOrEmail;
  bool _showSocial = true;
  bool _showForgot = true;
  bool _showSignUp = true;

  void _showNotification(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.sindpadColors;
    final typography = context.sindpadTypography;
    final raw = context.sindpadRawColors;

    final baseConfig = _isArabic
        ? const AppLoginConfig.arabic()
        : const AppLoginConfig.english();

    final config = baseConfig.copyWith(
      credentialType: _credentialType,
      showSocialLogin: _showSocial,
      showForgotPassword: _showForgot,
      showSignUp: _showSignUp,
      logo: Container(
        color: raw.primary,
        child: const Icon(
          Icons.storefront_rounded,
          color: Colors.white,
          size: 36,
        ),
      ),
      footer: Padding(
        padding: const EdgeInsets.only(top: AppSpacing.md),
        child: Text(
          _isArabic
              ? 'الإصدار v1.0.0 • مجموعة سندباد'
              : 'Version v1.0.0 • Sindpad Organization',
          style: typography.caption.copyWith(color: colors.textSecondary),
        ),
      ),
    );

    final errorMessage = _demoState == _LoginDemoState.error
        ? (_isArabic
            ? 'اسم المستخدم أو كلمة المرور غير صحيحة. يرجى المحاولة مرة أخرى.'
            : 'Invalid credentials. Please verify your details and try again.')
        : null;

    return Directionality(
      textDirection: _isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            _isArabic ? 'معاينة شاشة الدخول' : 'Login Form Preview',
            style: typography.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: colors.textPrimary,
            ),
          ),
          actions: [
            TextButton.icon(
              onPressed: () {
                setState(() {
                  _isArabic = !_isArabic;
                });
              },
              icon: const Icon(Icons.language, size: 18),
              label: Text(_isArabic ? 'English' : 'عربي'),
            ),
            IconButton(
              icon: Icon(
                widget.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              ),
              tooltip: 'Toggle Theme',
              onPressed: widget.onToggleTheme,
            ),
            const SizedBox(width: AppSpacing.xs),
          ],
        ),
        body: Column(
          children: [
            _buildControlBar(context),
            Expanded(
              child: AppLoginForm(
                config: config,
                isLoading: _demoState == _LoginDemoState.loading,
                errorMessage: errorMessage,
                onLogin: (credentials) {
                  _showNotification(
                    _isArabic
                        ? 'تم تسجيل الدخول: ${credentials.identifier}'
                        : 'Login credentials submitted: ${credentials.identifier}',
                  );
                },
                onForgotPassword: () {
                  _showNotification(
                    _isArabic
                        ? 'انتقال إلى استعادة كلمة المرور (/forgot-password)'
                        : 'Navigating to: /forgot-password',
                  );
                },
                onSignUp: () {
                  _showNotification(
                    _isArabic
                        ? 'انتقال إلى إنشاء حساب جديد (/signup)'
                        : 'Navigating to: /signup',
                  );
                },
                onGoogleLogin: () {
                  _showNotification('Google Sign-In Triggered');
                },
                onFacebookLogin: () {
                  _showNotification('Facebook Sign-In Triggered');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlBar(BuildContext context) {
    final colors = context.sindpadColors;
    final typography = context.sindpadTypography;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: colors.surfaceSubtle,
        border: Border(
          bottom: BorderSide(color: colors.borderSubtle),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Text(
              _isArabic ? 'الحالة:' : 'State:',
              style: typography.labelSmall.copyWith(color: colors.textSecondary),
            ),
            const SizedBox(width: AppSpacing.xs),
            SegmentedButton<_LoginDemoState>(
              segments: [
                ButtonSegment(
                  value: _LoginDemoState.normal,
                  label: Text(_isArabic ? 'عادية' : 'Normal'),
                ),
                ButtonSegment(
                  value: _LoginDemoState.loading,
                  label: Text(_isArabic ? 'تحميل' : 'Loading'),
                ),
                ButtonSegment(
                  value: _LoginDemoState.error,
                  label: Text(_isArabic ? 'خطأ' : 'Error'),
                ),
              ],
              selected: {_demoState},
              onSelectionChanged: (selected) {
                setState(() {
                  _demoState = selected.first;
                });
              },
            ),
            const SizedBox(width: AppSpacing.md),
            Text(
              _isArabic ? 'نوع المعرف:' : 'Credential:',
              style: typography.labelSmall.copyWith(color: colors.textSecondary),
            ),
            const SizedBox(width: AppSpacing.xs),
            DropdownButton<LoginCredentialType>(
              value: _credentialType,
              underline: const SizedBox(),
              items: [
                DropdownMenuItem(
                  value: LoginCredentialType.phoneOrEmail,
                  child: Text(
                    _isArabic ? 'هاتف أو إيميل' : 'Phone or Email',
                    style: typography.bodySmall,
                  ),
                ),
                DropdownMenuItem(
                  value: LoginCredentialType.email,
                  child: Text(
                    _isArabic ? 'إيميل فقط' : 'Email Only',
                    style: typography.bodySmall,
                  ),
                ),
                DropdownMenuItem(
                  value: LoginCredentialType.phone,
                  child: Text(
                    _isArabic ? 'هاتف فقط' : 'Phone Only',
                    style: typography.bodySmall,
                  ),
                ),
              ],
              onChanged: (val) {
                if (val != null) {
                  setState(() {
                    _credentialType = val;
                  });
                }
              },
            ),
            const SizedBox(width: AppSpacing.sm),
            FilterChip(
              label: Text(_isArabic ? 'دخول اجتماعي' : 'Social'),
              selected: _showSocial,
              onSelected: (val) => setState(() => _showSocial = val),
            ),
            const SizedBox(width: AppSpacing.xs),
            FilterChip(
              label: Text(_isArabic ? 'نسيت كلمة المرور' : 'Forgot Password'),
              selected: _showForgot,
              onSelected: (val) => setState(() => _showForgot = val),
            ),
            const SizedBox(width: AppSpacing.xs),
            FilterChip(
              label: Text(_isArabic ? 'إنشاء حساب' : 'Sign Up'),
              selected: _showSignUp,
              onSelected: (val) => setState(() => _showSignUp = val),
            ),
          ],
        ),
      ),
    );
  }
}
