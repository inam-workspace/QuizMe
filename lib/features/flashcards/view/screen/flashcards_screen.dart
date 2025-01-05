import 'package:quiz_me/main/imports.dart';

class FlashcardsScreenArguments {
  final GuideDetailsEntity guideDetails;
  final String chapter;
  FlashcardsScreenArguments({
    required this.guideDetails,
    required this.chapter,
  });
}

class FlashcardsScreen extends StatelessWidget {
  const FlashcardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments!
        as FlashcardsScreenArguments;
    return ChangeNotifierProvider(
      create: (context) => FlashcardsProvider(
          guideDetails: args.guideDetails, chapter: args.chapter),
      builder: (context, child) {
        return Consumer<FlashcardsProvider>(
          builder: (context, provider, child) {
            return Scaffold(
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
                  'Flashcards',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              body: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: provider.results.isEmpty
                    ? Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/animation/loading.gif',
                            height: h(75),
                          ),
                          Text(
                            'Hang tight!\nwe’re putting together your Flashcard.',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ListTile(
                            title: Text(
                              args.guideDetails.guideTitle,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            subtitle: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Swipe left: ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: 'Confused',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  TextSpan(text: '  '),
                                  TextSpan(
                                    text: 'Swipe right: ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: 'Learned',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                            trailing: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Theme.of(context).primaryColor,
                              ),
                              padding: gapSymmetric(horizontal: 8, vertical: 4),
                              child: RichText(
                                text: TextSpan(
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                      ),
                                  children: [
                                    TextSpan(
                                      text: '${provider.currentIndex}',
                                    ),
                                    TextSpan(text: '/'),
                                    TextSpan(
                                      text: '${provider.results.length}',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          FlashcardSwapper(
                            title: args.chapter,
                            swipeEnd: provider.swipeEnd,
                            onEnd: provider.onEnd,
                          ),
                        ],
                      ),
              ),
            );
          },
        );
      },
    );
  }
}
