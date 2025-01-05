import 'package:quiz_me/features/notes/view/screen/notes_preview.dart';
import 'package:quiz_me/main/imports.dart';

enum ActionType { quiz, flashcards, notes, mock }

class StudyGuidesSheet extends StatelessWidget {
  final ActionType type;
  const StudyGuidesSheet({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddGuideProvider>(
      builder: (context, provider, child) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: screenHeight * 0.75,
          ),
          child: Padding(
            padding: gapSymmetric(horizontal: 12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ContentTitle(
                  title: type == ActionType.quiz
                      ? 'Quiz'
                      : type == ActionType.mock
                          ? 'Mock Test'
                          : type == ActionType.flashcards
                              ? 'Flashcards'
                              : 'Notes',
                  subtitle: 'Select study guide for your assessments',
                ),
                SizedBox(height: h(20)),
                ListView.builder(
                  padding: gapZero,
                  itemCount: provider.guideList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final guide = provider.guideList[index];
                    return ItemTile(
                      percentage: type == ActionType.quiz
                          ? guide.quizPercentage
                          : type == ActionType.mock
                              ? guide.mockPercentage
                              : guide.overallPercentage,
                      onPressed: () {
                        Push.back();
                        if (type == ActionType.quiz) {
                          showCustomDialog(
                              content: QuizPreview(guideDetails: guide));
                        } else if (type == ActionType.flashcards) {
                          showCustomDialog(
                              content: FlashcardsPreview(guideDetails: guide));
                        } else if (type == ActionType.notes) {
                          showCustomDialog(
                              content: NotesPreview(guideDetails: guide));
                        } else {
                          showCustomDialog(
                              content: MockTestPreview(guideDetails: guide));
                        }
                      },
                      title: guide.guideTitle,
                      subtitle: '${guide.chaptersDetail.length} Chapters',
                      icon: guide.iconDetails.iconPath,
                      iconColor: getColor(guide.iconDetails.iconColor),
                    );
                  },
                ),
                SizedBox(height: h(20)),
              ],
            ),
          ),
        );
      },
    );
  }
}
