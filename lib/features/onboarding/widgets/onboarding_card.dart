import 'package:quiz_me/main/imports.dart';

class OnboardingCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  const OnboardingCard(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.image});

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
              child: Image.asset(image),
            ),
          ),
          Spacer(),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: h(10)),
          Padding(
            padding: gapSymmetric(horizontal: 20),
            child: Text(
              subtitle,
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
