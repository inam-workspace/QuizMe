import 'package:quiz_me/main/imports.dart';
import 'package:badges/badges.dart' as badges;

class LoggedInDetails extends StatelessWidget {
  const LoggedInDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppController>(
      builder: (context, appProvider, child) {
        final authDetails = appProvider.authDetails;
        return ListTile(
          minTileHeight: h(44),
          dense: true,
          contentPadding: gapZero,
          visualDensity: VisualDensity.compact,
          leading: badges.Badge(
            badgeStyle: badges.BadgeStyle(
              badgeColor: Colors.green,
              elevation: 0,
              padding: gapAll(7),
              borderSide: BorderSide(
                color: Theme.of(context).scaffoldBackgroundColor,
                width: w(2),
              ),
            ),
            position: badges.BadgePosition.bottomEnd(
              bottom: -h(5),
              end: -w(5),
            ),
            showBadge: true,
            child: Container(
              width: h(44),
              height: h(44),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: authDetails.photoURL == ''
                  ? Image.asset(
                      'assets/images/placeholder.jpg',
                      fit: BoxFit.cover,
                    )
                  : CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: authDetails.photoURL!,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Padding(
                        padding: gapAll(8),
                        child: CircularProgressIndicator(
                          value: downloadProgress.progress,
                          strokeWidth: w(2),
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
            ),
          ),
          title: Text(
            'Welcome Back!',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          subtitle: Text(
            authDetails.displayName!,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        );
      },
    );
  }
}
