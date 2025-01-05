import 'package:quiz_me/main/imports.dart';

abstract class NotesRemoteSource {
  Future<NotesModel> getNotes({
    required NotesEntity payload,
    required String contentID,
  });
}

class NotesRemote implements NotesRemoteSource {
  final Dio dio = Dio();
  @override
  Future<NotesModel> getNotes(
      {required NotesEntity payload, required String contentID}) async {
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
        String res = response.data['choices'][0]['message']['content'];
    
        return NotesModel(
          contentID: contentID,
          description: res,
        );
      } else {
        throw ServerException();
      }
    } on DioException {
      throw ServerException();
    }
  }
}
