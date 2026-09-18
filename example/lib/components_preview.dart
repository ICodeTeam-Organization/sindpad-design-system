import 'package:flutter/material.dart';
import 'package:sindpad_design_system/sindpad_design_system.dart';

class ComponentsPreviewScreen extends StatelessWidget {
  const ComponentsPreviewScreen({
    super.key,
    required this.onToggleTheme,
    required this.isDarkMode,
  });

  final VoidCallback onToggleTheme;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SindbadAppBar(
        title: 'Components',
        subtitle: 'Reusable component preview',
        showBottomDivider: true,
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            tooltip: 'Toggle Theme',
            onPressed: onToggleTheme,
          ),
          const SizedBox(width: AppSpacing.xs),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          _ComponentSection(
            title: 'Feedback Snackbars',
            description:
                'Tap a button to preview each feedback state from the shared API.',
            child: Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                for (final type in AppSnackBarType.values)
                  FilledButton.tonalIcon(
                    onPressed: () => AppSnackBar.show(
                      context,
                      message: _snackBarMessage(type),
                      type: type,
                    ),
                    icon: Icon(_snackBarIcon(type), size: 18),
                    label: Text(_snackBarLabel(type)),
                  ),
                OutlinedButton.icon(
                  onPressed: () => AppSnackBar.hide(context),
                  icon: const Icon(Icons.close, size: 18),
                  label: const Text('Hide'),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _ComponentSection(
            title: 'Buttons',
            description:
                'Consistent actions with variants, sizes, icons, and loading states.',
            child: Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const AppButton(label: 'Primary', leadingIcon: Icons.check),
                const AppButton(
                  label: 'Secondary',
                  variant: AppButtonVariant.secondary,
                ),
                const AppButton(
                  label: 'Outlined',
                  variant: AppButtonVariant.outlined,
                ),
                const AppButton(
                  label: 'Tonal',
                  variant: AppButtonVariant.tonal,
                ),
                const AppButton(label: 'Text', variant: AppButtonVariant.text),
                const AppButton(
                  label: 'Delete',
                  variant: AppButtonVariant.danger,
                  leadingIcon: Icons.delete_outline,
                ),
                const AppButton(label: 'Small', size: AppButtonSize.small),
                const AppButton(label: 'Large', size: AppButtonSize.large),
                const AppButton(label: 'Saving', isLoading: true),
                AppIconButton(
                  icon: Icons.favorite_border,
                  tooltip: 'Favorite',
                  onPressed: () => AppSnackBar.show(
                    context,
                    message: 'Added to favorites',
                    type: AppSnackBarType.success,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _ComponentSection(
            title: 'Loading Components',
            description:
                'Shared indicators and skeletons for consistent loading experiences.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Wrap(
                  spacing: AppSpacing.lg,
                  runSpacing: AppSpacing.md,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    AppLoader(message: 'Loading'),
                    CircularLoader(size: 32),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                const LinearLoader(value: 0.65),
                const SizedBox(height: AppSpacing.md),
                const Skeleton(width: double.infinity, height: 24),
                const SizedBox(height: AppSpacing.md),
                const SizedBox(
                  height: 280,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: ProductSkeleton()),
                      SizedBox(width: AppSpacing.sm),
                      Expanded(child: CardSkeleton()),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                const ListSkeleton(itemCount: 2),
                const SizedBox(height: AppSpacing.md),
                const SizedBox(
                  height: 120,
                  child: PageLoader(message: 'Loading page...'),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _ComponentSection(
            title: 'Authentication',
            description:
                'A ready-to-configure login form for application auth flows.',
            child: AppLoginForm(
              config: const AppLoginConfig.english(),
              onLogin: (credentials) => AppSnackBar.show(
                context,
                message: 'Login submitted: ${credentials.identifier}',
                type: AppSnackBarType.success,
              ),
              onForgotPassword: () => AppSnackBar.show(
                context,
                message: 'Forgot password selected',
                type: AppSnackBarType.info,
              ),
              onSignUp: () => AppSnackBar.show(
                context,
                message: 'Sign up selected',
                type: AppSnackBarType.info,
              ),
              onGoogleLogin: () => SignInSnackBar.show(
                context,
                message: 'Continue with Google',
                buttonText: 'Sign in',
              ),
              onFacebookLogin: () => SignInSnackBar.show(
                context,
                message: 'Continue with Facebook',
                buttonText: 'Sign in',
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _ComponentSection(
            title: 'Empty State',
            description: 'Use when a screen has no content to display yet.',
            child: const SizedBox(
              height: 280,
              child: AppEmptyWidget(
                title: 'No projects yet',
                message: 'Create your first project to see it here.',
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _ComponentSection(
            title: 'Loading State',
            description: 'Use while waiting for a request or async operation.',
            child: const SizedBox(
              height: 220,
              child: AppWaitingWidget(message: 'Loading projects...'),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _ComponentSection(
            title: 'Error State',
            description:
                'Use when content cannot be loaded or an operation fails.',
            child: const SizedBox(
              height: 300,
              child: AppErrorWidget(
                title: 'Unable to load projects',
                message: 'Check your connection and try again.',
              ),
            ),
          ),
          _ComponentSection(
            title: 'Navigation & Drawers',
            description:
                'Interactive drawer with account info, customizable quick actions, theme toggle, and language selector.',
            child: Builder(
              builder: (ctx) => Wrap(
                spacing: AppSpacing.sm,
                children: [
                  FilledButton.icon(
                    onPressed: () => Scaffold.of(ctx).openDrawer(),
                    icon: const Icon(Icons.menu),
                    label: const Text('Open SindbadDrawer'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _ComponentSection(
            title: 'About App Modal',
            description:
                'Theme-adaptive bottom sheet displaying app metadata, version diagnostics, and organization attribution.',
            child: Wrap(
              spacing: AppSpacing.sm,
              children: [
                FilledButton.tonalIcon(
                  onPressed: () {
                    SindbadAboutAppModal.show(
                      context: context,
                      appName: 'متجر سندباد',
                      appSubtitle: 'نظام إدارة المبيعات والتوزيع',
                      version: '2.3.0 (build 118)',
                      systemInfo: 'Flutter 3.29 • Android 14',
                      companyName: 'مجموعة سندباد للحلول الرقمية',
                      copyright: '© 2026 جميع الحقوق محفوظة لشركة سندباد',
                      closeButtonText: 'إغلاق',
                    );
                  },
                  icon: const Icon(Icons.info_outline),
                  label: const Text('Show About App Modal'),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          const SizedBox(height: AppSpacing.xxl),
        ],
      ),
      drawer: SindbadDrawer(
        userName: 'أحمد المحمود',
        subtitle: 'مدير المتجر • فرع النرجس',
        info: const [
          SindbadDrawerInfo(
            label: 'رقم الهاتف',
            value: '+966 55 123 4567',
            icon: Icons.phone_android,
          ),
          SindbadDrawerInfo(
            label: 'البريد',
            value: 'ahmed@sindbad.com',
            icon: Icons.email_outlined,
          ),
          SindbadDrawerInfo(
            label: 'الفرع',
            value: 'الرياض - النرجس',
            icon: Icons.store_mall_directory_outlined,
          ),
        ],
        actions: [
          SindbadDrawerAction(
            title: 'لوحة التحكم والتقارير',
            icon: Icons.dashboard_outlined,
            onTap: () => AppSnackBar.show(
              context,
              message: 'تم اختيار لوحة التحكم',
              type: AppSnackBarType.info,
            ),
          ),
          SindbadDrawerAction(
            title: 'إدارة المخزون والمنتجات',
            icon: Icons.inventory_2_outlined,
            onTap: () => AppSnackBar.show(
              context,
              message: 'تم اختيار إدارة المنتجات',
              type: AppSnackBarType.info,
            ),
          ),
          SindbadDrawerAction(
            title: 'حول التطبيق',
            icon: Icons.info_outline,
            onTap: () {
              Navigator.pop(context);
              SindbadAboutAppModal.show(
                context: context,
                appName: 'متجر سندباد',
                appSubtitle: 'نظام إدارة المبيعات والتوزيع',
                version: '2.3.0 (build 118)',
                systemInfo: 'Flutter 3.29 • Android 14',
                companyName: 'مجموعة سندباد للحلول الرقمية',
                copyright: '© 2026 جميع الحقوق محفوظة لشركة سندباد',
              );
            },
          ),
        ],
        version: '2.3.0',
        versionFooterText: 'سندباد',
        isDarkMode: isDarkMode,
        onThemeChanged: (_) => onToggleTheme(),
        onVersionTap: () => AppSnackBar.show(
          context,
          message: 'Sindbad Design System v2.3.0 (Verified)',
          type: AppSnackBarType.success,
        ),
      ),
    );
  }

  static String _snackBarLabel(AppSnackBarType type) {
    return switch (type) {
      AppSnackBarType.success => 'Success',
      AppSnackBarType.error => 'Error',
      AppSnackBarType.warning => 'Warning',
      AppSnackBarType.info => 'Info',
      AppSnackBarType.loading => 'Loading',
      AppSnackBarType.defaultMessage => 'Default',
    };
  }

  static String _snackBarMessage(AppSnackBarType type) {
    return switch (type) {
      AppSnackBarType.success => 'Operation completed successfully.',
      AppSnackBarType.error => 'Something went wrong.',
      AppSnackBarType.warning => 'Please review this caution.',
      AppSnackBarType.info => 'This is general information.',
      AppSnackBarType.loading => 'Operation in progress...',
      AppSnackBarType.defaultMessage => 'A neutral message.',
    };
  }

  static IconData _snackBarIcon(AppSnackBarType type) {
    return switch (type) {
      AppSnackBarType.success => Icons.check_circle_outline,
      AppSnackBarType.error => Icons.error_outline,
      AppSnackBarType.warning => Icons.warning_amber_outlined,
      AppSnackBarType.info => Icons.info_outline,
      AppSnackBarType.loading => Icons.hourglass_top,
      AppSnackBarType.defaultMessage => Icons.chat_bubble_outline,
    };
  }
}

class _ComponentSection extends StatelessWidget {
  const _ComponentSection({
    required this.title,
    required this.description,
    required this.child,
  });

  final String title;
  final String description;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = context.sindpadColors;
    final typography = context.sindpadTypography;

    return Column(
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
          description,
          style: typography.bodySmall.copyWith(color: colors.textSecondary),
        ),
        const SizedBox(height: AppSpacing.sm),
        child,
      ],
    );
  }
}
