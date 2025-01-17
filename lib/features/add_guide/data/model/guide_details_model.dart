import 'package:quiz_me/main/imports.dart';

@HiveType(typeId: 0)
class GuideDetailsModel extends HiveObject {
  @HiveField(0)
  final String guideId;
  @HiveField(1)
  final String authId;
  @HiveField(2)
  final String guideTitle;
  @HiveField(3)
  final List<ChapterDetailsEntity> chaptersDetail;
  @HiveField(4)
  final IconDetailsEntity iconDetails;
  @HiveField(5)
  final int dateTime;
  @HiveField(6)
  final double quizPercentage;
  @HiveField(7)
  final int quizAttempts;
  @HiveField(8)
  final double mockPercentage;
  @HiveField(9)
  final int mockAttempts;
  @HiveField(10)
  final double overallPercentage;

  GuideDetailsModel({
    required this.guideId,
    required this.authId,
    required this.guideTitle,
    required this.chaptersDetail,
    required this.iconDetails,
    required this.dateTime,
    required this.quizPercentage,
    required this.quizAttempts,
    required this.mockPercentage,
    required this.mockAttempts,
    required this.overallPercentage,
  });

  Map toJson() {
    return {
      "guide_id": guideId,
      "auth_id": authId,
      "guide_title": guideTitle,
      "chapters_detail":
          List<dynamic>.from(chaptersDetail.map((x) => x.toJson())),
      "icon_details": iconDetails.toJson(),
      "date_time": dateTime,
      "quiz_percentage": quizPercentage,
      "quiz_attempts": quizAttempts,
      "mock_percentage": mockPercentage,
      "mock_attempts": mockAttempts,
      "overall_percentage": overallPercentage,
    };
  }

  static GuideDetailsModel fromJson(Map json) {
    return GuideDetailsModel(
      guideId: json['guide_id'],
      authId: json['auth_id'],
      guideTitle: json['guide_title'],
      chaptersDetail: List<ChapterDetailsEntity>.from(
          json["chapters_detail"].map((x) => ChapterDetailsEntity.fromJson(x))),
      iconDetails: IconDetailsEntity.fromJson(json["icon_details"]),
      dateTime: json['date_time'],
      quizPercentage: json['quiz_percentage'].toDouble(),
      quizAttempts: json['quiz_attempts'].toInt(),
      mockPercentage: json['mock_percentage'].toDouble(),
      mockAttempts: json['mock_attempts'].toInt(),
      overallPercentage: json['overall_percentage'].toDouble(),
    );
  }
}

class GuideDetailsAdapter extends TypeAdapter<GuideDetailsModel> {
  @override
  final int typeId = 0;

  @override
  void write(BinaryWriter writer, GuideDetailsModel obj) {
    writer.writeMap({
      "auth_id": obj.authId,
      "guide_title": obj.guideTitle,
      "chapters_detail":
          List<dynamic>.from(obj.chaptersDetail.map((x) => x.toJson())),
      "icon_details": obj.iconDetails.toJson(),
      "date_time": obj.dateTime,
      "quiz_percentage": obj.quizPercentage,
      "quiz_attempts": obj.quizAttempts,
      "mock_percentage": obj.mockPercentage,
      "mock_attempts": obj.mockAttempts,
      "overall_percentage": obj.overallPercentage,
    });
  }

  @override
  GuideDetailsModel read(BinaryReader reader) {
    Map data = reader.readMap();

    final guideId = data['guide_id'];
    final authId = data['auth_id'];
    final guideTitle = data['guide_title'];
    final chaptersDetail = List<ChapterDetailsEntity>.from(
        data['chapters_detail'].map((x) => ChapterDetailsEntity.fromJson(x)));
    final iconDetails = IconDetailsEntity.fromJson(data["icon_details"]);
    final dateTime = data['date_time'];
    final quizPercentage = data['quiz_percentage'].toDouble();
    final quizAttempts = data['quiz_attempts'].toInt();
    final mockPercentage = data['mock_percentage'].toDouble();
    final mockAttempts = data['mock_attempts'].toInt();
    final overallPercentage = data['overall_percentage'].toDouble();

    return GuideDetailsModel(
      guideId: guideId,
      authId: authId,
      guideTitle: guideTitle,
      chaptersDetail: chaptersDetail,
      iconDetails: iconDetails,
      dateTime: dateTime,
      quizPercentage: quizPercentage,
      quizAttempts: quizAttempts,
      mockPercentage: mockPercentage,
      mockAttempts: mockAttempts,
      overallPercentage: overallPercentage,
    );
  }
}
