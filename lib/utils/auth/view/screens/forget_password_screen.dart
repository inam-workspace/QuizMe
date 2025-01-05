import 'package:quiz_me/main/imports.dart';
import 'package:quiz_me/utils/auth/view/provider/forget_password_provider.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

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
      create: (context) => ForgetPasswordProvider(),
      builder: (context, child) {
        return Consumer<ForgetPasswordProvider>(
          builder: (context, provider, child) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Push.back();
                  },
                  icon: SvgPicture.asset(
                    'assets/icons/back.svg',
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.scrim,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: h(10)),
                    AuthHeader(
                      title: "Forget Password ?",
                      subtitle:
                          "Please enter your registered email to proceed.",
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
                            textInputAction: TextInputAction.done,
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
                        ],
                      ),
                    ),
                    Padding(
                      padding: gapSymmetric(horizontal: 20),
                      child:  provider.isLoading
                          ? Image.asset(
                              'assets/animation/loading.gif',
                             height: h(50),
                            )
                          : CustomButton(
                        width: double.infinity,
                        borderRadius: 10,
                        backgroundColor: Theme.of(context).primaryColor,
                        widget: Text(
                          'Verify',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                        ),
                        height: h(50),
                        onPressed: () => provider.verify(),
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
