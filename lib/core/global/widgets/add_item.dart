import 'package:quiz_me/main/imports.dart';

class AddItem extends StatelessWidget {
  final Function() onPressed;
  final String title;
  final String subtitle;
  const AddItem({
    super.key,
    required this.onPressed,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: gapAll(12.0),
      child: MaterialButton(
        elevation: 0,
        visualDensity: VisualDensity.compact,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: gapZero,
        onPressed: onPressed,
        height: h(200),
        minWidth: double.infinity,
        color: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            CircleAvatar(
              radius: h(30),
              backgroundColor: Theme.of(context).primaryColor,
              child: SvgPicture.asset(
                'assets/icons/empty_list.svg',
                height: h(25),
                colorFilter: ColorFilter.mode(
                  Theme.of(context).scaffoldBackgroundColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
      ),
    );
  }
}
