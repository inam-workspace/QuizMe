import 'package:quiz_me/main/imports.dart';

class FlashcardsScoreSheetArguments {
  final GuideDetailsEntity guideDetails;
  final int learned;
  final int total;
  FlashcardsScoreSheetArguments({
    required this.guideDetails,
    required this.learned,
    required this.total,
  });
}

class FlashcardsScoreSheet extends StatelessWidget {
  const FlashcardsScoreSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments!
        as FlashcardsScoreSheetArguments;
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            args.guideDetails.guideTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: h(10)),
            Container(
              margin: gapAll(20),
              padding: gapAll(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Theme.of(context).cardColor,
              ),
              child: Column(
                children: [
                  SizedBox(height: h(20)),
                  Text(
                    'Flashcard Result',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: t(20)),
                  ),
                  SizedBox(height: h(30)),
                  Stack(
                    children: [
                      SizedBox(
                        width: w(125),
                        height: w(125),
                        child: CircularProgressIndicator(
                          value: args.learned / args.total,
                          strokeWidth: w(10),
                          strokeCap: StrokeCap.round,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          color: Color(0xFF7FC665),
                        ),
                      ),
                      Positioned.fill(
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: args.learned.toString(),
                                    style:
                                        Theme.of(context).textTheme.titleLarge),
                                TextSpan(
                                  text: '/',
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                                TextSpan(
                                    text: args.total.toString(),
                                    style:
                                        Theme.of(context).textTheme.labelLarge),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: h(30)),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        child: Container(
                          height: h(100),
                          width: double.infinity,
                          padding: gapAll(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color(0xFFFE8B57),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${args.total - args.learned}".toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          fontSize: t(30),
                                        ),
                                  ),
                                  SvgPicture.asset(
                                    'assets/icons/wrong.svg',
                                    height: h(25),
                                    colorFilter: ColorFilter.mode(
                                      Theme.of(context).scaffoldBackgroundColor,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "Confused",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: w(10)),
                      Flexible(
                        child: Container(
                          height: h(100),
                          width: double.infinity,
                          padding: gapAll(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color(0xFF7FC665),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${args.learned}".toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          fontSize: t(30),
                                        ),
                                  ),
                                  SvgPicture.asset(
                                    'assets/icons/correct.svg',
                                    height: h(25),
                                    colorFilter: ColorFilter.mode(
                                      Theme.of(context).scaffoldBackgroundColor,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "Learned",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: gapSymmetric(horizontal: 20),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: CustomButton(
                      width: double.infinity,
                      borderRadius: 8,
                      elevation: 0,
                      backgroundColor: Theme.of(context).cardColor,
                      widget: Text(
                        'Go Home',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      height: h(50),
                      onPressed: () {
                        Push.back();
                        Push.back();
                      },
                    ),
                  ),
                  SizedBox(width: w(10)),
                  Flexible(
                    child: CustomButton(
                      width: double.infinity,
                      borderRadius: 8,
                      elevation: 0,
                      backgroundColor: Theme.of(context).primaryColor,
                      widget: Text(
                        'Restart',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                      ),
                      height: h(50),
                      onPressed: () {
                        // Push.back(result: 'review');
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: gapAll(20),
              child: CustomButton(
                width: double.infinity,
                borderRadius: 8,
                elevation: 0,
                border: BorderSide(
                    width: w(1), color: Theme.of(context).primaryColor),
                backgroundColor: Theme.of(context).cardColor,
                widget: Text(
                  'Generate New Flashcards',
                  style: Theme.of(context).primaryTextTheme.bodyLarge,
                ),
                height: h(50),
                onPressed: () {
                  showCustomDialog(
                    content: FlashcardsPreview(guideDetails: args.guideDetails),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
