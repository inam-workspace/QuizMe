import 'package:quiz_me/main/imports.dart';

class FlashcardsPreview extends StatelessWidget {
  final GuideDetailsEntity guideDetails;
  final bool isRegenerate;
  const FlashcardsPreview({
    super.key,
    required this.guideDetails,
    this.isRegenerate = false,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          FlashcardsPreviewProvider(guideDetails: guideDetails),
      builder: (context, child) {
        return Consumer<FlashcardsPreviewProvider>(
          builder: (context, provider, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: h(10)),
                ContentTitle(
                  title: "Generate Flashcards",
                  subtitle: 'Select chapter for your assessments',
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
                        value: guideDetails.overallPercentage,
                        strokeCap: StrokeCap.round,
                        backgroundColor:
                            getColor(guideDetails.iconDetails.iconColor)
                                .withOpacity(0.1),
                        color: getColor(guideDetails.iconDetails.iconColor),
                      ),
                      Positioned.fill(
                        child: Center(
                          child: Text(
                            "${(guideDetails.overallPercentage * 100).round()}%",
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
                    'Select Chapter',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                Padding(
                  padding: gapAll(12),
                  child: DropdownButtonFormField(
                    value: provider.currentChapter,
                    isExpanded: true,
                    items: provider.dropdownList,
                    onChanged: (value) => provider.setCurrentChapter = value,
                    style: Theme.of(context).textTheme.bodyMedium,
                    dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                    icon: Icon(
                      Icons.arrow_drop_down_rounded,
                      color: Theme.of(context).colorScheme.scrim,
                      size: h(30),
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.all(12),
                      filled: true,
                      hintText: 'Select Chapter',
                      hintStyle: Theme.of(context).textTheme.labelLarge,
                      fillColor: Theme.of(context).cardColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: gapSymmetric(vertical: 10, horizontal: 12),
                  child: CustomButton(
                    width: double.infinity,
                    borderRadius: 8,
                    backgroundColor: Theme.of(context).primaryColor,
                    widget: Text(
                      'Start',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                    ),
                    height: h(50),
                    onPressed: () {
                      if (isRegenerate) {
                        Push.back();
                        Push.back();
                      }
                      Push.replace(
                        route: '/flashcardsScreen',
                        arg: FlashcardsScreenArguments(
                          guideDetails: guideDetails,
                          chapter: provider.currentChapter,
                        ),
                      );
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
