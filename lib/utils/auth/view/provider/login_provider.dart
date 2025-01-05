import 'package:quiz_me/core/global/functions/validator.dart';
import 'package:quiz_me/main/imports.dart';

class LoginProvider extends ChangeNotifier {
  Failure? _failure;
  Failure? get failure => _failure;
  set setFailure(Failure? fail) {
    _failure = fail;
    notifyListeners();
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _showPassword = false;
  bool get showPassword => _showPassword;
  toggleShowPassword() {
    _showPassword = !showPassword;
    notifyListeners();
  }

  Future<void> loginWithEmail() async {
    final email = emailController.text;
    final password = passwordController.text;
    validateEmail(email);
    validatePassword(password);

    showProcessingDialog();
    final result = await GetAuth.instance.loginWithEmail(email, password);
    result.fold(
      (fail) {
        setFailure = fail;
        Push.back();
      },
      (authModel) {
        AppController.instance.setAuthDetails = authModel;
        Push.back();
        Push.replace(route: '/dashboardScreen');
      },
    );
  }
}
