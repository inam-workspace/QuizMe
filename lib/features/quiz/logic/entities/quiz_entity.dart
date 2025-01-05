class QuizEntity {
  String model = "gpt-3.5-turbo";
  List<QuizMessage> messages;
  double temperature = 0.75;

  QuizEntity({
    required this.messages,
  });

  factory QuizEntity.fromJson(Map<String, dynamic> json) => QuizEntity(
        messages: List<QuizMessage>.from(
            json["messages"].map((x) => QuizMessage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
        "temperature": temperature,
      };
}

class QuizMessage {
  final String role;
  final String content;

  QuizMessage({
    required this.role,
    required this.content,
  });

  factory QuizMessage.fromJson(Map<String, dynamic> json) => QuizMessage(
        role: json["role"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "role": role,
        "content": content,
      };
}
