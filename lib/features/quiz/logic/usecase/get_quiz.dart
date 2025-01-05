import 'package:quiz_me/main/imports.dart';

class GetQuiz {
  final QuizRepository repository;
  GetQuiz(this.repository);
  Future<Either<Failure, List<QuizModel>>> generate(
      {required QuizEntity payload}) async {
    return await repository.generateQuiz(payload: payload);
  }
}
