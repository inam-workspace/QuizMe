import 'package:quiz_me/main/imports.dart';

class GetNotes {
  final NotesRepository repository;
  GetNotes(this.repository);
  Future<Either<Failure, NotesModel>> get(
      {required NotesEntity payload, required String contentID}) async {
    return await repository.getNotes(payload: payload, contentID: contentID);
  }
}
