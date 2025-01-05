import 'package:quiz_me/main/imports.dart';

class GetChat {
  final ChatRepository repository;
  GetChat(this.repository);
  Future<Either<Failure, Map<String, dynamic>>> generate(
      {required ChatEntity payload}) async {
    return await repository.getResponse(payload: payload);
  }
}
