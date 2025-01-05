import 'package:quiz_me/main/imports.dart';

abstract class FlashcardDataSource {
  Future<List<FlashcardModel>> generateFlashcard(
      {required FlashcardEntity payload});
}

class FlashcardSource implements FlashcardDataSource {
  final Dio dio = Dio();
  @override
  Future<List<FlashcardModel>> generateFlashcard(
      {required FlashcardEntity payload}) async {
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
        List<dynamic> jsonData = json.decode(res.replaceAll("json", "").replaceAll("```", "").toString());
        return jsonData.map((data) => FlashcardModel.fromJson(data)).toList();
      } else {
        throw ServerException();
      }
    } on DioException {
      throw ServerException();
    }
  }
}
