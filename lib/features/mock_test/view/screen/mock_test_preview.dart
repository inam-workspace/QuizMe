import 'package:quiz_me/main/imports.dart';

class MockTestPreview extends StatelessWidget {
  final GuideDetailsEntity guideDetails;
  final bool isRegenerate;
  const MockTestPreview({
    super.key,
    required this.guideDetails,
    this.isRegenerate = false,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MockTestPreviewProvider(),
      builder: (context, child) {
        return Consumer<MockTestPreviewProvider>(
          builder: (context, provider, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: h(10)),
                ContentTitle(
                  title: "Generate Mock Test",
                  subtitle: 'Select test for your assessments',
                ),
                SizedBox(height: h(10)),
                ListTile(
                  dense: true,
                  contentPadding: gapSymmetric(horizontal: 8),
                  leading: CircleAvatar(
                    radius: h(24),
                    backgroundColor:
                        getColor(guideDetails.iconDetails.iconColor)
                            .withOpacity(0.1),
                    child: SvgPicture.asset(
                      guideDetails.iconDetails.iconPath,
                      height: h(24),
                      colorFilter: ColorFilter.mode(
                        getColor(guideDetails.iconDetails.iconColor),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  title: Text(
                    guideDetails.guideTitle,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    '${guideDetails.chaptersDetail.length} Chapters',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  trailing: Stack(
                    children: [
                      CircularProgressIndicator(
                        value: guideDetails.mockPercentage,
                        strokeCap: StrokeCap.round,
                        backgroundColor:
                            getColor(guideDetails.iconDetails.iconColor)
                                .withOpacity(0.1),
                        color: getColor(guideDetails.iconDetails.iconColor),
                      ),
                      Positioned.fill(
                        child: Center(
                          child: Text(
                            "${(guideDetails.mockPercentage * 100).round()}%",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: getColor(
                                      guideDetails.iconDetails.iconColor),
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: h(10)),
                Padding(
                  padding: gapSymmetric(horizontal: 12),
                  child: Text(
                    'Select Test Options',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                Padding(
                  padding: gapAll(12),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: provider.testOptions.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: gapSymmetric(vertical: 4),
                        child: RadioListTile<MockTestType>(
                          activeColor: Theme.of(context).primaryColor,
                          fillColor: WidgetStatePropertyAll(
                              Theme.of(context).primaryColor),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          contentPadding: gapOnly(left: 12),
                          visualDensity: VisualDensity.compact,
                          tileColor: provider.testOptions[index] ==
                                  provider.currentType
                              ? Theme.of(context).cardColor
                              : Theme.of(context).scaffoldBackgroundColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: provider.testOptions[index] ==
                                      provider.currentType
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.1),
                              width: w(2),
                            ),
                          ),
                          controlAffinity: ListTileControlAffinity.trailing,
                          value: provider.testOptions[index],
                          groupValue: provider.currentType,
                          title: Text(
                            provider.testOptions[index] == MockTestType.mcq
                                ? "MCQs"
                                : provider.testOptions[index] ==
                                        MockTestType.statement
                                    ? "True/False"
                                    : "Written",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          onChanged: (value) {
                            provider.setCurrentType = value!;
                          },
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: gapSymmetric(vertical: 10, horizontal: 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Note",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '\u2022',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          SizedBox(width: w(10)),
                          Expanded(
                            child: Text(
                              "Mock test includes all chapters combined.",
                              maxLines: 2,
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '\u2022',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          SizedBox(width: w(10)),
                          Expanded(
                            child: Text(
                              "Make sure you prepare well for mock test.",
                              maxLines: 2,
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '\u2022',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          SizedBox(width: w(10)),
                          Expanded(
                            child: Text(
                              "You wont get answers explanation during mock.",
                              maxLines: 2,
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '\u2022',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          SizedBox(width: w(10)),
                          Expanded(
                            child: Text(
                              "You can review your score and results at the end of mock test.",
                              maxLines: 2,
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: h(20)),
                      CustomButton(
                        width: double.infinity,
                        borderRadius: 8,
                        backgroundColor: Theme.of(context).primaryColor,
                        widget: Text(
                          'Start',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                        ),
                        height: h(50),
                        onPressed: () {
                          if (isRegenerate) {
                            Push.back();
                            Push.back();
                          }
                          Push.replace(
                            route: '/attemptMockTestScreen',
                            arg: AttemptMockTestScreenArguments(
                              guideDetails: guideDetails,
                              type: provider.currentType,
                            ),
                          );
                        },
                      ),
                    ],
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
