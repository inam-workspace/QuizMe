import 'package:quiz_me/main/imports.dart';

class NotesRepoImpl implements NotesRepository {
  NotesRemoteSource remoreSource = NotesRemote();
  NotesLocalSource localSource = NotesLocal();
  NetworkInfo networkInfo = NetworkInfoImpl();
  @override
  Future<Either<Failure, NotesModel>> getNotes({
    required NotesEntity payload,
    required String contentID,
  }) async {
    if (await localSource.checkDatabase(contentID: contentID)) {
      final notes = await localSource.getNotes(contentID: contentID);
      return Right(notes);
    } else {
      if (await networkInfo.isConnected == true) {
        try {
          final notes = await remoreSource.getNotes(
              payload: payload, contentID: contentID);
          await localSource.addNotes(data: notes);
          return Right(notes);
        } on ServerException {
          return Left(ServerFailure(errorType: ErrorType.server));
        }
      } else {
        return Left(NetworkFailure(errorType: ErrorType.network));
      }
    }
  }
}
