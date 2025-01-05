import 'package:quiz_me/main/imports.dart';

class MockTestRepositoryImpl implements MockTestRepository {
  @override
  generateMockTest({required MockTestEntity payload}) async {
    MockTestDataSource dataSource = MockTestSource();
    final NetworkInfo networkInfo = NetworkInfoImpl();
    if (await networkInfo.isConnected == true) {
      try {
        final mockTest = await dataSource.generateMockTest(payload: payload);
        return Right(mockTest);
      } on ServerException {
        return Left(ServerFailure(errorType: ErrorType.server));
      }
    } else {
      return Left(NetworkFailure(errorType: ErrorType.network));
    }
  }
}
