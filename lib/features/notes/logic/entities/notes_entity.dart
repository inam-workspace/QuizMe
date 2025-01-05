class NotesEntity {
  String model = "gpt-3.5-turbo";
  List<NotesMessage> messages;
  double temperature = 0.75;

  NotesEntity({
    required this.messages,
  });

  factory NotesEntity.fromJson(Map<String, dynamic> json) => NotesEntity(
        messages: List<NotesMessage>.from(
            json["messages"].map((x) => NotesMessage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
        "temperature": temperature,
      };
}

class NotesMessage {
  final String role;
  final String content;

  NotesMessage({
    required this.role,
    required this.content,
  });

  factory NotesMessage.fromJson(Map<String, dynamic> json) => NotesMessage(
        role: json["role"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "role": role,
        "content": content,
      };
}
