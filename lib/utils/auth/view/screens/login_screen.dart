import 'package:quiz_me/main/imports.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        width: w(1),
        color: Theme.of(context).hintColor,
      ),
    );
    final enableBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        width: w(1),
        color: Theme.of(context).primaryColor,
      ),
    );
    return ChangeNotifierProvider(
      create: (context) => LoginProvider(),
      builder: (context, child) {
        return Consumer<LoginProvider>(
          builder: (context, provider, child) {
            return Scaffold(
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: h(100)),
                    AuthHeader(
                      title: "Welcome back!",
                      subtitle: "Please enter your details to get Sign In",
                    ),
                    Padding(
                      padding: gapSymmetric(horizontal: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: h(20)),
                          TextFormField(
                            controller: provider.emailController,
                            autofillHints: [AutofillHints.email],
                            cursorColor: Theme.of(context).primaryColor,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            style: Theme.of(context).textTheme.bodyLarge,
                            decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              hintText: 'Email',
                              hintStyle: Theme.of(context).textTheme.labelLarge,
                              fillColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              border: border,
                              enabledBorder: border,
                              focusedBorder: enableBorder,
                              contentPadding: gapSymmetric(horizontal: 12),
                              prefixIcon: Padding(
                                padding: gapAll(14.0),
                                child: SvgPicture.asset(
                                  'assets/icons/mail.svg',
                                  colorFilter: ColorFilter.mode(
                                    Theme.of(context).colorScheme.scrim,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: h(10)),
                          TextFormField(
                            controller: provider.passwordController,
                            autofillHints: [AutofillHints.password],
                            obscureText: !provider.showPassword,
                            cursorColor: Theme.of(context).primaryColor,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            style: Theme.of(context).textTheme.bodyLarge,
                            decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              hintText: 'Password',
                              hintStyle: Theme.of(context).textTheme.labelLarge,
                              fillColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              border: border,
                              enabledBorder: border,
                              focusedBorder: enableBorder,
                              contentPadding: gapSymmetric(horizontal: 12),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  provider.toggleShowPassword();
                                },
                                icon: provider.showPassword
                                    ? SvgPicture.asset(
                                        'assets/icons/visible.svg',
                                        height: h(15),
                                        colorFilter: ColorFilter.mode(
                                          Theme.of(context).colorScheme.scrim,
                                          BlendMode.srcIn,
                                        ),
                                      )
                                    : SvgPicture.asset(
                                        'assets/icons/invisible.svg',
                                        height: h(20),
                                        colorFilter: ColorFilter.mode(
                                          Theme.of(context).colorScheme.scrim,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                              ),
                              prefixIcon: Padding(
                                padding: gapAll(14.0),
                                child: SvgPicture.asset(
                                  'assets/icons/privacy.svg',
                                  colorFilter: ColorFilter.mode(
                                    Theme.of(context).colorScheme.scrim,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: h(275),
                      child: provider.isLoading
                          ? Center(
                              child: Image.asset(
                                'assets/animation/loading.gif',
                                height: h(50),
                              ),
                            )
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: gapSymmetric(horizontal: 20),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      onPressed: () {
                                        Push.to(route: '/forgetPasswordScreen');
                                      },
                                      child: Text(
                                        'Forgot Password?',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: gapSymmetric(horizontal: 20),
                                  child: CustomButton(
                                    width: double.infinity,
                                    borderRadius: 10,
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    widget: Text(
                                      'Login',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                          ),
                                    ),
                                    height: h(50),
                                    onPressed: () {
                                      FocusScope.of(context).unfocus();
                                      provider.loginWithEmail();
                                    },
                                  ),
                                ),
                                SizedBox(height: h(20)),
                                AuthFooter(type: FooterType.login),
                              ],
                            ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
