import 'package:quiz_me/main/imports.dart';

abstract class ChatDataSourceRemote {
  Future<Map<String, dynamic>> getResponse({required ChatEntity payload});
}

class ChatSourceRemote implements ChatDataSourceRemote {
  final Dio dio = Dio();
  @override
  Future<Map<String, dynamic>> getResponse(
      {required ChatEntity payload}) async {
    dio.options = BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 60),
    );
    Uri url = Uri();
  
    try {
      url = Uri(
        scheme: 'https',
        host: 'api.openai.com',
        path: 'v1/chat/completions',
      );
      final response = await dio.post(
        url.toString(),
        data: payload.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $apiToken',
          },
        ),
      );
      if (response.statusCode == 200) {
        logInfo('response: ${response.data}');
        final responseText =
            (response.data['choices'][0]?['message']?['content'] ?? '')
                .toString()
                .trim();
        return {
          "id": response.data['id'],
          "content": responseText.toString(),
        };
      } else {
        throw ServerException();
      }
    } on DioException {
      throw ServerException();
    }
  }
}