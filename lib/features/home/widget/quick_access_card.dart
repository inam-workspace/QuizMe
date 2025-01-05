import 'package:quiz_me/main/imports.dart';

class QuickAccessCard extends StatelessWidget {
  final Function() onPressed;
  final String title;
  final String subtitle;
  final String icon;
  final Color iconColor;
  const QuickAccessCard({
    super.key,
    required this.onPressed,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: gapAll(4.0),
      child: MaterialButton(
        padding: gapZero,
        color: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            width: w(1),
            color: Theme.of(context).hintColor.withOpacity(0.5),
          ),
        ),
        visualDensity: VisualDensity.compact,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minWidth: double.infinity,
        height: h(120),
        onPressed: onPressed,
        child: Padding(
          padding: gapSymmetric(horizontal: 12),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: h(20),
                      backgroundColor: iconColor.withOpacity(0.1),
                      child: SvgPicture.asset(
                        icon,
                        height: h(20),
                        colorFilter: ColorFilter.mode(
                          iconColor,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/icons/navigation.svg',
                      height: h(14),
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.scrim,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
