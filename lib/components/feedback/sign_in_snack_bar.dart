import 'package:flutter/material.dart';

/// Global keys for displaying feedback and invoking app-owned navigation.
///
/// Register these keys on the consuming app's [MaterialApp] if you want to
/// use [SignInSnackBar.showGlobal]. Navigation itself remains app-owned and
/// should be supplied through [SignInSnackBar.onLoginPressed].
final GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> appScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

/// A reusable SnackBar that prompts the user to sign in.
class SignInSnackBar extends SnackBar {
  SignInSnackBar({
    super.key,
    String message = 'يرجى تسجيل الدخول أولاً لإكمال الطلب',
    Color? backgroundColor,
    String buttonText = 'تسجيل الدخول',
    Color? buttonBackgroundColor,
    Color? buttonTextColor,
    VoidCallback? onLoginPressed,
    super.duration = const Duration(seconds: 4),
    super.behavior = SnackBarBehavior.floating,
    ShapeBorder? shape,
  }) : super(
         backgroundColor: backgroundColor ?? Colors.orange,
         shape:
             shape ??
             RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
         content: Directionality(
           textDirection: TextDirection.rtl,
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Expanded(
                 child: Text(
                   message,
                   style: const TextStyle(
                     color: Colors.white,
                     fontSize: 14,
                     fontWeight: FontWeight.w500,
                   ),
                   maxLines: 2,
                   overflow: TextOverflow.ellipsis,
                 ),
               ),
               const SizedBox(width: 8),
               ElevatedButton(
                 onPressed: onLoginPressed,
                 style: ElevatedButton.styleFrom(
                   backgroundColor: buttonBackgroundColor ?? Colors.white,
                   foregroundColor:
                       buttonTextColor ?? (backgroundColor ?? Colors.orange),
                   elevation: 0,
                   padding: const EdgeInsets.symmetric(
                     horizontal: 10,
                     vertical: 6,
                   ),
                   minimumSize: Size.zero,
                   tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(6),
                   ),
                 ),
                 child: Text(
                   buttonText,
                   style: const TextStyle(
                     fontSize: 12,
                     fontWeight: FontWeight.bold,
                   ),
                 ),
               ),
             ],
           ),
         ),
       );

  /// Shows the SnackBar using a local [BuildContext].
  static void show(
    BuildContext context, {
    String message = 'يرجى تسجيل الدخول أولاً لإكمال الطلب',
    Color? backgroundColor,
    String buttonText = 'تسجيل الدخول',
    Color? buttonBackgroundColor,
    Color? buttonTextColor,
    VoidCallback? onLoginPressed,
    Duration duration = const Duration(seconds: 4),
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    ShapeBorder? shape,
  }) {
    final messenger = ScaffoldMessenger.of(context);
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SignInSnackBar(
          message: message,
          backgroundColor: backgroundColor,
          buttonText: buttonText,
          buttonBackgroundColor: buttonBackgroundColor,
          buttonTextColor: buttonTextColor,
          onLoginPressed: onLoginPressed,
          duration: duration,
          behavior: behavior,
          shape: shape,
        ),
      );
  }

  /// Shows the SnackBar through [appScaffoldMessengerKey].
  static void showGlobal({
    String message = 'انتهت الجلسة أو يجب تسجيل الدخول للمتابعة',
    Color? backgroundColor,
    String buttonText = 'تسجيل الدخول',
    Color? buttonBackgroundColor,
    Color? buttonTextColor,
    VoidCallback? onLoginPressed,
    Duration duration = const Duration(seconds: 4),
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    ShapeBorder? shape,
  }) {
    final messenger = appScaffoldMessengerKey.currentState;
    if (messenger == null) return;

    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SignInSnackBar(
          message: message,
          backgroundColor: backgroundColor,
          buttonText: buttonText,
          buttonBackgroundColor: buttonBackgroundColor,
          buttonTextColor: buttonTextColor,
          onLoginPressed: onLoginPressed,
          duration: duration,
          behavior: behavior,
          shape: shape,
        ),
      );
  }
}

/// Backward-compatible convenience function for local SnackBar display.
SnackBar signInSnackbar(
  BuildContext context, {
  String message = 'يجب عليك تسجيل الدخول اولا',
  Color? backgroundColor,
  VoidCallback? onLoginPressed,
}) {
  return SignInSnackBar(
    message: message,
    backgroundColor: backgroundColor,
    onLoginPressed: onLoginPressed,
  );
}
