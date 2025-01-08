import 'package:quiz_me/main/imports.dart';

class AddGuideArguments {
  final GuideDetailsEntity? guideDetails;
  AddGuideArguments({
    this.guideDetails,
  });
}

class AddGuideScreen extends StatelessWidget {
  const AddGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments! as AddGuideArguments;

    return Consumer<AddGuideProvider>(
      builder: (context, provider, child) {
        if (args.guideDetails != null) {
          provider.initilize(args.guideDetails!);
        }
        return PopScope(
          canPop: true,
          onPopInvokedWithResult: (didPop, result) {
            provider.reset();
          },
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Push.back();
                },
                icon: SvgPicture.asset(
                  'assets/icons/back.svg',
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.scrim,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              centerTitle: true,
              title: Text(
                'Create Study Guide',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            body: Column(
              children: [
                Padding(
                  padding: gapAll(10),
                  child: Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          color: Theme.of(context).primaryColor,
                          backgroundColor: Theme.of(context).cardColor,
                          value: (provider.currentIndex + 1) / 3,
                          borderRadius: BorderRadius.circular(10),
                          minHeight: h(10),
                        ),
                      ),
                      Padding(
                        padding: gapSymmetric(horizontal: 8.0),
                        child: RichText(
                          text: TextSpan(
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.w600),
                            children: [
                              TextSpan(
                                text: (provider.currentIndex + 1).toString(),
                              ),
                              TextSpan(
                                text: '/',
                              ),
                              TextSpan(
                                text: '3',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: gapAll(12),
                    child: PageView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: provider.pageController,
                      onPageChanged: (index) =>
                          provider.setCurrentIndex = index,
                      padEnds: true,
                      children: [
                        NameGuidePage(),
                        AddChaptersPage(),
                        SetIconPage(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
