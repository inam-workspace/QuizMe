import 'package:quiz_me/main/imports.dart';

class NotesScreenArguments {
  final GuideDetailsEntity guideDetails;
  final String contentID;

  NotesScreenArguments({
    required this.guideDetails,
    required this.contentID,
  });
}

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments! as NotesScreenArguments;
    return ChangeNotifierProvider(
      create: (context) => NotesProvider(
        guideDetails: args.guideDetails,
        contentID: args.contentID,
      ),
      builder: (context, child) {
        return Consumer<NotesProvider>(
          builder: (context, provider, child) {
            return Scaffold(
              appBar: AppBar(
                forceMaterialTransparency: true,
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
                  'Notes',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                actions: [
                  IconButton(
                    onPressed: () => provider.shareNotes(),
                    icon: SvgPicture.asset(
                      'assets/icons/replay.svg',
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).primaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),
              body: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: provider.result == null
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
                    : Padding(
                        padding: gapSymmetric(horizontal: 12),
                        child: Markdown(
                          controller: ScrollController(),
                          physics: BouncingScrollPhysics(),
                          data: provider.result!.description,
                          styleSheetTheme: MarkdownStyleSheetBaseTheme.material,
                          styleSheet: MarkdownStyleSheet(
                            h1: Theme.of(context).textTheme.titleLarge,
                            h2: Theme.of(context).textTheme.titleMedium,
                            h3: Theme.of(context).textTheme.titleSmall,
                            p: Theme.of(context).textTheme.bodyMedium,
                            strong: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                            listBullet: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ),
              ),
              floatingActionButton: provider.result == null
                  ? null
                  : CustomButton(
                      width: w(175),
                      height: h(50),
                      borderRadius: 14,
                      backgroundColor: Theme.of(context).primaryColor,
                      widget: RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: Text(
                                'Chat With Notes  ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                    ),
                              ),
                            ),
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: SvgPicture.asset(
                                'assets/icons/send.svg',
                                colorFilter: ColorFilter.mode(
                                  Theme.of(context).scaffoldBackgroundColor,
                                  BlendMode.srcIn,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      onPressed: () {
                        Push.to(
                          route: '/chatScreen',
                          arg: ChatScreenArguments(
                            topic: provider.chapterDetails,
                          ),
                        );
                      },
                    ),
            );
          },
        );
      },
    );
  }
}
