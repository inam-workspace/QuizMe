import 'package:quiz_me/features/drawer/provider/drawer_provider.dart';
import 'package:quiz_me/main/imports.dart';
import 'package:badges/badges.dart' as badges;

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    return ChangeNotifierProvider(
      create: (context) => DrawerProvider(),
      builder: (context, child) {
        return Consumer2<DrawerProvider, AppController>(
          builder: (context, provider, appProvider, child) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    badges.Badge(
                      badgeStyle: badges.BadgeStyle(
                        badgeColor: Theme.of(context).scaffoldBackgroundColor,
                        elevation: 10,
                      ),
                      badgeContent: InkWell(
                        onTap: () => provider.uploadProfile(),
                        child: Icon(
                          Icons.edit_outlined,
                          size: h(20),
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      position: badges.BadgePosition.bottomEnd(
                        bottom: h(5),
                        end: w(5),
                      ),
                      showBadge: true,
                      child: Container(
                        width: h(150),
                        height: h(150),
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              spreadRadius: 5,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: appProvider.authDetails.photoURL == '' ||
                                appProvider.authDetails.photoURL == null
                            ? Image.asset(
                                'assets/images/placeholder.jpg',
                                fit: BoxFit.cover,
                              )
                            : CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: appProvider.authDetails.photoURL!,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) => Padding(
                                  padding: gapAll(8),
                                  child: CircularProgressIndicator(
                                    value: downloadProgress.progress,
                                    strokeWidth: w(2),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                      ),
                    ),
                    SizedBox(height: h(20)),
                    Text(
                      appProvider.authDetails.displayName!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).scaffoldBackgroundColor),
                    ),
                    if (appProvider.streakModel != null)
                      Text(
                        appProvider.streakModel!.streak == 1
                            ? '1 Day Streak 🔥'
                            : '${appProvider.streakModel!.streak} Days Streak 🔥',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).scaffoldBackgroundColor),
                      ),
                    SizedBox(height: h(20)),
                  ],
                ),
                Consumer<DashboardProvider>(
                  builder: (context, dashProvider, child) {
                    return Container(
                      padding: gapSymmetric(horizontal: 16, vertical: 8),
                      margin: gapAll(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            contentPadding: gapZero,
                            onTap: () {},
                            leading: SvgPicture.asset(
                              'assets/icons/setting.svg',
                              height: h(20),
                              colorFilter: ColorFilter.mode(
                                Theme.of(context).scaffoldBackgroundColor,
                                BlendMode.srcIn,
                              ),
                            ),
                            title: Text(
                              'Account Setting',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor),
                            ),
                          ),
                          ListTile(
                            contentPadding: gapZero,
                            onTap: () {},
                            leading: SvgPicture.asset(
                              'assets/icons/ticket.svg',
                              height: h(20),
                              colorFilter: ColorFilter.mode(
                                Theme.of(context).scaffoldBackgroundColor,
                                BlendMode.srcIn,
                              ),
                            ),
                            title: Text(
                              'Subscription',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor),
                            ),
                          ),
                          ListTile(
                            contentPadding: gapZero,
                            onTap: () {
                              dashProvider.drawerController.hideDrawer();
                              Push.to(route: '/faqsScreen');
                            },
                            leading: SvgPicture.asset(
                              'assets/icons/info.svg',
                              height: h(20),
                              colorFilter: ColorFilter.mode(
                                Theme.of(context).scaffoldBackgroundColor,
                                BlendMode.srcIn,
                              ),
                            ),
                            title: Text(
                              "FAQ's",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor),
                            ),
                          ),
                          ListTile(
                            contentPadding: gapZero,
                            onTap: () {
                              dashProvider.drawerController.hideDrawer();
                              provider.privacyPolicy();
                            },
                            leading: SvgPicture.asset(
                              'assets/icons/privacy.svg',
                              height: h(20),
                              colorFilter: ColorFilter.mode(
                                Theme.of(context).scaffoldBackgroundColor,
                                BlendMode.srcIn,
                              ),
                            ),
                            title: Text(
                              'Privacy Policy',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Padding(
                  padding: gapSymmetric(vertical: 20, horizontal: 16),
                  child: CustomButton(
                    width: double.infinity,
                    borderRadius: 8,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    widget: RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: SvgPicture.asset(
                              'assets/icons/logout.svg',
                              colorFilter: ColorFilter.mode(
                                Theme.of(context).primaryColor,
                                BlendMode.srcIn,
                              ),
                              height: h(20),
                            ),
                          ),
                          TextSpan(text: '   '),
                          TextSpan(
                            text: 'Logout',
                            style: Theme.of(context).primaryTextTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                    height: h(50),
                    onPressed: () async {
                      await GetAuth.instance.logout();
                      Push.replace(route: '/loginScreen');
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
