import 'package:quiz_me/main/imports.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: h(20)),
        CircleAvatar(
          radius: h(60),
          backgroundColor: Theme.of(context).cardColor,
          child: Text(
            '🎉',
            style: TextStyle(
              fontSize: t(50),
            ),
          ),
        ),
        SizedBox(height: h(20)),
        Text(
          'Enjoy!!!',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        SizedBox(height: h(10)),
        Text(
          'Your study guide is ready. Lets get\nstarted with learning',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        SizedBox(height: h(20)),
        Padding(
          padding: gapSymmetric(vertical: 10, horizontal: 12),
          child: CustomButton(
            width: double.infinity,
            borderRadius: 8,
            backgroundColor: Theme.of(context).primaryColor,
            widget: Text(
              'Start Studying',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
            ),
            height: h(50),
            onPressed: () {
              Push.back();
            },
          ),
        ),
        SizedBox(height: h(20)),
      ],
    );
  }
}
