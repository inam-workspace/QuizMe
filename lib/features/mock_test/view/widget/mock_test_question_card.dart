import 'package:quiz_me/main/imports.dart';

class MockTestQuestionCard extends StatelessWidget {
  final MockTestType type;
  final int question;
  final MockTestModel mockTestModel;
  const MockTestQuestionCard({
    super.key,
    required this.type,
    required this.mockTestModel,
    required this.question,
  });

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: Theme.of(context).primaryColor,
        width: w(2),
      ),
    );
    return Consumer<AttemptMockTestProvider>(
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
              mockTestModel.question,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: h(10)),
            if (type == MockTestType.custom)
              TextFormField(
                readOnly: provider.reviewMode,
                controller: TextEditingController(
                  text: provider.selectedAnswers[question],
                ),
                maxLines: 4,
                onChanged: (value) {
                  provider.setAnswer(question, value);
                },
                cursorColor: Theme.of(context).primaryColor,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  hintText: 'Write answer here ..',
                  hintStyle: Theme.of(context).textTheme.labelLarge,
                  fillColor: Theme.of(context).cardColor,
                  border: border,
                  enabledBorder: border,
                  focusedBorder: border,
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                itemCount: mockTestModel.options.length,
                itemBuilder: (context, index) {
                  final isSelected = provider.selectedAnswers[question] ==
                      mockTestModel.options[index];
                  return Padding(
                    padding: gapSymmetric(vertical: 4),
                    child: RadioListTile(
                      activeColor: Theme.of(context).primaryColor,
                      fillColor: WidgetStatePropertyAll(
                          Theme.of(context).primaryColor),
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
                      value: mockTestModel.options[index],
                      groupValue: provider.selectedAnswers[question],
                      secondary: Text(
                        '${index + 1}.',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                      title: Text(
                        mockTestModel.options[index],
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
                  if (type == MockTestType.custom)
                    Container(
                      margin: gapSymmetric(vertical: 10),
                      padding: gapSymmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: provider.isApproximateAnswer(
                                provider.selectedAnswers[question]
                                    .toLowerCase()
                                    .trim(),
                                mockTestModel.acceptedKeywords)
                            ? Color(0xFFD9FFDB)
                            : Color(0xFFFFE2E1),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: provider.isApproximateAnswer(
                              provider.selectedAnswers[question]
                                  .toLowerCase()
                                  .trim(),
                              mockTestModel.acceptedKeywords)
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
                    )
                  else
                    Container(
                      margin: gapSymmetric(vertical: 10),
                      padding: gapSymmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: provider.selectedAnswers[question] ==
                                mockTestModel.answer
                            ? Color(0xFFD9FFDB)
                            : Color(0xFFFFE2E1),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: provider.selectedAnswers[question] ==
                              mockTestModel.answer
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
                    mockTestModel.explination,
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
