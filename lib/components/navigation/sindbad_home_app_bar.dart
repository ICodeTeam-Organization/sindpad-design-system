import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../icons/sindbad_menu_icon.dart';
import '../../theme/theme_extensions.dart';

/// Interactive animated search field with rotating placeholder hints,
/// clear action, and theme-adaptive styling.
class SindbadAnimatedSearchField extends StatefulWidget {
  final String? initialValue;
  final TextEditingController? controller;
  final ValueChanged<String>? onSearch;
  final ValueChanged<String>? onSearchChanged;
  final VoidCallback? onTap;
  final String? staticHint;
  final List<String>? rotatingHints;
  final Duration hintChangeInterval;
  final bool readOnly;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final TextInputAction textInputAction;

  const SindbadAnimatedSearchField({
    super.key,
    this.initialValue,
    this.controller,
    this.onSearch,
    this.onSearchChanged,
    this.onTap,
    this.staticHint,
    this.rotatingHints,
    this.hintChangeInterval = const Duration(seconds: 3),
    this.readOnly = false,
    this.backgroundColor,
    this.borderRadius,
    this.textInputAction = TextInputAction.search,
  });

  @override
  State<SindbadAnimatedSearchField> createState() =>
      _SindbadAnimatedSearchFieldState();
}

class _SindbadAnimatedSearchFieldState
    extends State<SindbadAnimatedSearchField> {
  static const List<String> _defaultHints = [
    'ابحث عن منتج...',
    'ابحث عن ملابس...',
    'ابحث عن أجهزة إلكترونية...',
    'ابحث عن عروض وخصومات...',
    'ابحث بالاسم أو الباركود...',
  ];

  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  bool _isInternalController = false;
  late String _currentHint;
  bool _showAnimation = true;
  Timer? _hintTimer;

  List<String> get _activeHints =>
      widget.rotatingHints ?? _defaultHints;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      _controller = widget.controller!;
    } else {
      _controller = TextEditingController(text: widget.initialValue);
      _isInternalController = true;
    }

    _focusNode = FocusNode();
    _currentHint = widget.staticHint ??
        (_activeHints.isNotEmpty
            ? _activeHints[Random().nextInt(_activeHints.length)]
            : 'ابحث...');

    _controller.addListener(_onTextChanged);
    _focusNode.addListener(_onFocusChanged);

    if (widget.staticHint == null) {
      _startHintAnimation();
    }
  }

  void _onTextChanged() {
    if (mounted) {
      setState(() {
        _showAnimation = _controller.text.isEmpty;
      });
    }
  }

  void _onFocusChanged() {
    if (mounted) {
      setState(() {
        if (_focusNode.hasFocus) {
          _showAnimation = false;
        } else {
          _showAnimation = _controller.text.isEmpty;
        }
      });
    }
  }

  void _startHintAnimation() {
    _hintTimer?.cancel();
    if (_activeHints.length <= 1) return;

    _hintTimer = Timer.periodic(widget.hintChangeInterval, (timer) {
      if (mounted && _showAnimation && _controller.text.isEmpty) {
        setState(() {
          _currentHint = _activeHints[Random().nextInt(_activeHints.length)];
        });
      } else if (!mounted) {
        timer.cancel();
      }
    });
  }

  void _clearSearch() {
    _controller.clear();
    widget.onSearchChanged?.call('');
    if (mounted) {
      setState(() {
        _showAnimation = true;
      });
    }
    _focusNode.unfocus();
  }

  @override
  void dispose() {
    _hintTimer?.cancel();
    _controller.removeListener(_onTextChanged);
    _focusNode.removeListener(_onFocusChanged);
    _focusNode.dispose();
    if (_isInternalController) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final ext = Theme.of(context).extension<SindpadThemeExtension>();

    final defaultBg = ext?.semanticColors.surfaceSubtle ??
        (isDark ? const Color(0xFF262633) : const Color(0xFFF2F3F4));
    final fieldBg = widget.backgroundColor ?? defaultBg;

    final hintColor = isDark ? const Color(0xFF8E8E9A) : const Color(0xFF9E9EA8);
    final textColor = ext?.semanticColors.textPrimary ??
        (isDark ? Colors.white : const Color(0xFF141419));

    return Container(
      height: 40.0,
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: fieldBg,
        borderRadius: widget.borderRadius ?? BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          Icon(Icons.search, size: 20.0, color: hintColor),
          const SizedBox(width: 8.0),
          Expanded(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  // Animated Hint Text
                  if (_showAnimation && _controller.text.isEmpty)
                    Positioned(
                      right: 0,
                      left: 0,
                      child: IgnorePointer(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 400),
                          transitionBuilder: (child, animation) {
                            return SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(0, 0.8),
                                end: Offset.zero,
                              ).animate(animation),
                              child: FadeTransition(
                                opacity: animation,
                                child: child,
                              ),
                            );
                          },
                          child: Text(
                            _currentHint,
                            key: ValueKey<String>(_currentHint),
                            style: TextStyle(
                              fontSize: 13.0,
                              color: hintColor,
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                    ),

                  // Input Field
                  TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    readOnly: widget.readOnly,
                    textInputAction: widget.textInputAction,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 13.0, color: textColor),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.only(
                        right: _controller.text.isNotEmpty ? 28.0 : 0.0,
                      ),
                    ),
                    onSubmitted: (value) {
                      widget.onSearch?.call(value);
                    },
                    onTap: () {
                      if (mounted) {
                        setState(() {
                          _showAnimation = false;
                        });
                      }
                      widget.onTap?.call();
                    },
                    onChanged: (value) {
                      widget.onSearchChanged?.call(value);
                    },
                  ),

                  // Clear Icon Button
                  if (_controller.text.isNotEmpty)
                    Positioned(
                      right: 0,
                      child: GestureDetector(
                        onTap: _clearSearch,
                        child: Container(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.close_rounded,
                            size: 16.0,
                            color: hintColor,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Standard, pure-presentation Home & Store App Bar for Sindbad apps.
///
/// Features:
/// - Drawer trigger with stylized Sindbad 3-bar icon
/// - App title or brand logo widget
/// - Notification icon with dynamic badge count
/// - Optional animated search field (inline or dual-row)
/// - Flexible trailing action widgets (favorite, flags, etc.)
class SindbadHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// App or screen title.
  final String? title;

  /// Custom title or logo widget. If provided, takes precedence over [title].
  final Widget? titleWidget;

  /// Whether the title should be centered. Defaults to false.
  final bool centerTitle;

  /// Whether to display the drawer trigger icon.
  final bool showDrawerButton;

  /// Callback when the drawer icon is tapped. Defaults to opening the current Scaffold drawer.
  final VoidCallback? onDrawerTap;

  /// Custom drawer icon widget. Defaults to [SindbadMenuIcon].
  final Widget? drawerIcon;

  /// Whether to display the notification icon.
  final bool showNotificationIcon;

  /// Unread notification count. If > 0, displays a badge on the bell icon.
  final int notificationCount;

  /// Callback when the notification icon is tapped.
  final VoidCallback? onNotificationTap;

  /// Custom notification icon widget.
  final Widget? notificationIcon;

  /// Whether to display the search field. Defaults to false for normal app bar.
  final bool showSearchBar;

  /// Whether the search field should be placed in a dedicated bottom row.
  /// If null, automatically resolves to `true` when a title is present, and `false` if no title.
  final bool? searchInBottomRow;

  /// Static search hint string. If provided, disables hint animation.
  final String? searchHint;

  /// List of hints to rotate through with smooth vertical animation.
  final List<String>? searchHints;

  /// Controller for the search input.
  final TextEditingController? searchController;

  /// Callback when the user submits search (e.g. presses enter/search on keyboard).
  final ValueChanged<String>? onSearch;

  /// Callback when the search text changes.
  final ValueChanged<String>? onSearchChanged;

  /// Callback when the search bar is tapped.
  final VoidCallback? onSearchTap;

  /// Additional trailing action widgets (e.g. favorite icon, language/flag selector).
  final List<Widget>? actions;

  /// Background color override. Defaults to theme surface.
  final Color? backgroundColor;

  /// Foreground icon and text color override.
  final Color? foregroundColor;

  /// App bar elevation.
  final double elevation;

  /// Whether to show a subtle 1px border line at the bottom.
  final bool showBottomDivider;

  /// Custom divider color.
  final Color? dividerColor;

  /// Standard normal home app bar with drawer icon, title, notification icon, and actions.
  ///
  /// To include a search bar, use [SindbadHomeAppBar.withSearch] or set [showSearchBar] to true.
  const SindbadHomeAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.centerTitle = false,
    this.showDrawerButton = true,
    this.onDrawerTap,
    this.drawerIcon,
    this.showNotificationIcon = true,
    this.notificationCount = 0,
    this.onNotificationTap,
    this.notificationIcon,
    this.showSearchBar = false,
    this.searchInBottomRow,
    this.searchHint,
    this.searchHints,
    this.searchController,
    this.onSearch,
    this.onSearchChanged,
    this.onSearchTap,
    this.actions,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 0,
    this.showBottomDivider = true,
    this.dividerColor,
  });

  /// Explicit constructor for the normal home app bar without a search bar.
  ///
  /// Displays drawer trigger, title, notification icon with unread count,
  /// and optional trailing actions.
  const SindbadHomeAppBar.normal({
    super.key,
    this.title,
    this.titleWidget,
    this.centerTitle = false,
    this.showDrawerButton = true,
    this.onDrawerTap,
    this.drawerIcon,
    this.showNotificationIcon = true,
    this.notificationCount = 0,
    this.onNotificationTap,
    this.notificationIcon,
    this.actions,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 0,
    this.showBottomDivider = true,
    this.dividerColor,
  })  : showSearchBar = false,
        searchInBottomRow = null,
        searchHint = null,
        searchHints = null,
        searchController = null,
        onSearch = null,
        onSearchChanged = null,
        onSearchTap = null;

  /// Constructor for a home app bar with an integrated search bar.
  ///
  /// Displays drawer icon, title, notification icon, trailing actions,
  /// and an animated rotating-hint search field (either in a dedicated bottom row or inline).
  const SindbadHomeAppBar.withSearch({
    super.key,
    this.title,
    this.titleWidget,
    this.centerTitle = false,
    this.showDrawerButton = true,
    this.onDrawerTap,
    this.drawerIcon,
    this.showNotificationIcon = true,
    this.notificationCount = 0,
    this.onNotificationTap,
    this.notificationIcon,
    this.searchInBottomRow = true,
    this.searchHint,
    this.searchHints,
    this.searchController,
    this.onSearch,
    this.onSearchChanged,
    this.onSearchTap,
    this.actions,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 0,
    this.showBottomDivider = true,
    this.dividerColor,
  }) : showSearchBar = true;

  bool get _hasTitle => (title != null && title!.isNotEmpty) || titleWidget != null;

  bool get isDualRow {
    if (!showSearchBar) return false;
    if (searchInBottomRow != null) return searchInBottomRow!;
    return _hasTitle;
  }

  @override
  Size get preferredSize {
    const baseHeight = 56.0;
    final searchBottomHeight = isDualRow ? 50.0 : 0.0;
    final dividerHeight = showBottomDivider ? 1.0 : 0.0;
    return Size.fromHeight(baseHeight + searchBottomHeight + dividerHeight);
  }

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<SindpadThemeExtension>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bg = backgroundColor ??
        ext?.semanticColors.surface ??
        Theme.of(context).appBarTheme.backgroundColor ??
        (isDark ? const Color(0xFF141419) : Colors.white);

    final fg = foregroundColor ??
        ext?.semanticColors.textPrimary ??
        Theme.of(context).appBarTheme.foregroundColor ??
        (isDark ? Colors.white : const Color(0xFF141419));

    final defaultDividerColor = ext?.semanticColors.borderSubtle ??
        (isDark ? Colors.white12 : const Color(0xFFE5E7EB));
    final resolvedDivider = dividerColor ?? defaultDividerColor;

    return Material(
      color: bg,
      elevation: elevation,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: preferredSize.height,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Main Top Row
              SizedBox(
                height: 56.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: Row(
                    children: [
                      // Drawer Trigger
                      if (showDrawerButton) ...[
                        InkWell(
                          borderRadius: BorderRadius.circular(8.0),
                          onTap: onDrawerTap ??
                              () {
                                Scaffold.maybeOf(context)?.openDrawer();
                              },
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: drawerIcon ??
                                SindbadMenuIcon(size: 22.0, color: fg),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                      ],

                      // Top Row Content (Title or Inline Search)
                      if (!showSearchBar) ...[
                        if (_hasTitle)
                          Expanded(
                            child: Align(
                              alignment: centerTitle
                                  ? Alignment.center
                                  : AlignmentDirectional.centerStart,
                              child: _buildTitle(ext, fg),
                            ),
                          )
                        else
                          const Spacer(),
                      ] else if (isDualRow) ...[
                        Expanded(
                          child: Align(
                            alignment: centerTitle
                                ? Alignment.center
                                : AlignmentDirectional.centerStart,
                            child: _buildTitle(ext, fg),
                          ),
                        ),
                      ] else if (_hasTitle) ...[
                        _buildTitle(ext, fg),
                        const SizedBox(width: 8.0),
                        Expanded(child: _buildSearchField()),
                      ] else ...[
                        Expanded(child: _buildSearchField()),
                      ],

                      // Notification Icon
                      if (showNotificationIcon) ...[
                        const SizedBox(width: 8.0),
                        _buildNotificationButton(fg),
                      ],

                      // Additional Actions (Favorite, Country Flag, etc.)
                      if (actions != null && actions!.isNotEmpty) ...[
                        const SizedBox(width: 4.0),
                        ...actions!,
                      ],
                    ],
                  ),
                ),
              ),

              // Bottom Search Bar Row (when dual-row is active)
              if (isDualRow)
                Padding(
                  padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 10.0),
                  child: _buildSearchField(),
                ),

              // Bottom Divider
              if (showBottomDivider)
                Container(
                  height: 1.0,
                  color: resolvedDivider,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(SindpadThemeExtension? ext, Color fg) {
    if (titleWidget != null) return titleWidget!;

    return Text(
      title ?? '',
      style: ext?.typography.titleLarge.copyWith(
            fontWeight: FontWeight.bold,
            color: fg,
          ) ??
          TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: fg,
          ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildNotificationButton(Color fg) {
    Widget bell = notificationIcon ??
        Icon(
          Icons.notifications_outlined,
          size: 24.0,
          color: fg,
        );

    if (notificationCount > 0) {
      final badgeLabel = notificationCount > 9 ? '9+' : '$notificationCount';
      bell = Badge(
        label: Text(
          badgeLabel,
          style: const TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFDC2626),
        child: bell,
      );
    }

    return InkWell(
      borderRadius: BorderRadius.circular(8.0),
      onTap: onNotificationTap,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: bell,
      ),
    );
  }

  Widget _buildSearchField() {
    return SindbadAnimatedSearchField(
      controller: searchController,
      staticHint: searchHint,
      rotatingHints: searchHints,
      onSearch: onSearch,
      onSearchChanged: onSearchChanged,
      onTap: onSearchTap,
    );
  }
}
