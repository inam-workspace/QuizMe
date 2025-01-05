import 'package:quiz_me/core/global/functions/validator.dart';
import 'package:quiz_me/main/imports.dart';

class ForgetPasswordProvider extends ChangeNotifier {
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

  final emailController = TextEditingController();

  verify() async {
    final email = emailController.text;
    validateEmail(email);
    setIsLoading = true;
    final result = await GetAuth.instance.forgetPassword(email);
    result.fold(
      (fail) {
        setFailure = fail;
        setIsLoading = false;
      },
      (authModel) {
        showSuccessToast(
            'Success!!!', 'Rest link has been sent to your email address');
        setIsLoading = false;
      },
    );
  }
}
