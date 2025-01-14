import 'package:quiz_me/main/imports.dart';

enum FooterType { login, register }

class AuthFooter extends StatelessWidget {
  final FooterType type;
  const AuthFooter({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (type == FooterType.login)
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Don’t have an account ?',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                TextSpan(text: '  '),
                TextSpan(
                  text: 'Sign Up',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Push.replace(route: '/registrationScreen');
                    },
                ),
              ],
            ),
          )
        else
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Already have an account ?',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                TextSpan(text: '  '),
                TextSpan(
                  text: 'Sign In',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Push.replace(route: '/loginScreen');
                    },
                ),
              ],
            ),
          ),
        Padding(
          padding: gapSymmetric(horizontal: 12, vertical: 20),
          child: Row(
            children: [
              Flexible(
                child: Divider(
                  thickness: h(1),
                  color: Theme.of(context).hintColor,
                  endIndent: w(12),
                  indent: w(20),
                ),
              ),
              Text(
                'Or Sign Up with',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              Flexible(
                child: Divider(
                  thickness: h(1),
                  color: Theme.of(context).hintColor,
                  endIndent: w(20),
                  indent: w(12),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: gapSymmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              Flexible(
                child: CustomButton(
                  width: double.infinity,
                  height: h(45),
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  elevation: 0,
                  border: BorderSide(
                    color: Theme.of(context).hintColor,
                    width: w(1),
                  ),
                  borderRadius: 10,
                  widget: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: SvgPicture.asset(
                            'assets/icons/google.svg',
                            height: h(20),
                          ),
                        ),
                        TextSpan(text: '   '),
                        TextSpan(
                          text: 'Google',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  onPressed: () {
                    signUpWithGmail();
                  },
                ),
              ),
              SizedBox(width: w(20)),
              Flexible(
                child: CustomButton(
                  width: double.infinity,
                  height: h(45),
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  elevation: 0,
                  border: BorderSide(
                    color: Theme.of(context).hintColor,
                    width: w(1),
                  ),
                  borderRadius: 10,
                  widget: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: SvgPicture.asset(
                            'assets/icons/apple.svg',
                            height: h(20),
                          ),
                        ),
                        TextSpan(text: '   '),
                        TextSpan(
                          text: 'Apple',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  onPressed: () {
                    signUpWithApple();
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  signUpWithGmail() async {
    showLoadingIndicator('Verifing your credentials');
    final result = await GetAuth.instance.signInWithGoogle();
    result.fold(
      (fail) {
        Push.back();
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
            Push.back();
            Push.replace(route: '/dashboardScreen');
          }
        });
      },
    );
  }

  signUpWithApple() async {
    showLoadingIndicator('Verifing your credentials');
    final result = await GetAuth.instance.signInWithApple();
    result.fold(
      (fail) {
        Push.back();
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
            Push.back();
            Push.replace(route: '/dashboardScreen');
          }
        });
      },
    );
  }
}
