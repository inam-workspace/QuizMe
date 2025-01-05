class ChapterDetailsEntity {
  final String id;
  final String title;
  final String content;
  ChapterDetailsEntity({
    required this.id,
    required this.content,
    required this.title,
  });

  Map toJson() {
    return {
      "id": id,
      "title": title,
      "content": content,
    };
  }

  static ChapterDetailsEntity fromJson(Map json) {
    return ChapterDetailsEntity(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
    );
  }
}


