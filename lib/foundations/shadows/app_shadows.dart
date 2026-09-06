import 'package:flutter/widgets.dart';

/// Semantic shadow/elevation levels for the Sindpad Design System.
///
/// Provides configurable [BoxShadow] definitions across elevation tiers:
/// `none`, `sm` (subtle cards/items), `md` (floating dropdowns/popovers),
/// and `lg` (modals/dialogs).
@immutable
class AppShadows {
  final List<BoxShadow> none;
  final List<BoxShadow> sm;
  final List<BoxShadow> md;
  final List<BoxShadow> lg;

  const AppShadows({
    required this.none,
    required this.sm,
    required this.md,
    required this.lg,
  });

  /// Standard default elevation shadows for light themes.
  static const AppShadows light = AppShadows(
    none: [],
    sm: [
      BoxShadow(
        color: Color(0x0A000000),
        offset: Offset(0, 1),
        blurRadius: 2,
        spreadRadius: 0,
      ),
      BoxShadow(
        color: Color(0x0F000000),
        offset: Offset(0, 1),
        blurRadius: 3,
        spreadRadius: 0,
      ),
    ],
    md: [
      BoxShadow(
        color: Color(0x0A000000),
        offset: Offset(0, 4),
        blurRadius: 6,
        spreadRadius: -1,
      ),
      BoxShadow(
        color: Color(0x14000000),
        offset: Offset(0, 2),
        blurRadius: 4,
        spreadRadius: -1,
      ),
    ],
    lg: [
      BoxShadow(
        color: Color(0x14000000),
        offset: Offset(0, 10),
        blurRadius: 15,
        spreadRadius: -3,
      ),
      BoxShadow(
        color: Color(0x0F000000),
        offset: Offset(0, 4),
        blurRadius: 6,
        spreadRadius: -2,
      ),
    ],
  );

  /// Standard default elevation shadows for dark themes.
  static const AppShadows dark = AppShadows(
    none: [],
    sm: [
      BoxShadow(
        color: Color(0x40000000),
        offset: Offset(0, 1),
        blurRadius: 3,
        spreadRadius: 0,
      ),
    ],
    md: [
      BoxShadow(
        color: Color(0x59000000),
        offset: Offset(0, 4),
        blurRadius: 6,
        spreadRadius: -1,
      ),
    ],
    lg: [
      BoxShadow(
        color: Color(0x73000000),
        offset: Offset(0, 10),
        blurRadius: 15,
        spreadRadius: -3,
      ),
    ],
  );

  AppShadows copyWith({
    List<BoxShadow>? none,
    List<BoxShadow>? sm,
    List<BoxShadow>? md,
    List<BoxShadow>? lg,
  }) {
    return AppShadows(
      none: none ?? this.none,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
    );
  }

  static AppShadows lerp(AppShadows a, AppShadows b, double t) {
    return AppShadows(
      none: BoxShadow.lerpList(a.none, b.none, t) ?? a.none,
      sm: BoxShadow.lerpList(a.sm, b.sm, t) ?? a.sm,
      md: BoxShadow.lerpList(a.md, b.md, t) ?? a.md,
      lg: BoxShadow.lerpList(a.lg, b.lg, t) ?? a.lg,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppShadows &&
          runtimeType == other.runtimeType &&
          _listEquals(none, other.none) &&
          _listEquals(sm, other.sm) &&
          _listEquals(md, other.md) &&
          _listEquals(lg, other.lg);

  @override
  int get hashCode => Object.hash(
        Object.hashAll(none),
        Object.hashAll(sm),
        Object.hashAll(md),
        Object.hashAll(lg),
      );

  static bool _listEquals<T>(List<T> a, List<T> b) {
    if (identical(a, b)) return true;
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
