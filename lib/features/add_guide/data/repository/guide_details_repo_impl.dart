import 'package:quiz_me/main/imports.dart';

class GuideDetailsRepoImpl implements GuideDetailsRepo {
  final GuideDetailsLocalSource _localDataSource =
      GuideDetailsLocalSourceImpl();
  final GuideDetailsRemoteSource _remoteDataSource =
      GuideDetailsRemoteSourceImpl();

  final appProvider = Provider.of<AppController>(Push.context, listen: false);

  @override
  addGuideDetail({required GuideDetailsEntity data, required String id}) async {
    try {
      if (_localDataSource.containsData(id: id)) {
        _localDataSource.updateGuideDetail(data: data);
      } else {
        _localDataSource.addGuideDetail(data: data);
      }
      return Right(await _remoteDataSource.addGuideDetail(data: data, id: id));
    } on CacheException {
      return Left(CacheFailure(errorType: ErrorType.cache));
    } on FireException {
      return Left(FireFailure(errorType: ErrorType.firebase));
    }
  }

  @override
  deleteGuideDetail(
      {required GuideDetailsEntity data, required String id}) async {
    try {
      _localDataSource.deleteGuideDetail(data: data);
      return Right(
          await _remoteDataSource.deleteGuideDetail(data: data, id: id));
    } on CacheException {
      return Left(CacheFailure(errorType: ErrorType.cache));
    } on FireException {
      return Left(FireFailure(errorType: ErrorType.firebase));
    }
  }

  @override
  getGuideDetail({required String id}) async {
    try {
      if (_localDataSource.containsData(id: id)) {
        return Right(await _localDataSource.getGuideDetail());
      } else {
        final data = await _remoteDataSource.getGuideDetail(id: id);
        for (var element in data) {
          _localDataSource.addGuideDetail(
              data: GuideDetailsEntity.fromJson(element.toJson()));
        }
        return Right(data);
      }
    } on CacheException {
      return Left(CacheFailure(errorType: ErrorType.cache));
    } on FireException {
      return Left(FireFailure(errorType: ErrorType.firebase));
    }
  }

  @override
  updateGuideDetail(
      {required GuideDetailsEntity data, required String id}) async {
    try {
      _localDataSource.updateGuideDetail(data: data);
      return Right(
          await _remoteDataSource.updateGuideDetail(data: data, id: id));
    } on CacheException {
      return Left(CacheFailure(errorType: ErrorType.cache));
    } on FireException {
      return Left(FireFailure(errorType: ErrorType.firebase));
    }
  }

  @override
  preProcessContent(
      {required String content, required ChapterType type}) async {
    try {
      return Right(await _remoteDataSource.preProcessContent(
          content: content, type: type));
    } on ServerFailure {
      return Left(ServerFailure(errorType: ErrorType.server));
    }
  }
}
