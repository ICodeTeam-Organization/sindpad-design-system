import 'package:flutter/foundation.dart';

/// Supported credential input types for authentication.
enum LoginCredentialType {
  /// User enters an email address.
  email,

  /// User enters a phone number.
  phone,

  /// User can enter either a phone number or an email address.
  phoneOrEmail,
}

/// Immutable value object representing entered login credentials.
///
/// Contains the user's login identifier (email, phone, or either) and password.
/// Authentication logic, token retrieval, and credential verification must be handled
/// exclusively by the consuming application, not the design system.
@immutable
class LoginCredentials {
  /// The user-provided identifier (email address or phone number).
  final String identifier;

  /// The user-provided raw password.
  final String password;

  const LoginCredentials({
    required this.identifier,
    required this.password,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginCredentials &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier &&
          password == other.password;

  @override
  int get hashCode => Object.hash(identifier, password);

  @override
  String toString() =>
      'LoginCredentials(identifier: $identifier, password: [PROTECTED])';
}
