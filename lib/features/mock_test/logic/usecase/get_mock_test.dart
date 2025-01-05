import 'package:quiz_me/main/imports.dart';

class GetMockTest {
  final MockTestRepository repository;
  GetMockTest(this.repository);
  Future<Either<Failure, List<MockTestModel>>> generate(
      {required MockTestEntity payload}) async {
    return await repository.generateMockTest(payload: payload);
  }
}
