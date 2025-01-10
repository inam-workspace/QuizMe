import 'package:quiz_me/core/global/functions/validator.dart';
import 'package:quiz_me/main/imports.dart';

class RegistrationProvider extends ChangeNotifier {
  Failure? _failure;
  Failure? get failure => _failure;
  set setFailure(Failure? fail) {
    _failure = fail;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set setIsLoading(bool status) {
    _isLoading = status;
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
    setIsLoading = true;
    final result =
        await GetAuth.instance.signUpWithEmail(username, email, password);
    result.fold(
      (fail) {
        setIsLoading = false;
        setFailure = fail;
      },
      (authModel) async {
        final appProvider =
            Provider.of<AppController>(Push.context, listen: false);
        await GetAuth.instance.checkAuthState().then((User? user) async {
          if (user != null) {
            appProvider.setAndNotifyCurrentUser = user;
            appProvider.setAndNotifyAuthDetails = authModel;
            await AppController.instance.getUserStreak(
              user.uid,
              notify: true,
            );
            setIsLoading = false;
            Push.replace(route: '/dashboardScreen');
          }
        });
      },
    );
  }
}
