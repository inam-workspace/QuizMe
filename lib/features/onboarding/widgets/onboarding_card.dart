import 'package:quiz_me/main/imports.dart';

class OnboardingCard extends StatelessWidget {
  const OnboardingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight * 0.8,
      width: double.infinity,
      child: Column(
        children: [
          Container(
            height: screenHeight * 0.6,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: AppColors.gradient,
            ),
            child: Padding(
              padding: gapOnly(top: 75),
              child: Image.asset('assets/images/onboard_1.png'),
            ),
          ),
          Spacer(),
          Text(
            'Title Goes here',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: h(10)),
          Padding(
            padding: gapSymmetric(horizontal: 20),
            child: Text(
              'lorem ipsem is a dummy text. lorem ipsem is a dummy text. lorem ipsem is a dummy text. lorem ipsem is a dummy text.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
