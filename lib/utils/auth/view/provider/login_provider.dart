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
    showLoadingIndicator('while verifing your credentials');
    final result = await GetAuth.instance.loginWithEmail(email, password);
    result.fold(
      (fail) {
        Push.back();
        setFailure = fail;
      },
      (authModel) async {
        final appProvider =
            Provider.of<AppController>(Push.context, listen: false);
        await GetAuth.instance.checkAuthState().then(
          (User? user) async {
            if (user != null) {
              appProvider.setAndNotifyCurrentUser = user;
              appProvider.setAndNotifyAuthDetails = authModel;
              await AppController.instance.getUserStreak(
                user.uid,
                notify: true,
              );
              Push.back();
              Push.replace(route: '/dashboardScreen');
            }
          },
        );
      },
    );
  }
}
