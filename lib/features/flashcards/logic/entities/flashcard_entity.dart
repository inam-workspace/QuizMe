class FlashcardEntity {
  String model = "gpt-3.5-turbo";
  List<FlashcardMessage> messages;
  double temperature = 0.75;

  FlashcardEntity({
    required this.messages,
  });

  factory FlashcardEntity.fromJson(Map<String, dynamic> json) =>
      FlashcardEntity(
        messages: List<FlashcardMessage>.from(
            json["messages"].map((x) => FlashcardMessage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
        "temperature": temperature,
      };
}

class FlashcardMessage {
  final String role;
  final String content;

  FlashcardMessage({
    required this.role,
    required this.content,
  });

  factory FlashcardMessage.fromJson(Map<String, dynamic> json) =>
      FlashcardMessage(
        role: json["role"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "role": role,
        "content": content,
      };
}
