class MockTestModel {
  final int id;
  final String question;
  final String answer;
  final String explination;
  final List<dynamic> options;
  final List<dynamic> acceptedKeywords;

  MockTestModel({
    required this.id,
    required this.question,
    required this.answer,
    required this.explination,
    List<dynamic>? options,
    List<dynamic>? acceptedKeywords,
  })  : options = options ?? List.empty(),
        acceptedKeywords = acceptedKeywords ?? List.empty();

  factory MockTestModel.fromJson(Map<String, dynamic> json) => MockTestModel(
        id: json["id"],
        question: json["question"],
        answer: json["answer"],
        explination: json["explination"],
        options: json["options"],
        acceptedKeywords: json["accepted_keywords"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "answer": answer,
        "explination": explination,
        "options": options,
        "accepted_keywords": acceptedKeywords,
      };
}
