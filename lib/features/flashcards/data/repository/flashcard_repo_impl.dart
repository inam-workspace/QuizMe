import 'package:quiz_me/main/imports.dart';

class FlashcardRepositoryImpl implements FlashcardRepository {
  @override
  generateFlashcard({required FlashcardEntity payload}) async {
    FlashcardDataSource dataSource = FlashcardSource();
    final NetworkInfo networkInfo = NetworkInfoImpl();
    if (await networkInfo.isConnected == true) {
      try {
        final flashcard = await dataSource.generateFlashcard(payload: payload);
        return Right(flashcard);
      } on ServerException {
        return Left(ServerFailure(errorType: ErrorType.server));
      }
    } else {
      return Left(NetworkFailure(errorType: ErrorType.network));
    }
  }
}
