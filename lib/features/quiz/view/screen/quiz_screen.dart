import 'package:quiz_me/main/imports.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: BorderSide(
        width: w(2),
        color: Theme.of(context).primaryColor,
      ),
    );
    return Consumer<AddGuideProvider>(
      builder: (context, provider, child) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            gradient: AppColors.gradient,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: h(40)),
              Container(
                height: h(150),
                margin: gapAll(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: h(70),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Quizzes',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  fontSize: t(24),
                                ),
                          ),
                          Text(
                            'Quick access to your study assessments',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor
                                          .withOpacity(0.75),
                                    ),
                          ),
                        ],
                      ),
                    ),
                    TextFormField(
                      controller: provider.searchController,
                      cursorColor: Theme.of(context).scaffoldBackgroundColor,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.search,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                      decoration: InputDecoration(
                        isDense: true,
                        filled: true,
                        fillColor:
                            Theme.of(context).primaryColor.withOpacity(0.4),
                        border: border,
                        enabledBorder: border,
                        focusedBorder: border,
                        prefixIcon: Padding(
                          padding: gapAll(14.0),
                          child: SvgPicture.asset(
                            'assets/icons/search.svg',
                            colorFilter: ColorFilter.mode(
                              Theme.of(context).scaffoldBackgroundColor,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        if (provider.guideList.isEmpty)
                          AddItem(
                            onPressed: () {
                              Push.to(route: '/addStudyGuide',
                                arg: AddGuideArguments(),
                              );
                            },
                            title: 'You do not have any quiz yet.',
                            subtitle:
                                'Add study guide to create\nquiz for you.',
                          )
                        else
                          ListView.builder(
                            padding: gapSymmetric(vertical: 10),
                            itemCount: provider.guideList.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final guide = provider.guideList[index];
                              return ItemTile(
                                percentage: guide.quizPercentage,
                                onPressed: () {
                                  showCustomDialog(
                                      content:
                                          QuizPreview(guideDetails: guide));
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
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
