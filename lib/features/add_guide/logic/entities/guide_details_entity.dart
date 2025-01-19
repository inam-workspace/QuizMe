import 'package:quiz_me/main/imports.dart';

class GuideDetailsEntity {
  final String guideId;
  final String authId;
  final String guideTitle;
  final List<ChapterDetailsEntity> chaptersDetail;
  final IconDetailsEntity iconDetails;
  final int dateTime;
  double quizPercentage;
  int quizAttempts;
  double mockPercentage;
  int mockAttempts;
  double overallPercentage;

  GuideDetailsEntity({
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

  static GuideDetailsEntity fromJson(Map json) {
    return GuideDetailsEntity(
      guideId: json['guide_id'] as String,
      authId: json['auth_id'] as String,
      guideTitle: json['guide_title'] as String,
      chaptersDetail: List<ChapterDetailsEntity>.from(
          json["chapters_detail"].map((x) => ChapterDetailsEntity.fromJson(x))),
      iconDetails: IconDetailsEntity.fromJson(json["icon_details"]),
      dateTime: (json['date_time'] as int),
      quizPercentage: json['quiz_percentage'] as double,
      quizAttempts: json['quiz_attempts'] as int,
      mockPercentage: json['mock_percentage'] as double,
      mockAttempts: json['mock_attempts'] as int,
      overallPercentage: json['overall_percentage'] as double,
    );
  }
}
