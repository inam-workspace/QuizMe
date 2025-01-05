import 'package:quiz_me/main/imports.dart';

class ItemTile extends StatelessWidget {
  final Function() onPressed;
  final String title;
  final String subtitle;
  final String icon;
  final Color iconColor;
  final double percentage;
  const ItemTile({
    super.key,
    required this.onPressed,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: gapSymmetric(horizontal: 8.0, vertical: 4.0),
      child: MaterialButton(
        padding: gapZero,
        color: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: iconColor.withOpacity(0.1),
            width: w(2),
          ),
        ),
        visualDensity: VisualDensity.compact,
        onPressed: onPressed,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: ListTile(
          dense: true,
          contentPadding: gapSymmetric(horizontal: 8),
          leading: CircleAvatar(
            radius: h(24),
            backgroundColor: iconColor.withOpacity(0.1),
            child: SvgPicture.asset(
              icon,
              height: h(24),
              colorFilter: ColorFilter.mode(
                iconColor,
                BlendMode.srcIn,
              ),
            ),
          ),
          title: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            subtitle,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          trailing: Stack(
            children: [
              CircularProgressIndicator(
                value: percentage,
                strokeCap: StrokeCap.round,
                backgroundColor: iconColor.withOpacity(0.1),
                color: iconColor,
              ),
              Positioned.fill(
                child: Center(
                  child: Text(
                    "${(percentage * 100).round()}%",
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          fontWeight: FontWeight.w700,
                          color: iconColor,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
