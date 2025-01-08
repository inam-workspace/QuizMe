import 'package:quiz_me/main/imports.dart';

class AddChaptersPage extends StatelessWidget {
  const AddChaptersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddGuideProvider>(
      builder: (context, provider, child) {
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: List<Widget>.generate(provider.chapters.length, (index) {
                  final chapter = provider.chapters[index];
                  return AddChapterCard(
                    chapter: chapter,
                    provider: provider,
                    remove: index != 0
                        ? () => provider.removerChapter(index)
                        : null,
                  );
                }).toList() +
                [
                  Padding(
                    padding: gapSymmetric(vertical: 10, horizontal: 8),
                    child: CustomButton(
                      width: double.infinity,
                      elevation: 0,
                      borderRadius: 8,
                      backgroundColor: Theme.of(context).cardColor,
                      widget: Text('+ Add another chapter',
                          style: Theme.of(context).textTheme.bodyLarge),
                      height: h(50),
                      onPressed: () => provider.addChapter(),
                    ),
                  ),
                  Padding(
                    padding: gapSymmetric(vertical: 10, horizontal: 8),
                    child: CustomButton(
                      width: double.infinity,
                      borderRadius: 8,
                      backgroundColor: Theme.of(context).primaryColor,
                      widget: Text(
                        'Next',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                      ),
                      height: h(50),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        if (provider.chapters.any((e) =>
                            e.controller.text.isEmpty || e.content == '')) {
                          showWarningToast(
                            'Alert!!!',
                            'Chapter details must required*',
                          );
                        } else {
                          provider.next(2);
                        }
                      },
                    ),
                  ),
                ],
          ),
        );
      },
    );
  }
}
