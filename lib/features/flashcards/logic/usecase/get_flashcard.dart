import 'package:quiz_me/main/imports.dart';

class GetFlashcard {
  final FlashcardRepository repository;
  GetFlashcard(this.repository);
  Future<Either<Failure, List<FlashcardModel>>> generate(
      {required FlashcardEntity payload}) async {
    return await repository.generateFlashcard(payload: payload);
  }
}
