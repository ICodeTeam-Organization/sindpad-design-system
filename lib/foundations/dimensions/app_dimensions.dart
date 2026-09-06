import 'dart:ui';
import 'package:flutter/widgets.dart';

/// Standard sizing and layout dimension tokens for the Sindpad Design System.
///
/// Contains standardized dimensions such as icon sizes, minimum touch targets,
/// interactive control heights, and structural heights.
@immutable
class AppDimensions {
  // Static constants for standard baseline values
  static const double minTouchTargetValue = 48.0;

  static const double iconXsValue = 12.0;
  static const double iconSmValue = 16.0;
  static const double iconMdValue = 24.0;
  static const double iconLgValue = 32.0;
  static const double iconXlValue = 48.0;

  static const double controlSmValue = 32.0;
  static const double controlMdValue = 40.0;
  static const double controlLgValue = 48.0;

  static const double appBarHeightValue = 56.0;
  static const double bottomNavBarHeightValue = 64.0;

  /// Accessibility touch target minimum (48.0 dp per WCAG and Material guidelines).
  static const double minTouchTarget = minTouchTargetValue;

  /// 12.0
  static const double iconXs = iconXsValue;

  /// 16.0
  static const double iconSm = iconSmValue;

  /// 24.0
  static const double iconMd = iconMdValue;

  /// 32.0
  static const double iconLg = iconLgValue;

  /// 48.0
  static const double iconXl = iconXlValue;

  /// 32.0
  static const double controlSm = controlSmValue;

  /// 40.0
  static const double controlMd = controlMdValue;

  /// 48.0
  static const double controlLg = controlLgValue;

  /// 56.0
  static const double appBarHeight = appBarHeightValue;

  /// 64.0
  static const double bottomNavBarHeight = bottomNavBarHeightValue;

  // Instance values for customizable theme overrides
  final double touchTargetMin;
  final double iconSizeXs;
  final double iconSizeSm;
  final double iconSizeMd;
  final double iconSizeLg;
  final double iconSizeXl;
  final double controlHeightSm;
  final double controlHeightMd;
  final double controlHeightLg;
  final double heightAppBar;
  final double heightBottomNavBar;

  const AppDimensions({
    this.touchTargetMin = minTouchTargetValue,
    this.iconSizeXs = iconXsValue,
    this.iconSizeSm = iconSmValue,
    this.iconSizeMd = iconMdValue,
    this.iconSizeLg = iconLgValue,
    this.iconSizeXl = iconXlValue,
    this.controlHeightSm = controlSmValue,
    this.controlHeightMd = controlMdValue,
    this.controlHeightLg = controlLgValue,
    this.heightAppBar = appBarHeightValue,
    this.heightBottomNavBar = bottomNavBarHeightValue,
  });

  const AppDimensions.standard()
      : touchTargetMin = minTouchTargetValue,
        iconSizeXs = iconXsValue,
        iconSizeSm = iconSmValue,
        iconSizeMd = iconMdValue,
        iconSizeLg = iconLgValue,
        iconSizeXl = iconXlValue,
        controlHeightSm = controlSmValue,
        controlHeightMd = controlMdValue,
        controlHeightLg = controlLgValue,
        heightAppBar = appBarHeightValue,
        heightBottomNavBar = bottomNavBarHeightValue;

  AppDimensions copyWith({
    double? touchTargetMin,
    double? iconSizeXs,
    double? iconSizeSm,
    double? iconSizeMd,
    double? iconSizeLg,
    double? iconSizeXl,
    double? controlHeightSm,
    double? controlHeightMd,
    double? controlHeightLg,
    double? heightAppBar,
    double? heightBottomNavBar,
  }) {
    return AppDimensions(
      touchTargetMin: touchTargetMin ?? this.touchTargetMin,
      iconSizeXs: iconSizeXs ?? this.iconSizeXs,
      iconSizeSm: iconSizeSm ?? this.iconSizeSm,
      iconSizeMd: iconSizeMd ?? this.iconSizeMd,
      iconSizeLg: iconSizeLg ?? this.iconSizeLg,
      iconSizeXl: iconSizeXl ?? this.iconSizeXl,
      controlHeightSm: controlHeightSm ?? this.controlHeightSm,
      controlHeightMd: controlHeightMd ?? this.controlHeightMd,
      controlHeightLg: controlHeightLg ?? this.controlHeightLg,
      heightAppBar: heightAppBar ?? this.heightAppBar,
      heightBottomNavBar: heightBottomNavBar ?? this.heightBottomNavBar,
    );
  }

  static AppDimensions lerp(AppDimensions a, AppDimensions b, double t) {
    return AppDimensions(
      touchTargetMin: lerpDouble(a.touchTargetMin, b.touchTargetMin, t) ?? a.touchTargetMin,
      iconSizeXs: lerpDouble(a.iconSizeXs, b.iconSizeXs, t) ?? a.iconSizeXs,
      iconSizeSm: lerpDouble(a.iconSizeSm, b.iconSizeSm, t) ?? a.iconSizeSm,
      iconSizeMd: lerpDouble(a.iconSizeMd, b.iconSizeMd, t) ?? a.iconSizeMd,
      iconSizeLg: lerpDouble(a.iconSizeLg, b.iconSizeLg, t) ?? a.iconSizeLg,
      iconSizeXl: lerpDouble(a.iconSizeXl, b.iconSizeXl, t) ?? a.iconSizeXl,
      controlHeightSm: lerpDouble(a.controlHeightSm, b.controlHeightSm, t) ?? a.controlHeightSm,
      controlHeightMd: lerpDouble(a.controlHeightMd, b.controlHeightMd, t) ?? a.controlHeightMd,
      controlHeightLg: lerpDouble(a.controlHeightLg, b.controlHeightLg, t) ?? a.controlHeightLg,
      heightAppBar: lerpDouble(a.heightAppBar, b.heightAppBar, t) ?? a.heightAppBar,
      heightBottomNavBar: lerpDouble(a.heightBottomNavBar, b.heightBottomNavBar, t) ?? a.heightBottomNavBar,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppDimensions &&
          runtimeType == other.runtimeType &&
          touchTargetMin == other.touchTargetMin &&
          iconSizeXs == other.iconSizeXs &&
          iconSizeSm == other.iconSizeSm &&
          iconSizeMd == other.iconSizeMd &&
          iconSizeLg == other.iconSizeLg &&
          iconSizeXl == other.iconSizeXl &&
          controlHeightSm == other.controlHeightSm &&
          controlHeightMd == other.controlHeightMd &&
          controlHeightLg == other.controlHeightLg &&
          heightAppBar == other.heightAppBar &&
          heightBottomNavBar == other.heightBottomNavBar;

  @override
  int get hashCode => Object.hash(
        touchTargetMin,
        iconSizeXs,
        iconSizeSm,
        iconSizeMd,
        iconSizeLg,
        iconSizeXl,
        controlHeightSm,
        controlHeightMd,
        controlHeightLg,
        heightAppBar,
        heightBottomNavBar,
      );
}
