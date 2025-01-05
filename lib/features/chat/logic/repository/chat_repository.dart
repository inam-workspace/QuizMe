
import 'package:quiz_me/main/imports.dart';

abstract class ChatRepository {
  Future<Either<Failure, Map<String, dynamic>>> getResponse({required ChatEntity payload});
}
