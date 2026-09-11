import 'package:flutter/material.dart';

/// A centered loader with an optional message for local loading regions.
class AppLoader extends StatelessWidget {
  const AppLoader({
    super.key,
    this.message,
    this.size = 24,
    this.strokeWidth = 2.5,
  });

  final String? message;
  final double size;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    final content = CircularLoader(size: size, strokeWidth: strokeWidth);
    if (message == null) return content;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        content,
        const SizedBox(height: 12),
        Text(message!, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}

/// A theme-aware circular progress indicator.
class CircularLoader extends StatelessWidget {
  const CircularLoader({
    super.key,
    this.size = 24,
    this.strokeWidth = 2.5,
    this.color,
  });

  final double size;
  final double strokeWidth;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        color: color ?? Theme.of(context).colorScheme.primary,
      ),
    );
  }
}

/// A theme-aware linear progress indicator.
class LinearLoader extends StatelessWidget {
  const LinearLoader({
    super.key,
    this.value,
    this.color,
    this.backgroundColor,
    this.minHeight = 4,
    this.borderRadius = 999,
  });

  final double? value;
  final Color? color;
  final Color? backgroundColor;
  final double minHeight;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: LinearProgressIndicator(
        value: value,
        minHeight: minHeight,
        color: color ?? theme.colorScheme.primary,
        backgroundColor: backgroundColor ?? theme.colorScheme.surfaceVariant,
      ),
    );
  }
}

/// A theme-aware placeholder block used to build loading skeletons.
class Skeleton extends StatefulWidget {
  const Skeleton({
    super.key,
    this.width,
    this.height = 16,
    this.borderRadius = 8,
    this.margin,
  });

  final double? width;
  final double height;
  final double borderRadius;
  final EdgeInsetsGeometry? margin;

  @override
  State<Skeleton> createState() => _SkeletonState();
}

class _SkeletonState extends State<Skeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final baseColor = colors.surfaceVariant;
    final highlightColor = Color.lerp(
      baseColor,
      colors.onSurface.withValues(alpha: 0.08),
      0.5,
    )!;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final position = -1.0 + (_controller.value * 2.0);
        return Container(
          width: widget.width,
          height: widget.height,
          margin: widget.margin,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: LinearGradient(
              begin: Alignment(position, 0),
              end: Alignment(position + 1, 0),
              colors: [baseColor, highlightColor, baseColor],
            ),
          ),
        );
      },
    );
  }
}

/// A product card placeholder with image, title, and metadata lines.
class ProductSkeleton extends StatelessWidget {
  const ProductSkeleton({
    super.key,
    this.imageHeight = 140,
    this.padding = const EdgeInsets.all(12),
  });

  final double imageHeight;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Skeleton(
            width: double.infinity,
            height: imageHeight,
            borderRadius: 0,
          ),
          Padding(
            padding: padding,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Skeleton(width: 150),
                SizedBox(height: 10),
                Skeleton(width: 90, height: 13),
                SizedBox(height: 14),
                Skeleton(width: 110, height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// A vertical group of repeated card placeholders.
class ListSkeleton extends StatelessWidget {
  const ListSkeleton({super.key, this.itemCount = 3, this.spacing = 12});

  final int itemCount;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      separatorBuilder: (_, __) => SizedBox(height: spacing),
      itemBuilder: (_, __) => const CardSkeleton(),
    );
  }
}

/// A horizontal content-card placeholder for list rows.
class CardSkeleton extends StatelessWidget {
  const CardSkeleton({
    super.key,
    this.imageSize = 72,
    this.padding = const EdgeInsets.all(12),
  });

  final double imageSize;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: padding,
        child: Row(
          children: [
            Skeleton(width: imageSize, height: imageSize, borderRadius: 10),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Skeleton(width: 150),
                  SizedBox(height: 10),
                  Skeleton(width: 100, height: 13),
                  SizedBox(height: 10),
                  Skeleton(width: 70, height: 13),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A full-area loader for pages waiting on their initial data.
class PageLoader extends StatelessWidget {
  const PageLoader({
    super.key,
    this.message = 'Loading...',
    this.padding = const EdgeInsets.all(24),
  });

  final String message;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: padding,
        child: AppLoader(message: message, size: 32, strokeWidth: 3),
      ),
    );
  }
}
