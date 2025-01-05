
import 'package:quiz_me/main/imports.dart';

abstract class FlashcardRepository {
  Future<Either<Failure, List<FlashcardModel>>> generateFlashcard(
      {required FlashcardEntity payload});
}
