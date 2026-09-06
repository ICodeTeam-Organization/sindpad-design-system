import 'dart:ui';
import 'package:flutter/widgets.dart';

/// Semantic corner radius tokens for the Sindpad Design System.
///
/// Can be accessed statically (e.g., `AppRadius.md`) or instantiated
/// to allow applications to customize curvature levels (e.g. sharp vs. rounded).
@immutable
class AppRadius {
  static const double noneValue = 0.0;
  static const double xsValue = 2.0;
  static const double smValue = 4.0;
  static const double mdValue = 8.0;
  static const double lgValue = 12.0;
  static const double xlValue = 16.0;
  static const double xxlValue = 24.0;
  static const double fullValue = 9999.0;

  /// 0.0
  static const double none = noneValue;

  /// 2.0
  static const double xs = xsValue;

  /// 4.0
  static const double sm = smValue;

  /// 8.0
  static const double md = mdValue;

  /// 12.0
  static const double lg = lgValue;

  /// 16.0
  static const double xl = xlValue;

  /// 24.0
  static const double xxl = xxlValue;

  /// 9999.0
  static const double full = fullValue;

  // Instance values for per-application theme overrides
  final double rNone;
  final double rXs;
  final double rSm;
  final double rMd;
  final double rLg;
  final double rXl;
  final double rXxl;
  final double rFull;

  const AppRadius({
    this.rNone = noneValue,
    this.rXs = xsValue,
    this.rSm = smValue,
    this.rMd = mdValue,
    this.rLg = lgValue,
    this.rXl = xlValue,
    this.rXxl = xxlValue,
    this.rFull = fullValue,
  });

  const AppRadius.standard()
      : rNone = noneValue,
        rXs = xsValue,
        rSm = smValue,
        rMd = mdValue,
        rLg = lgValue,
        rXl = xlValue,
        rXxl = xxlValue,
        rFull = fullValue;

  /// Radius for sharp-edged application designs.
  const AppRadius.sharp()
      : rNone = 0.0,
        rXs = 1.0,
        rSm = 2.0,
        rMd = 4.0,
        rLg = 6.0,
        rXl = 8.0,
        rXxl = 12.0,
        rFull = fullValue;

  /// Radius for pill/rounded application designs.
  const AppRadius.rounded()
      : rNone = 0.0,
        rXs = 4.0,
        rSm = 8.0,
        rMd = 16.0,
        rLg = 20.0,
        rXl = 28.0,
        rXxl = 36.0,
        rFull = fullValue;

  /// Converts a numeric radius into a uniform [BorderRadius].
  BorderRadius asBorderRadius(double radius) => BorderRadius.circular(radius);

  BorderRadius get noneBorderRadius => BorderRadius.circular(rNone);
  BorderRadius get xsBorderRadius => BorderRadius.circular(rXs);
  BorderRadius get smBorderRadius => BorderRadius.circular(rSm);
  BorderRadius get mdBorderRadius => BorderRadius.circular(rMd);
  BorderRadius get lgBorderRadius => BorderRadius.circular(rLg);
  BorderRadius get xlBorderRadius => BorderRadius.circular(rXl);
  BorderRadius get xxlBorderRadius => BorderRadius.circular(rXxl);
  BorderRadius get fullBorderRadius => BorderRadius.circular(rFull);

  AppRadius copyWith({
    double? rNone,
    double? rXs,
    double? rSm,
    double? rMd,
    double? rLg,
    double? rXl,
    double? rXxl,
    double? rFull,
  }) {
    return AppRadius(
      rNone: rNone ?? this.rNone,
      rXs: rXs ?? this.rXs,
      rSm: rSm ?? this.rSm,
      rMd: rMd ?? this.rMd,
      rLg: rLg ?? this.rLg,
      rXl: rXl ?? this.rXl,
      rXxl: rXxl ?? this.rXxl,
      rFull: rFull ?? this.rFull,
    );
  }

  static AppRadius lerp(AppRadius a, AppRadius b, double t) {
    return AppRadius(
      rNone: lerpDouble(a.rNone, b.rNone, t) ?? a.rNone,
      rXs: lerpDouble(a.rXs, b.rXs, t) ?? a.rXs,
      rSm: lerpDouble(a.rSm, b.rSm, t) ?? a.rSm,
      rMd: lerpDouble(a.rMd, b.rMd, t) ?? a.rMd,
      rLg: lerpDouble(a.rLg, b.rLg, t) ?? a.rLg,
      rXl: lerpDouble(a.rXl, b.rXl, t) ?? a.rXl,
      rXxl: lerpDouble(a.rXxl, b.rXxl, t) ?? a.rXxl,
      rFull: lerpDouble(a.rFull, b.rFull, t) ?? a.rFull,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppRadius &&
          runtimeType == other.runtimeType &&
          rNone == other.rNone &&
          rXs == other.rXs &&
          rSm == other.rSm &&
          rMd == other.rMd &&
          rLg == other.rLg &&
          rXl == other.rXl &&
          rXxl == other.rXxl &&
          rFull == other.rFull;

  @override
  int get hashCode => Object.hash(rNone, rXs, rSm, rMd, rLg, rXl, rXxl, rFull);
}
