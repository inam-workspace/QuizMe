class ChatEntity {
  String model = "gpt-3.5-turbo";
  List<ChatMessage> messages;
  double temperature = 0.75;

  ChatEntity({
    required this.messages,
  });

  factory ChatEntity.fromJson(Map<String, dynamic> json) => ChatEntity(
        messages: List<ChatMessage>.from(
            json["messages"].map((x) => ChatMessage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
        "temperature": temperature,
      };
}

class ChatMessage {
  final String role;
  final String content;

  ChatMessage({
    required this.role,
    required this.content,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
        role: json["role"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "role": role,
        "content": content,
      };
}
