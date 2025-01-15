import 'package:quiz_me/features/notes/view/screen/notes_preview.dart';
import 'package:quiz_me/main/imports.dart';

class ContentSheetProvider extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  set setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}

class ContentSheet extends StatelessWidget {
  final GuideDetailsEntity guide;
  const ContentSheet({super.key, required this.guide});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ContentSheetProvider(),
      builder: (context, child) {
        return Consumer<ContentSheetProvider>(
          builder: (context, provider, child) {
            return Padding(
              padding: gapAll(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ContentTitle(
                    title: guide.guideTitle,
                    subtitle: 'Guide Options',
                  ),
                  ListView.builder(
                    padding: gapZero,
                    itemCount: 3,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Padding(
                          padding: gapAll(8.0),
                          child: ListTile(
                            onTap: () {
                              provider.setCurrentIndex = 0;
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                color: provider.currentIndex == 0
                                    ? Color(0xFF7FC665)
                                    : Color(0xFF7FC665).withOpacity(0.1),
                              ),
                            ),
                            contentPadding: gapSymmetric(horizontal: 8.0),
                            leading: CircleAvatar(
                              radius: h(22),
                              backgroundColor:
                                  Color(0xFF7FC665).withOpacity(0.1),
                              child: SvgPicture.asset(
                                'assets/icons/flash_card.svg',
                                height: h(24),
                                colorFilter: ColorFilter.mode(
                                  Color(0xFF7FC665),
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                            title: Text(
                              'View Flashcards',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            trailing: Padding(
                              padding: gapSymmetric(horizontal: 8.0),
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
                        );
                      } else if (index == 1) {
                        return Padding(
                          padding: gapAll(8.0),
                          child: ListTile(
                            onTap: () {
                              provider.setCurrentIndex = 1;
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                width: w(1),
                                color: provider.currentIndex == 1
                                    ? Color(0xFFFE8B57)
                                    : Color(0xFFFE8B57).withOpacity(0.1),
                              ),
                            ),
                            contentPadding: gapSymmetric(horizontal: 8.0),
                            leading: CircleAvatar(
                              radius: h(22),
                              backgroundColor:
                                  Color(0xFFFE8B57).withOpacity(0.1),
                              child: SvgPicture.asset(
                                'assets/icons/notes.svg',
                                height: h(24),
                                colorFilter: ColorFilter.mode(
                                  Color(0xFFFE8B57),
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                            title: Text(
                              'View Notes',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            trailing: Padding(
                              padding: gapSymmetric(horizontal: 8.0),
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
                        );
                      } else {
                        return Padding(
                          padding: gapAll(8.0),
                          child: ListTile(
                            onTap: () {
                              provider.setCurrentIndex = 2;
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                width: w(1),
                                color: provider.currentIndex == 2
                                    ? AppColors.primary
                                    : AppColors.primary.withOpacity(0.1),
                              ),
                            ),
                            contentPadding: gapSymmetric(horizontal: 8.0),
                            leading: CircleAvatar(
                              radius: h(22),
                              backgroundColor:
                                  AppColors.primary.withOpacity(0.1),
                              child: SvgPicture.asset(
                                'assets/icons/edit.svg',
                                height: h(24),
                                colorFilter: ColorFilter.mode(
                                  AppColors.primary,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                            title: Text(
                              'Edit Study Guide',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            trailing: Padding(
                              padding: gapSymmetric(horizontal: 8.0),
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
                        );
                      }
                    },
                  ),
                  Padding(
                    padding: gapSymmetric(vertical: 10, horizontal: 8),
                    child: CustomButton(
                      width: double.infinity,
                      borderRadius: 8,
                      backgroundColor: Theme.of(context).primaryColor,
                      widget: Text(
                        'Continue',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                      ),
                      height: h(50),
                      onPressed: () {
                        Push.back();
                        if (provider.currentIndex == 0) {
                          showCustomDialog(
                              content: FlashcardsPreview(guideDetails: guide));
                        } else if (provider.currentIndex == 1) {
                          showCustomDialog(
                              content: NotesPreview(guideDetails: guide));
                        } else {
                          // Push.to(
                          //   route: '/addStudyGuide',
                          //   arg: AddGuideArguments(guideDetails: guide),
                          // );
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
