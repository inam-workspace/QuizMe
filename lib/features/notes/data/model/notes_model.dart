import 'package:quiz_me/main/imports.dart';

@HiveType(typeId: 1)
class NotesModel extends HiveObject {
  @HiveField(0)
  final String contentID;
  @HiveField(1)
  final String description;

  NotesModel({required this.description, required this.contentID});

  factory NotesModel.fromJson(Map<String, dynamic> json) => NotesModel(
        contentID: json["content_id"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "content_id": contentID,
        "description": description,
      };
}



class NotesAdapter extends TypeAdapter<NotesModel> {
  @override
  final int typeId = 1;

  @override
  void write(BinaryWriter writer, NotesModel obj) {
    writer.writeMap({
      "content_id": obj.contentID,
      "description": obj.description,
    });
  }

  @override
  NotesModel read(BinaryReader reader) {
    Map data = reader.readMap();
    final contentID = data['content_id'];
    final description =data['description'];

    return NotesModel(
      contentID: contentID,
      description: description,
    );
  }
}
