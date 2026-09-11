/// Sindpad Design System
///
/// A shared Flutter design system providing scalable foundations, tokens,
/// and theme infrastructure across Sindpad organization applications.
library;

// Foundations - Design Tokens
export 'foundations/colors/app_colors.dart';
export 'foundations/colors/semantic_colors.dart';
export 'foundations/dimensions/app_dimensions.dart';
export 'foundations/motion/app_motion.dart';
export 'foundations/radius/app_radius.dart';
export 'foundations/shadows/app_shadows.dart';
export 'foundations/spacing/app_spacing.dart';
export 'foundations/typography/app_typography.dart';

// Theme Architecture & Extensions
export 'theme/app_theme.dart';
export 'theme/theme_config.dart';
export 'theme/theme_extensions.dart';

// Auth Components - Login
export 'components/auth/login/app_login_config.dart';
export 'components/auth/login/app_login_form.dart';
export 'components/auth/login/app_login_models.dart';

// Feedback Components
export 'components/feedback/app_error_widget.dart';
export 'components/feedback/app_waiting_widget.dart';
export 'components/feedback/sign_in_snack_bar.dart';

// Third-party Icons
export 'package:font_awesome_flutter/font_awesome_flutter.dart';
