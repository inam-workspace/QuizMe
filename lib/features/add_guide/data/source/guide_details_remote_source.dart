import 'package:quiz_me/main/imports.dart';
import 'package:xml/xml.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

abstract class GuideDetailsRemoteSource {
  Future<void> addGuideDetail(
      {required GuideDetailsEntity data, required String id});

  Future<List<GuideDetailsModel>> getGuideDetail({required String id});

  Future<void> updateGuideDetail(
      {required GuideDetailsEntity data, required String id});

  Future<void> deleteGuideDetail(
      {required GuideDetailsEntity data, required String id});

  Future<String> preProcessContent({
    required String content,
    required ChapterType type,
  });
}

class GuideDetailsRemoteSourceImpl implements GuideDetailsRemoteSource {
  final _collection = FirebaseFirestore.instance.collection('users');
  final dio = Dio();

  @override
  addGuideDetail({required GuideDetailsEntity data, required String id}) async {
    try {
      final currentList = await getGuideDetail(id: id);
      currentList.add(GuideDetailsModel.fromJson(data.toJson()));

      await _collection.doc(id).update(
          {'study_guides': currentList.map((item) => item.toJson()).toList()});
    } on Exception {
      throw FireException();
    }
  }

  @override
  deleteGuideDetail({
    required GuideDetailsEntity data,
    required String id,
  }) async {
    try {
      final currentList = await getGuideDetail(id: id);
      currentList.removeWhere(
          (item) => item.dateTime.millisecondsSinceEpoch == data.dateTime);
      await _collection.doc(id).update(
          {'study_guides': currentList.map((item) => item.toJson()).toList()});
    } on Exception {
      throw FireException();
    }
  }

  @override
  getGuideDetail({required String id}) async {
    try {
      DocumentSnapshot docSnapshot = await _collection.doc(id).get();
      if (docSnapshot.exists) {
        List<dynamic> data = docSnapshot['study_guides'] ?? [];
        if (data.isEmpty) return [];
        return data.map((item) => GuideDetailsModel.fromJson(item)).toList();
      } else {
        return [];
      }
    } on Exception {
      throw FireException();
    }
  }

  @override
  updateGuideDetail({
    required GuideDetailsEntity data,
    required String id,
  }) async {
    try {
      final currentList = await getGuideDetail(id: id);
      currentList.add(GuideDetailsModel.fromJson(data.toJson()));
      await _collection.doc(id).update(
          {'study_guides': currentList.map((item) => item.toJson()).toList()});
    } on Exception {
      throw FireException();
    }
  }

  @override
  preProcessContent({
    required String content,
    required ChapterType type,
  }) async {
    try {
      String extractedConetent = '';
      if (type == ChapterType.link) {
        extractedConetent = await extractConetentFromLink(content);
      } else {
        extractedConetent = content;
      }
      dio.options = BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 60),
      );
      Uri url = Uri(
        scheme: 'https',
        host: 'api.openai.com',
        path: 'v1/chat/completions',
      );
      final response = await dio.post(
        url.toString(),
        data: {
          "model": "gpt-3.5-turbo",
          "messages": [
            {"role": "system", "content": "You are a QuizMe assistant."},
            {"role": "user", "content": promptFormate(extractedConetent)}
          ],
          "temperature": 0.75,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $apiToken',
          },
        ),
      );
      if (response.statusCode == 200) {
        final responseText =
            (response.data['choices'][0]?['message']?['content'] ?? '')
                .toString()
                .trim();
        return responseText.toString();
      } else {
        throw Exception();
      }
    } on DioException catch (e) {
      logInfo(e.toString());
      throw ServerException();
    } on Exception {
      throw ServerException();
    }
  }

  Future<String> extractConetentFromLink(String url) async {
    var yt = YoutubeExplode();
    final video = VideoId(url);
    return await yt.videos.closedCaptions.getManifest(video).then(
      (manifest) async {
        final track = manifest.tracks.first;
        try {
          dio.options = BaseOptions(
            connectTimeout: const Duration(seconds: 30),
            sendTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 60),
          );
          final response = await dio.get(
            track.url.toString(),
            options: Options(
              headers: {'Content-Type': 'application/json'},
            ),
          );

          if (response.statusCode == 200) {
            final bookshelfXml = response.data;
            final document = XmlDocument.parse(bookshelfXml);
            return document.innerText.toString();
          } else {
            throw Exception();
          }
        } on DioException catch (e) {
          logError(e.toString());
          throw ServerException();
        } on Exception {
          throw ServerException();
        }
      },
    );
  }

  String promptFormate(String content) {
    return '''
You are "QuizMe Assistant", specialized in generating comprehensive and relevant notes based on the given chapter content. Your task is to process the provided content and create detailed, structured notes following these specific guidelines:

Formatting:
* Divide the chapter into distinct sections.
* Each step should have a heading, description, and any related important points or examples.
* For each section, provide a brief explanation of key points.

Structure of Notes:
* The notes should be organized in a logical flow, maintaining clarity and coherence.
* Ensure all relevant details from the chapter are captured comprehensively.

Content Representation:
* Each key concept or section of the chapter should be clearly labeled and explained in simple terms.
* Use definitions, examples, and other supporting details where applicable.

Key Focus Areas:
* Summarize the important points.
* Highlight concepts, theories, and methodologies.
* Offer brief yet insightful descriptions or explanations for each section.

Response Format:
* Format the output strictly as standard String,
* Please must follow the format define, otherwise, the system will not accept the response.

Provided Content: 
$content
''';
  }
}
