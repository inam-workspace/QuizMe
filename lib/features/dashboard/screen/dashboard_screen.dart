import 'package:quiz_me/main/imports.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DashboardProvider>(
      create: (context) => DashboardProvider(),
      builder: (context, child) {
        return Consumer<DashboardProvider>(
          builder: (context, provider, child) {
            List<Widget> pages = [
              HomeScreen(),
              StudyGuideScreen(),
              QuizScreen(),
              MockTestScreen()
            ];
            return AdvancedDrawer(
              backdrop: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: AppColors.gradient,
                ),
              ),
              controller: provider.drawerController,
              animationCurve: Curves.easeInOut,
              animationDuration: const Duration(milliseconds: 375),
              animateChildDecoration: true,
              rtlOpening: true,
              disabledGestures: false,
              childDecoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              drawer: DrawerScreen(),
              child: Scaffold(
                body: PageView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  controller: provider.pageController,
                  itemCount: pages.length,
                  itemBuilder: (context, index) {
                    return pages[index];
                  },
                ),
                bottomNavigationBar: SizedBox(
                  height: h(60),
                  child: BottomNavigationBar(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    currentIndex: provider.currentIndex,
                    onTap: (value) => provider.setCurrentIndex = value,
                    type: BottomNavigationBarType.fixed,
                    selectedFontSize: t(10),
                    unselectedFontSize: t(10),
                    elevation: 15,
                    iconSize: h(24),
                    selectedItemColor: Theme.of(context).primaryColor,
                    unselectedItemColor: Theme.of(context).hintColor,
                    selectedLabelStyle: TextStyle(
                      fontWeight: FontWeight.w700,
                      height: h(1.6),
                    ),
                    unselectedLabelStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      height: h(1.6),
                    ),
                    showUnselectedLabels: true,
                    items: [
                      BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                          'assets/icons/home.svg',
                          colorFilter: ColorFilter.mode(
                            provider.currentIndex == 0
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).hintColor,
                            BlendMode.srcIn,
                          ),
                        ),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                          'assets/icons/guide.svg',
                          colorFilter: ColorFilter.mode(
                            provider.currentIndex == 1
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).hintColor,
                            BlendMode.srcIn,
                          ),
                        ),
                        label: 'Guide',
                      ),
                      BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                          'assets/icons/quiz.svg',
                          colorFilter: ColorFilter.mode(
                            provider.currentIndex == 2
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).hintColor,
                            BlendMode.srcIn,
                          ),
                        ),
                        label: 'Quiz',
                      ),
                      BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                          'assets/icons/test.svg',
                          colorFilter: ColorFilter.mode(
                            provider.currentIndex == 3
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).hintColor,
                            BlendMode.srcIn,
                          ),
                        ),
                        label: 'Test',
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
