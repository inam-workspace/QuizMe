import 'package:quiz_me/main/imports.dart';

abstract class NotesRepository {
  Future<Either<Failure, NotesModel>> getNotes({
    required NotesEntity payload,
    required String contentID,
  });
}
