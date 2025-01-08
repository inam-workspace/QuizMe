import 'package:quiz_me/main/imports.dart';

class GetGuideDetails {
  final GuideDetailsRepo repository;
  GetGuideDetails(this.repository);

  Future<Either<Failure, void>> add(
      {required GuideDetailsEntity data, required String id}) {
    return repository.addGuideDetail(data: data, id: id);
  }

  Future<Either<Failure, List<GuideDetailsModel>>> get({required String id}) {
    return repository.getGuideDetail(id: id);
  }

  Future<Either<Failure, void>> update(
      {required GuideDetailsEntity data, required String id}) {
    return repository.updateGuideDetail(data: data, id: id);
  }

  Future<Either<Failure, void>> delete(
      {required GuideDetailsEntity data, required String id}) {
    return repository.deleteGuideDetail(data: data, id: id);
  }

  Future<Either<Failure, String>> preProcessContent(
      {required String content, required ChapterType type}) {
    return repository.preProcessContent(content: content, type: type);
  }
}
