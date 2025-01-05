import 'package:quiz_me/main/imports.dart';

validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    showWarningToast('Alert!!!', 'Email is required*');
    return;
  }
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!emailRegex.hasMatch(value)) {
    showWarningToast('Alert!!!', 'Enter a valid email address');
    return;
  }
}

validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    showWarningToast('Alert!!!', 'Password is required*');
    return;
  }
  if (value.length < 8) {
    showWarningToast('Alert!!!', 'Password must be at least 8 characters');
    return;
  }
  if (!RegExp(r'[A-Z]').hasMatch(value)) {
    showWarningToast(
        'Alert!!!', 'Password must include at least one uppercase letter');
    return;
  }
  if (!RegExp(r'[0-9]').hasMatch(value)) {
    showWarningToast('Alert!!!', 'Password must include at least one number');
    return;
  }
  if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
    showWarningToast(
        'Alert!!!', 'Password must include at least one special character');
    return;
  }
}

validateConfirmPassword(String? value, String password) {
  if (value == null || value.isEmpty) {
    showWarningToast('Alert!!!', 'Confirm password is required');
    return;
  }
  if (value != password) {
    showWarningToast('Alert!!!', 'Passwords do not match');
    return;
  }
}

validateUsername(String? value) {
  if (value == null || value.isEmpty) {
    showWarningToast('Alert!!!', 'Username is required*');
    return;
  }
  if (value.length < 3 || value.length > 15) {
    showWarningToast('Alert!!!', 'Username must be between 3 and 15 characters');
    return;
  }
}
