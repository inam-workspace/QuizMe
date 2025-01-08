import 'package:quiz_me/main/imports.dart';

abstract class GuideDetailsRepo {
  Future<Either<Failure, void>> addGuideDetail(
      {required GuideDetailsEntity data, required String id});

  Future<Either<Failure, List<GuideDetailsModel>>> getGuideDetail(
      {required String id});

  Future<Either<Failure, void>> updateGuideDetail(
      {required GuideDetailsEntity data, required String id});

  Future<Either<Failure, void>> deleteGuideDetail(
      {required GuideDetailsEntity data, required String id});

  Future<Either<Failure, String>> preProcessContent({
    required String content,
    required ChapterType type,
  });
}
