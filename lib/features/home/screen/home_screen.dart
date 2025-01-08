import 'package:quiz_me/main/imports.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Consumer2<AddGuideProvider, AppController>(
      builder: (context, provider, appProvider, child) {
        final streakModel = appProvider.streakModel;
        return Column(
          children: [
            AppBar(
              primary: true,
              toolbarHeight: h(64),
              automaticallyImplyLeading: false,
              title: LoggedInDetails(),
              actions: [
                Padding(
                  padding: gapAll(10),
                  child: Consumer<DashboardProvider>(
                    builder: (context, provider, child) {
                      return CustomButton(
                        elevation: 0,
                        width: h(44),
                        height: h(44),
                        widget: SvgPicture.asset(
                          'assets/icons/menu.svg',
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).colorScheme.scrim,
                            BlendMode.srcIn,
                          ),
                        ),
                        onPressed: () async {
                          provider.drawerController.showDrawer();
                        },
                        backgroundColor: Theme.of(context).cardColor,
                        borderRadius: 10,
                      );
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: provider.loading
                  ? Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/animation/loading.gif',
                          height: h(75),
                        ),
                      ],
                    )
                  : SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (streakModel != null)
                            Padding(
                              padding: gapAll(8.0),
                              child: ListTile(
                                contentPadding: gapSymmetric(horizontal: 8.0),
                                tileColor: Theme.of(context).cardColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                leading: CircleAvatar(
                                  radius: h(22),
                                  backgroundColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  child: Text('🔥'),
                                ),
                                title: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: streakModel.streak == 1
                                            ? '1 Day'
                                            : '${streakModel.streak} Days',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                      TextSpan(
                                        text: ' Streak',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                    ],
                                  ),
                                ),
                                trailing: CircleAvatar(
                                  radius: h(18),
                                  backgroundColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  child: SvgPicture.asset(
                                    'assets/icons/navigation.svg',
                                    height: h(12),
                                    colorFilter: ColorFilter.mode(
                                      Theme.of(context).primaryColor,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          if (provider.guideList.isNotEmpty)
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ContentTitle(
                                  title: 'Quick Access',
                                  subtitle:
                                      'Quick access to your study assessments',
                                ),
                                Padding(
                                  padding: gapAll(4.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Flexible(
                                            child: QuickAccessCard(
                                              onPressed: () {
                                                showBlurredBarBottomSheet(
                                                  useRootNavigator: true,
                                                  elevation: 10,
                                                  backgroundColor: Theme.of(
                                                          context)
                                                      .scaffoldBackgroundColor,
                                                  barrierColor:
                                                      Theme.of(context)
                                                          .colorScheme
                                                          .scrim
                                                          .withOpacity(0.25),
                                                  context: context,
                                                  builder: (context) {
                                                    return StudyGuidesSheet(
                                                        type: ActionType.quiz);
                                                  },
                                                );
                                              },
                                              title: 'Take Quiz',
                                              subtitle: '20 questions',
                                              icon: 'assets/icons/quiz.svg',
                                              iconColor: Color(0xFF6A5AE0),
                                            ),
                                          ),
                                          Flexible(
                                            child: QuickAccessCard(
                                              onPressed: () {
                                                showBlurredBarBottomSheet(
                                                  useRootNavigator: true,
                                                  elevation: 10,
                                                  backgroundColor: Theme.of(
                                                          context)
                                                      .scaffoldBackgroundColor,
                                                  barrierColor:
                                                      Theme.of(context)
                                                          .colorScheme
                                                          .scrim
                                                          .withOpacity(0.25),
                                                  context: context,
                                                  builder: (context) {
                                                    return StudyGuidesSheet(
                                                        type: ActionType
                                                            .flashcards);
                                                  },
                                                );
                                              },
                                              title: 'Flashcards',
                                              subtitle: '20 flashcards',
                                              icon:
                                                  'assets/icons/flash_card.svg',
                                              iconColor: Color(0xFF7FC665),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Flexible(
                                            child: QuickAccessCard(
                                              onPressed: () {
                                                showBlurredBarBottomSheet(
                                                  useRootNavigator: true,
                                                  elevation: 10,
                                                  backgroundColor: Theme.of(
                                                          context)
                                                      .scaffoldBackgroundColor,
                                                  barrierColor:
                                                      Theme.of(context)
                                                          .colorScheme
                                                          .scrim
                                                          .withOpacity(0.25),
                                                  context: context,
                                                  builder: (context) {
                                                    return StudyGuidesSheet(
                                                        type: ActionType.notes);
                                                  },
                                                );
                                              },
                                              title: 'Notes',
                                              subtitle: 'chapter notes',
                                              icon: 'assets/icons/notes.svg',
                                              iconColor: Color(0xFFFE8B57),
                                            ),
                                          ),
                                          Flexible(
                                            child: QuickAccessCard(
                                              onPressed: () {
                                                showBlurredBarBottomSheet(
                                                  useRootNavigator: true,
                                                  elevation: 10,
                                                  backgroundColor: Theme.of(
                                                          context)
                                                      .scaffoldBackgroundColor,
                                                  barrierColor:
                                                      Theme.of(context)
                                                          .colorScheme
                                                          .scrim
                                                          .withOpacity(0.25),
                                                  context: context,
                                                  builder: (context) {
                                                    return StudyGuidesSheet(
                                                        type: ActionType.mock);
                                                  },
                                                );
                                              },
                                              title: 'Mock Test',
                                              subtitle: 'study guide mock',
                                              icon: 'assets/icons/guide.svg',
                                              iconColor: Color(0xFF4FABFD),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          if (provider.guideList.isNotEmpty)
                            Padding(
                              padding: gapAll(8.0),
                              child: ListTile(
                                onTap: () {
                                  Push.to(
                                    route: '/addStudyGuide',
                                    arg: AddGuideArguments(),
                                  );
                                },
                                contentPadding: gapSymmetric(horizontal: 8.0),
                                tileColor: Theme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                leading: CircleAvatar(
                                  radius: h(22),
                                  backgroundColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  child: SvgPicture.asset(
                                    'assets/icons/add_study.svg',
                                    height: h(26),
                                    colorFilter: ColorFilter.mode(
                                      Theme.of(context).primaryColor,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  'Create Study Guide',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                      ),
                                ),
                                trailing: CircleAvatar(
                                  radius: h(18),
                                  backgroundColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  child: SvgPicture.asset(
                                    'assets/icons/navigation.svg',
                                    height: h(12),
                                    colorFilter: ColorFilter.mode(
                                      Theme.of(context).colorScheme.scrim,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          if (provider.guideList.isEmpty)
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ContentTitle(
                                  title: 'Your Study Guides',
                                  subtitle:
                                      'Quick access to your study assessments',
                                ),
                                AddItem(
                                  onPressed: () {
                                    Push.to(
                                      route: '/addStudyGuide',
                                      arg: AddGuideArguments(),
                                    );
                                  },
                                  title: 'Your Study Guide',
                                  subtitle: 'Select subject you want to study',
                                ),
                              ],
                            )
                          else
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ContentTitle(
                                  title: 'My Study Guides',
                                  subtitle:
                                      'Quick access to your study assessments',
                                ),
                                ListView.builder(
                                  padding: gapZero,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: provider.guideList.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    final guide = provider.guideList[index];
                                    return ItemTile(
                                      percentage: guide.overallPercentage,
                                      onPressed: () {
                                        showBlurredBarBottomSheet(
                                          useRootNavigator: true,
                                          elevation: 10,
                                          backgroundColor: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          barrierColor: Theme.of(context)
                                              .colorScheme
                                              .scrim
                                              .withOpacity(0.25),
                                          context: context,
                                          builder: (context) {
                                            return ContentSheet(guide: guide);
                                          },
                                        );
                                      },
                                      title: guide.guideTitle,
                                      subtitle:
                                          '${guide.chaptersDetail.length} Chapters',
                                      icon: guide.iconDetails.iconPath,
                                      iconColor:
                                          getColor(guide.iconDetails.iconColor),
                                    );
                                  },
                                ),
                              ],
                            ),
                          SizedBox(height: h(10)),
                        ],
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }
}
