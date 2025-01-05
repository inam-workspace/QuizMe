class QuizModel {
  final int id;
  final String question;
  final String answer;
  final String explination;
  final List<dynamic> options;

  QuizModel({
    required this.id,
    required this.question,
    required this.answer,
    required this.explination,
    required this.options,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
        id: json["id"],
        question: json["question"],
        answer: json["answer"],
        explination: json["explination"],
        options: json["options"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "answer": answer,
        "explination": explination,
        "options": options,
      };
}
