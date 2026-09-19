import 'package:flutter/foundation.dart';

/// A centralized logging utility for the VCare app.
/// Wraps [debugPrint] with level-based prefixes for easy filtering in the console.
class AppLogger {
  AppLogger._();

  /// General log — cyan colored prefix
  static void log(String message, {String tag = 'APP'}) {
    debugPrint('🔵 [$tag] $message');
  }

  /// Success / info log — green colored prefix
  static void info(String message, {String tag = 'INFO'}) {
    debugPrint('✅ [$tag] $message');
  }

  /// Warning log — yellow colored prefix
  static void warning(String message, {String tag = 'WARN'}) {
    debugPrint('⚠️  [$tag] $message');
  }

  /// Error log — red colored prefix
  static void error(String message, {String tag = 'ERROR', Object? exception, StackTrace? stackTrace}) {
    debugPrint('❌ [$tag] $message');
    if (exception != null) {
      debugPrint('   └─ Exception: $exception');
    }
    if (stackTrace != null) {
      debugPrint('   └─ StackTrace:\n$stackTrace');
    }
  }

  /// BLoC-specific log — purple colored prefix
  static void bloc(String message, {String tag = 'BLOC'}) {
    debugPrint('🟣 [$tag] $message');
  }
}
