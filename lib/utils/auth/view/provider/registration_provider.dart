import 'package:quiz_me/core/global/functions/validator.dart';
import 'package:quiz_me/main/imports.dart';

class RegistrationProvider extends ChangeNotifier {
  Failure? _failure;
  Failure? get failure => _failure;
  set setFailure(Failure? fail) {
    _failure = fail;
    notifyListeners();
  }

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confPasswordController = TextEditingController();

  bool _showPassword = false;
  bool get showPassword => _showPassword;
  toggleShowPassword() {
    _showPassword = !showPassword;
    notifyListeners();
  }

  bool _showConfirmPassword = false;
  bool get showConfirmPassword => _showConfirmPassword;
  toggleShowConfirmPassword() {
    _showConfirmPassword = !showConfirmPassword;
    notifyListeners();
  }

  Future<void> signUpWithEmail() async {
    final email = emailController.text;
    final username = usernameController.text;
    final password = passwordController.text;
    final confPassword = confPasswordController.text;
    validateEmail(email);
    validateUsername(username);
    validatePassword(password);
    validateConfirmPassword(confPassword, password);
    showLoadingIndicator('while we set up your profile');
    final result =
        await GetAuth.instance.signUpWithEmail(username, email, password);
    result.fold(
      (fail) {
        Push.back();
        setFailure = fail;
      },
      (authModel) async {
        final appProvider =
            Provider.of<AppController>(Push.context, listen: false);
        appProvider.setAndNotifyAuthDetails = authModel;
        await appProvider
            .getUserStreak(authModel.uid!, notify: true)
            .then((value) {
          Push.back();
          Push.replace(route: '/dashboardScreen');
        });
      },
    );
  }
}
