import 'package:quiz_me/main/imports.dart';

class AttemptMockTestScreenArguments {
  final GuideDetailsEntity guideDetails;
  final MockTestType type;
  AttemptMockTestScreenArguments({
    required this.guideDetails,
    required this.type,
  });
}

class AttemptMockTestScreen extends StatelessWidget {
  const AttemptMockTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments!
        as AttemptMockTestScreenArguments;
    return ChangeNotifierProvider(
      create: (context) => AttemptMockTestProvider(
        guideDetails: args.guideDetails,
        type: args.type,
      ),
      builder: (context, child) {
        return Consumer<AttemptMockTestProvider>(
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
                  '${args.guideDetails.guideTitle} Mock Test',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: gapAll(10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: LinearProgressIndicator(
                                    color: Theme.of(context).primaryColor,
                                    backgroundColor:
                                        Theme.of(context).cardColor,
                                    value: (provider.currentIndex + 1) /
                                        provider.results.length,
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
                                          .copyWith(
                                              fontWeight: FontWeight.w600),
                                      children: [
                                        TextSpan(
                                          text: (provider.currentIndex + 1)
                                              .toString(),
                                        ),
                                        TextSpan(
                                          text: '/',
                                        ),
                                        TextSpan(
                                          text: '${provider.results.length}',
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
                              child: PageView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                controller: provider.pageController,
                                itemCount: provider.results.length,
                                onPageChanged: (index) =>
                                    provider.setCurrentIndex = index,
                                padEnds: true,
                                itemBuilder: (context, index) {
                                  final model = provider.results[index];
                                  return MockTestQuestionCard(
                                    type: provider.type,
                                    mockTestModel: model,
                                    question: index,
                                  );
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: gapSymmetric(vertical: 50, horizontal: 12),
                            child: Row(
                              children: [
                                if (provider.reviewMode &&
                                    provider.currentIndex > 0)
                                  Flexible(
                                    child: CustomButton(
                                      width: double.infinity,
                                      borderRadius: 8,
                                      backgroundColor:
                                          Theme.of(context).cardColor,
                                      elevation: 0,
                                      widget: Text(
                                        'Back',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                      height: h(50),
                                      onPressed: () => provider.back(),
                                    ),
                                  ),
                                if (provider.reviewMode &&
                                    provider.currentIndex > 0)
                                  SizedBox(width: w(10)),
                                Flexible(
                                  child: CustomButton(
                                    width: double.infinity,
                                    borderRadius: 8,
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    widget: Text(
                                      'Next',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                          ),
                                    ),
                                    height: h(50),
                                    onPressed: () => provider.next(context),
                                  ),
                                ),
                              ],
                            ),
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
