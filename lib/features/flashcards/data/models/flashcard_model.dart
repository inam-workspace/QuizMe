class FlashcardModel {
  final int id;
  final String question;
  final String answer;

  FlashcardModel({
    required this.id,
    required this.question,
    required this.answer,
  });

  factory FlashcardModel.fromJson(Map<String, dynamic> json) => FlashcardModel(
        id: json["id"],
        question: json["question"],
        answer: json["answer"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "answer": answer,
      };
}
