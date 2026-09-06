import 'dart:ui';
import 'package:flutter/widgets.dart';

/// Spacing scale for the Sindpad Design System.
///
/// Provides consistent spacing primitives used for margins, paddings, and
/// component gaps. Can be accessed statically (e.g. `AppSpacing.md`) or
/// instantiated per application theme configuration.
@immutable
class AppSpacing {
  static const double xxsValue = 2.0;
  static const double xsValue = 4.0;
  static const double smValue = 8.0;
  static const double mdValue = 16.0;
  static const double lgValue = 24.0;
  static const double xlValue = 32.0;
  static const double xxlValue = 48.0;
  static const double xxxlValue = 64.0;

  /// 2.0
  static const double xxs = xxsValue;

  /// 4.0
  static const double xs = xsValue;

  /// 8.0
  static const double sm = smValue;

  /// 16.0
  static const double md = mdValue;

  /// 24.0
  static const double lg = lgValue;

  /// 32.0
  static const double xl = xlValue;

  /// 48.0
  static const double xxl = xxlValue;

  /// 64.0
  static const double xxxl = xxxlValue;

  // Instance fields for customizable theme configurations
  final double sXxs;
  final double sXs;
  final double sSm;
  final double sMd;
  final double sLg;
  final double sXl;
  final double sXxl;
  final double sXxxl;

  const AppSpacing({
    this.sXxs = xxsValue,
    this.sXs = xsValue,
    this.sSm = smValue,
    this.sMd = mdValue,
    this.sLg = lgValue,
    this.sXl = xlValue,
    this.sXxl = xxlValue,
    this.sXxxl = xxxlValue,
  });

  const AppSpacing.standard()
      : sXxs = xxsValue,
        sXs = xsValue,
        sSm = smValue,
        sMd = mdValue,
        sLg = lgValue,
        sXl = xlValue,
        sXxl = xxlValue,
        sXxxl = xxxlValue;

  AppSpacing copyWith({
    double? sXxs,
    double? sXs,
    double? sSm,
    double? sMd,
    double? sLg,
    double? sXl,
    double? sXxl,
    double? sXxxl,
  }) {
    return AppSpacing(
      sXxs: sXxs ?? this.sXxs,
      sXs: sXs ?? this.sXs,
      sSm: sSm ?? this.sSm,
      sMd: sMd ?? this.sMd,
      sLg: sLg ?? this.sLg,
      sXl: sXl ?? this.sXl,
      sXxl: sXxl ?? this.sXxl,
      sXxxl: sXxxl ?? this.sXxxl,
    );
  }

  static AppSpacing lerp(AppSpacing a, AppSpacing b, double t) {
    return AppSpacing(
      sXxs: lerpDouble(a.sXxs, b.sXxs, t) ?? a.sXxs,
      sXs: lerpDouble(a.sXs, b.sXs, t) ?? a.sXs,
      sSm: lerpDouble(a.sSm, b.sSm, t) ?? a.sSm,
      sMd: lerpDouble(a.sMd, b.sMd, t) ?? a.sMd,
      sLg: lerpDouble(a.sLg, b.sLg, t) ?? a.sLg,
      sXl: lerpDouble(a.sXl, b.sXl, t) ?? a.sXl,
      sXxl: lerpDouble(a.sXxl, b.sXxl, t) ?? a.sXxl,
      sXxxl: lerpDouble(a.sXxxl, b.sXxxl, t) ?? a.sXxxl,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppSpacing &&
          runtimeType == other.runtimeType &&
          sXxs == other.sXxs &&
          sXs == other.sXs &&
          sSm == other.sSm &&
          sMd == other.sMd &&
          sLg == other.sLg &&
          sXl == other.sXl &&
          sXxl == other.sXxl &&
          sXxxl == other.sXxxl;

  @override
  int get hashCode => Object.hash(sXxs, sXs, sSm, sMd, sLg, sXl, sXxl, sXxxl);
}
