import 'package:flutter/material.dart';

/// Visual variants supported by [AppButton].
enum AppButtonVariant {
  /// The main action on a surface.
  primary,

  /// A lower-emphasis action using the secondary brand color.
  secondary,

  /// An action with a visible outline and transparent fill.
  outlined,

  /// A lower-emphasis filled action.
  tonal,

  /// A text-only action.
  text,

  /// A destructive action such as delete or remove.
  danger,
}

/// Standard sizes supported by [AppButton].
enum AppButtonSize { small, medium, large }

/// A theme-aware button with consistent sizing, variants, and loading behavior.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.medium,
    this.leadingIcon,
    this.trailingIcon,
    this.isLoading = false,
    this.expand = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final bool isLoading;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final metrics = _ButtonMetrics.from(size);
    final style = _buttonStyle(theme, metrics);
    final content = _content(theme, metrics);

    final button = switch (variant) {
      AppButtonVariant.outlined => OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: style,
        child: content,
      ),
      AppButtonVariant.text => TextButton(
        onPressed: isLoading ? null : onPressed,
        style: style,
        child: content,
      ),
      _ => FilledButton(
        onPressed: isLoading ? null : onPressed,
        style: style,
        child: content,
      ),
    };

    return expand ? SizedBox(width: double.infinity, child: button) : button;
  }

  Widget _content(ThemeData theme, _ButtonMetrics metrics) {
    if (isLoading) {
      return SizedBox.square(
        dimension: metrics.iconSize,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: _foregroundColor(theme),
        ),
      );
    }

    final children = <Widget>[];
    if (leadingIcon != null) {
      children.add(Icon(leadingIcon, size: metrics.iconSize));
      children.add(SizedBox(width: metrics.iconGap));
    }
    children.add(Text(label));
    if (trailingIcon != null) {
      children.add(SizedBox(width: metrics.iconGap));
      children.add(Icon(trailingIcon, size: metrics.iconSize));
    }

    return Row(mainAxisSize: MainAxisSize.min, children: children);
  }

  ButtonStyle _buttonStyle(ThemeData theme, _ButtonMetrics metrics) {
    final foreground = _foregroundColor(theme);
    final background = _backgroundColor(theme);
    final isText = variant == AppButtonVariant.text;

    return ButtonStyle(
      minimumSize: WidgetStatePropertyAll(Size(isText ? 0 : 0, metrics.height)),
      padding: WidgetStatePropertyAll(metrics.padding),
      textStyle: WidgetStatePropertyAll(theme.textTheme.labelLarge),
      foregroundColor: WidgetStatePropertyAll(foreground),
      backgroundColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.disabled)
            ? theme.colorScheme.surfaceContainerHighest
            : background,
      ),
      overlayColor: WidgetStatePropertyAll(foreground.withValues(alpha: 0.12)),
      side: variant == AppButtonVariant.outlined
          ? WidgetStatePropertyAll(BorderSide(color: theme.colorScheme.outline))
          : null,
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Color _backgroundColor(ThemeData theme) {
    return switch (variant) {
      AppButtonVariant.primary => theme.colorScheme.primary,
      AppButtonVariant.secondary => theme.colorScheme.secondary,
      AppButtonVariant.tonal => theme.colorScheme.secondaryContainer,
      AppButtonVariant.danger => theme.colorScheme.error,
      AppButtonVariant.outlined || AppButtonVariant.text => Colors.transparent,
    };
  }

  Color _foregroundColor(ThemeData theme) {
    return switch (variant) {
      AppButtonVariant.primary => theme.colorScheme.onPrimary,
      AppButtonVariant.secondary => theme.colorScheme.onSecondary,
      AppButtonVariant.tonal => theme.colorScheme.onSecondaryContainer,
      AppButtonVariant.danger => theme.colorScheme.onError,
      AppButtonVariant.outlined ||
      AppButtonVariant.text => theme.colorScheme.primary,
    };
  }
}

/// A compact icon-only button that requires a tooltip for accessibility.
class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    required this.tooltip,
    this.onPressed,
    this.color,
    this.size = 24,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;
  final Color? color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      tooltip: tooltip,
      icon: Icon(icon, size: size),
      color: color,
    );
  }
}

class _ButtonMetrics {
  const _ButtonMetrics({
    required this.height,
    required this.padding,
    required this.iconSize,
    required this.iconGap,
  });

  final double height;
  final EdgeInsetsGeometry padding;
  final double iconSize;
  final double iconGap;

  factory _ButtonMetrics.from(AppButtonSize size) {
    return switch (size) {
      AppButtonSize.small => const _ButtonMetrics(
        height: 36,
        padding: EdgeInsets.symmetric(horizontal: 14),
        iconSize: 16,
        iconGap: 6,
      ),
      AppButtonSize.medium => const _ButtonMetrics(
        height: 44,
        padding: EdgeInsets.symmetric(horizontal: 18),
        iconSize: 18,
        iconGap: 8,
      ),
      AppButtonSize.large => const _ButtonMetrics(
        height: 52,
        padding: EdgeInsets.symmetric(horizontal: 22),
        iconSize: 20,
        iconGap: 8,
      ),
    };
  }
}
