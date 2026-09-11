import 'package:flutter/material.dart';

/// A centered, theme-aware state for content that has no results yet.
class AppEmptyWidget extends StatelessWidget {
  const AppEmptyWidget({
    super.key,
    this.title = 'Nothing here yet',
    this.message = 'There is no content to display.',
    this.icon = Icons.inbox_outlined,
    this.action,
    this.padding = const EdgeInsets.all(20),
  });

  final String title;
  final String message;
  final IconData icon;
  final Widget? action;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: padding,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: theme.dividerColor),
            borderRadius: BorderRadius.circular(25),
            color: theme.cardColor,
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 80, color: theme.colorScheme.primary),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                message,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.hintColor,
                ),
              ),
              if (action != null) ...[const SizedBox(height: 16), action!],
            ],
          ),
        ),
      ),
    );
  }
}
