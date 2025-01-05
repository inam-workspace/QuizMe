import 'package:quiz_me/core/global/functions/validator.dart';
import 'package:quiz_me/main/imports.dart';

class ForgetPasswordProvider extends ChangeNotifier {
  Failure? _failure;
  Failure? get failure => _failure;
  set setFailure(Failure? fail) {
    _failure = fail;
    notifyListeners();
  }

  final emailController = TextEditingController();

  verify() async {
    final email = emailController.text;
    validateEmail(email);
    showProcessingDialog();
    final result = await GetAuth.instance.forgetPassword(email);
    result.fold(
      (fail) {
        setFailure = fail;
        Push.back();
      },
      (authModel) {
        showSuccessToast(
            'Success!!!', 'Rest link has been sent to your email address');
        Push.back();
      },
    );
  }
}
