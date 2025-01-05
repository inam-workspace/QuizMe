import 'package:quiz_me/main/imports.dart';

abstract class MockTestRepository {
  Future<Either<Failure, List<MockTestModel>>> generateMockTest(
      {required MockTestEntity payload});
}
