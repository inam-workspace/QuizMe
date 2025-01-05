import 'package:quiz_me/main/imports.dart';

abstract class GuideDetailsRepo {
  Future<Either<Failure, void>> addGuideDetail(
      {required GuideDetailsEntity data});

  Future<Either<Failure, List<GuideDetailsModel>>> getGuideDetail();

  Future<Either<Failure, void>> updateGuideDetail(
      {required GuideDetailsEntity data});

  Future<Either<Failure, void>> deleteGuideDetail(
      {required GuideDetailsEntity data});

  Future<Either<Failure, String>> preProcessContent(
      {required String content, required ChapterType type});
}
