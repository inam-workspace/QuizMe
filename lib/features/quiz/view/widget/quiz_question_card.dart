import 'package:quiz_me/main/imports.dart';

class QuizQuestionCard extends StatelessWidget {
  final int question;
  final QuizModel quizModel;
  const QuizQuestionCard({
    super.key,
    required this.quizModel,
    required this.question,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AttemptQuizProvider>(
      builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Question No. ${question + 1}',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Text(
              quizModel.question,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: h(10)),
            ListView.builder(
              shrinkWrap: true,
              itemCount: quizModel.options.length,
              itemBuilder: (context, index) {
                final isSelected = provider.selectedAnswers[question] ==
                    quizModel.options[index];
                return Padding(
                  padding: gapSymmetric(vertical: 4),
                  child: RadioListTile(
                    activeColor: Theme.of(context).primaryColor,
                    fillColor:
                        WidgetStatePropertyAll(Theme.of(context).primaryColor),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    contentPadding: gapSymmetric(horizontal: 12),
                    visualDensity: VisualDensity.compact,
                    tileColor: isSelected
                        ? Theme.of(context).cardColor
                        : Theme.of(context).scaffoldBackgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: isSelected
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).primaryColor.withOpacity(0.1),
                        width: w(2),
                      ),
                    ),
                    controlAffinity: ListTileControlAffinity.trailing,
                    value: quizModel.options[index],
                    groupValue: provider.selectedAnswers[question],
                    secondary: Text(
                      '${index + 1}.',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    title: Text(
                      quizModel.options[index],
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    onChanged: (value) {
                      if (provider.reviewMode) return;
                      provider.setAnswer(question, value!);
                    },
                  ),
                );
              },
            ),
            if (provider.reviewMode)
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: gapSymmetric(vertical: 10),
                    padding: gapSymmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color:
                          provider.selectedAnswers[question] == quizModel.answer
                              ? Color(0xFFD9FFDB)
                              : Color(0xFFFFE2E1),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child:
                        provider.selectedAnswers[question] == quizModel.answer
                            ? Text(
                                'Correct',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Color(0xFF4CAF50)),
                              )
                            : Text(
                                'Wrong',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Color(0xFFFF0000)),
                              ),
                  ),
                  Text(
                    'Explanation',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    quizModel.explination,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
          ],
        );
      },
    );
  }
}
