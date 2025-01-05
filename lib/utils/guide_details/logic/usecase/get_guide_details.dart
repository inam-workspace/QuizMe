import 'package:quiz_me/main/imports.dart';

class GetGuideDetails {
  final GuideDetailsRepo repository;
  GetGuideDetails(this.repository);

  Future<Either<Failure, void>> add({required GuideDetailsEntity data}) {
    return repository.addGuideDetail(data: data);
  }

  Future<Either<Failure, List<GuideDetailsModel>>> get() {
    return repository.getGuideDetail();
  }

  Future<Either<Failure, void>> update({required GuideDetailsEntity data}) {
    return repository.updateGuideDetail(data: data);
  }

  Future<Either<Failure, void>> delete({required GuideDetailsEntity data}) {
    return repository.deleteGuideDetail(data: data);
  }

  Future<Either<Failure, String>> preProcessContent(
      {required String content, required ChapterType type}) {
    return repository.preProcessContent(content: content, type: type);
  }
}
