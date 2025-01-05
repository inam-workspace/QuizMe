import 'package:quiz_me/utils/guide_details/logic/entities/chapter_details_entity.dart';
import 'package:quiz_me/utils/guide_details/logic/entities/icon_details_entity.dart';

class GuideDetailsEntity {
  final String guideTitle;
  final List<ChapterDetailsEntity> chaptersDetail;
  final IconDetailsEntity iconDetails;
  final DateTime dateTime;
  double quizPercentage;
  double mockPercentage;
  double overallPercentage;

  GuideDetailsEntity({
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

  static GuideDetailsEntity fromJson(Map json) {
    return GuideDetailsEntity(
      guideTitle: json['guide_title'] as String,
      chaptersDetail: List<ChapterDetailsEntity>.from(
          json["chapters_detail"].map((x) => ChapterDetailsEntity.fromJson(x))),
      iconDetails: IconDetailsEntity.fromJson(json["icon_details"]),
      dateTime: json['date_time'] as DateTime,
      quizPercentage: json['quiz_percentage'] as double,
      mockPercentage: json['mock_percentage'] as double,
      overallPercentage: json['overall_percentage'] as double,
    );
  }
}
