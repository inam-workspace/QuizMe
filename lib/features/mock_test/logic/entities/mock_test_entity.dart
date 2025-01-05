class MockTestEntity {
  String model = "gpt-3.5-turbo";
  List<MockTestMessage> messages;
  double temperature = 0.75;

  MockTestEntity({
    required this.messages,
  });

  factory MockTestEntity.fromJson(Map<String, dynamic> json) => MockTestEntity(
        messages: List<MockTestMessage>.from(
            json["messages"].map((x) => MockTestMessage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
        "temperature": temperature,
      };
}

class MockTestMessage {
  final String role;
  final String content;

  MockTestMessage({
    required this.role,
    required this.content,
  });

  factory MockTestMessage.fromJson(Map<String, dynamic> json) => MockTestMessage(
        role: json["role"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "role": role,
        "content": content,
      };
}
