import 'package:quiz_me/main/imports.dart';

class GuideDetailsRepoImpl implements GuideDetailsRepo {
  final GuideDetailsDataSource localDataSource = GuideDetailsSourceImpl();

  @override
  addGuideDetail({required GuideDetailsEntity data}) async {
    try {
      return Right(localDataSource.addGuideDetail(data: data));
    } on CacheFailure {
      return Left(CacheFailure(errorType: ErrorType.cache));
    }
  }

  @override
  deleteGuideDetail({required GuideDetailsEntity data}) async {
    try {
      return Right(localDataSource.deleteGuideDetail(data: data));
    } on CacheFailure {
      return Left(CacheFailure(errorType: ErrorType.cache));
    }
  }

  @override
  getGuideDetail() async {
    try {
      return Right(await localDataSource.getGuideDetail());
    } on CacheFailure {
      return Left(CacheFailure(errorType: ErrorType.cache));
    }
  }

  @override
  updateGuideDetail({required GuideDetailsEntity data}) async {
    try {
      return Right(localDataSource.updateGuideDetail(data: data));
    } on CacheFailure {
      return Left(CacheFailure(errorType: ErrorType.cache));
    }
  }

  @override
  preProcessContent(
      {required String content, required ChapterType type}) async {
    try {
      return Right(await localDataSource.preProcessContent(
          content: content, type: type));
    } on ServerFailure {
      return Left(ServerFailure(errorType: ErrorType.server));
    }
  }
}
