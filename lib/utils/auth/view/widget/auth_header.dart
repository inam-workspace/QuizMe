import 'package:quiz_me/main/imports.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  const AuthHeader({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/text_logo.svg',
            height: h(35),
            colorFilter: ColorFilter.mode(
              Theme.of(context).primaryColor,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(height: h(20)),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: h(10)),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          SizedBox(height: h(20)),
        ],
      ),
    );
  }
}
