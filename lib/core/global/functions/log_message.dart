import 'package:flutter/material.dart';

logInfo(String message) {
  debugPrint('\x1B[34m[INFO] $message\x1B[0m');
}

logSuccess(String message) {
  debugPrint('\x1B[32m[SUCCESS] $message\x1B[0m');
}

logWarning(String message) {
  debugPrint('\x1B[33m[WARNING] $message\x1B[0m');
}

logError(String message) {
  debugPrint('\x1B[31m[ERROR] $message\x1B[0m');
}
