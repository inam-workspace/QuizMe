
import 'package:quiz_me/main/imports.dart';

class ChatRepositoryImpl implements ChatRepository {
  @override
  getResponse({required ChatEntity payload}) async {
    ChatDataSourceRemote dataSource = ChatSourceRemote();
    final NetworkInfo networkInfo = NetworkInfoImpl();
    if (await networkInfo.isConnected == true) {
      try {
        final chat = await dataSource.getResponse(payload: payload);
        return Right(chat);
      } on ServerException {
        return Left(ServerFailure(errorType: ErrorType.server));
      }
    } else {
      return Left(NetworkFailure(errorType: ErrorType.network));
    }
  }
}
