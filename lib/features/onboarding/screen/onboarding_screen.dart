import 'package:quiz_me/features/onboarding/provider/onboarding_provider.dart';
import 'package:quiz_me/features/onboarding/widgets/build_dot.dart';
import 'package:quiz_me/features/onboarding/widgets/onboarding_card.dart';
import 'package:quiz_me/main/imports.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OnboardingProvider(),
      builder: (context, child) {
        return Consumer<OnboardingProvider>(
          builder: (context, provider, child) {
            return Scaffold(
              body: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    width: double.infinity,
                    child: PageView(
                      controller: provider.controller,
                      onPageChanged: (index) => provider.setPage = index,
                      children: [
                        OnboardingCard(),
                        OnboardingCard(),
                        OnboardingCard(),
                        OnboardingCard(),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      4,
                      (index) => buildDot(context, index, provider.page),
                    ),
                  ),
                  Padding(
                    padding: gapSymmetric(vertical: 50, horizontal: 12),
                    child: Row(
                      children: [
                        Flexible(
                          child: CustomButton(
                            width: double.infinity,
                            borderRadius: 8,
                            backgroundColor: Theme.of(context).cardColor,
                            elevation: 0,
                            widget: Text(
                              'Skip',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            height: h(50),
                            onPressed: () {
                              provider.clearOnboarding();
                              Push.replace(route: '/loginScreen');
                            },
                          ),
                        ),
                        SizedBox(width: w(10)),
                        Flexible(
                          child: CustomButton(
                            width: double.infinity,
                            borderRadius: 8,
                            backgroundColor: Theme.of(context).primaryColor,
                            widget: Text(
                              'Next',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  ),
                            ),
                            height: h(50),
                            onPressed: () => provider.nextPage(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
