import 'package:quiz_me/main/imports.dart';

abstract class QuizRepository {
  Future<Either<Failure, List<QuizModel>>> generateQuiz(
      {required QuizEntity payload});
}
