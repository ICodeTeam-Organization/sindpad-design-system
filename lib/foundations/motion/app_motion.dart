import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';

/// Motion, animation duration, and easing curve tokens for the Sindpad Design System.
///
/// Standardizes transitions across all Sindpad applications to create a cohesive,
/// responsive, and predictable user experience.
@immutable
class AppMotion {
  // Static duration constants
  static const Duration durationInstant = Duration.zero;
  static const Duration durationFast = Duration(milliseconds: 150);
  static const Duration durationNormal = Duration(milliseconds: 300);
  static const Duration durationSlow = Duration(milliseconds: 500);

  // Static curve constants
  static const Curve curveStandard = Curves.easeInOut;
  static const Curve curveAccelerate = Curves.easeIn;
  static const Curve curveDecelerate = Curves.easeOut;
  static const Curve curveEmphasized = Curves.easeInOutCubicEmphasized;

  /// 0ms
  static const Duration instant = durationInstant;

  /// 150ms - Used for small micro-interactions (checkboxes, toggle switches, hover).
  static const Duration fast = durationFast;

  /// 300ms - Standard UI transitions (sheet openings, tabs, dialogs).
  static const Duration normal = durationNormal;

  /// 500ms - Deliberate or complex scene transitions.
  static const Duration slow = durationSlow;

  // Instance variables for customizable theme configuration
  final Duration fastDuration;
  final Duration normalDuration;
  final Duration slowDuration;
  final Curve standardCurve;
  final Curve accelerateCurve;
  final Curve decelerateCurve;
  final Curve emphasizedCurve;

  const AppMotion({
    this.fastDuration = durationFast,
    this.normalDuration = durationNormal,
    this.slowDuration = durationSlow,
    this.standardCurve = curveStandard,
    this.accelerateCurve = curveAccelerate,
    this.decelerateCurve = curveDecelerate,
    this.emphasizedCurve = curveEmphasized,
  });

  const AppMotion.standard()
      : fastDuration = durationFast,
        normalDuration = durationNormal,
        slowDuration = durationSlow,
        standardCurve = curveStandard,
        accelerateCurve = curveAccelerate,
        decelerateCurve = curveDecelerate,
        emphasizedCurve = curveEmphasized;

  AppMotion copyWith({
    Duration? fastDuration,
    Duration? normalDuration,
    Duration? slowDuration,
    Curve? standardCurve,
    Curve? accelerateCurve,
    Curve? decelerateCurve,
    Curve? emphasizedCurve,
  }) {
    return AppMotion(
      fastDuration: fastDuration ?? this.fastDuration,
      normalDuration: normalDuration ?? this.normalDuration,
      slowDuration: slowDuration ?? this.slowDuration,
      standardCurve: standardCurve ?? this.standardCurve,
      accelerateCurve: accelerateCurve ?? this.accelerateCurve,
      decelerateCurve: decelerateCurve ?? this.decelerateCurve,
      emphasizedCurve: emphasizedCurve ?? this.emphasizedCurve,
    );
  }

  static AppMotion lerp(AppMotion a, AppMotion b, double t) {
    return t < 0.5 ? a : b;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppMotion &&
          runtimeType == other.runtimeType &&
          fastDuration == other.fastDuration &&
          normalDuration == other.normalDuration &&
          slowDuration == other.slowDuration &&
          standardCurve == other.standardCurve &&
          accelerateCurve == other.accelerateCurve &&
          decelerateCurve == other.decelerateCurve &&
          emphasizedCurve == other.emphasizedCurve;

  @override
  int get hashCode => Object.hash(
        fastDuration,
        normalDuration,
        slowDuration,
        standardCurve,
        accelerateCurve,
        decelerateCurve,
        emphasizedCurve,
      );
}
