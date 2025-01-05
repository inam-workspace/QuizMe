import 'package:quiz_me/main/imports.dart';

@HiveType(typeId: 0)
class GuideDetailsModel extends HiveObject {
  @HiveField(0)
  final String guideTitle;
  @HiveField(1)
  final List<ChapterDetailsEntity> chaptersDetail;
  @HiveField(2)
  final IconDetailsEntity iconDetails;
  @HiveField(3)
  final DateTime dateTime;
  @HiveField(4)
  final double quizPercentage;
  @HiveField(5)
  final double mockPercentage;
  @HiveField(6)
  final double overallPercentage;

  GuideDetailsModel({
    required this.guideTitle,
    required this.chaptersDetail,
    required this.iconDetails,
    required this.dateTime,
    required this.quizPercentage,
    required this.mockPercentage,
    required this.overallPercentage,
  });

  Map toJson() {
    return {
      "guide_title": guideTitle,
      "chapters_detail":
          List<dynamic>.from(chaptersDetail.map((x) => x.toJson())),
      "icon_details": iconDetails.toJson(),
      "date_time": dateTime,
      "quiz_percentage": quizPercentage,
      "mock_percentage": mockPercentage,
      "overall_percentage": overallPercentage,
    };
  }

  static GuideDetailsModel fromJson(Map json) {
    return GuideDetailsModel(
      guideTitle: json['guide_title'],
      chaptersDetail: List<ChapterDetailsEntity>.from(
          json["chapters_detail"].map((x) => ChapterDetailsEntity.fromJson(x))),
      iconDetails: IconDetailsEntity.fromJson(json["icon_details"]),
      dateTime: json['date_time'],
      quizPercentage: json['quiz_percentage'],
      mockPercentage: json['mock_percentage'],
      overallPercentage: json['overall_percentage'],
    );
  }
}

class GuideDetailsAdapter extends TypeAdapter<GuideDetailsModel> {
  @override
  final int typeId = 0;

  @override
  void write(BinaryWriter writer, GuideDetailsModel obj) {
    writer.writeMap({
      "guide_title": obj.guideTitle,
      "chapters_detail":
          List<dynamic>.from(obj.chaptersDetail.map((x) => x.toJson())),
      "icon_details": obj.iconDetails.toJson(),
      "date_time": obj.dateTime,
      "quiz_percentage": obj.quizPercentage,
      "mock_percentage": obj.mockPercentage,
      "overall_percentage": obj.overallPercentage,
    });
  }

  @override
  GuideDetailsModel read(BinaryReader reader) {
    Map data = reader.readMap();
    final guideTitle = data['guide_title'];
    final chaptersDetail = List<ChapterDetailsEntity>.from(
        data['chapters_detail'].map((x) => ChapterDetailsEntity.fromJson(x)));
    final iconDetails = IconDetailsEntity.fromJson(data["icon_details"]);
    final dateTime = data['date_time'];
    final quizPercentage = data['quiz_percentage'];
    final mockPercentage = data['mock_percentage'];
    final overallPercentage = data['overall_percentage'];

    return GuideDetailsModel(
      guideTitle: guideTitle,
      chaptersDetail: chaptersDetail,
      iconDetails: iconDetails,
      dateTime: dateTime,
      quizPercentage: quizPercentage,
      mockPercentage: mockPercentage,
      overallPercentage: overallPercentage,
    );
  }
}
