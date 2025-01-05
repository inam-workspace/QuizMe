import 'package:quiz_me/main/imports.dart';

class QuizRepositoryImpl implements QuizRepository {
  @override
  generateQuiz({required QuizEntity payload}) async {
    QuizDataSource dataSource = QuizSource();
    final NetworkInfo networkInfo = NetworkInfoImpl();
    if (await networkInfo.isConnected == true) {
      try {
        final quiz = await dataSource.generateQuiz(payload: payload);
        return Right(quiz);
      } on ServerException {
        return Left(ServerFailure(errorType: ErrorType.server));
      }
    } else {
      return Left(NetworkFailure(errorType: ErrorType.network));
    }
  }
}
