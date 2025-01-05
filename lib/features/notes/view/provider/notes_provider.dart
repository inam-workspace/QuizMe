import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:quiz_me/features/notes/data/repository/notes_repo_impl.dart';
import 'package:quiz_me/features/notes/logic/usecase/get_notes.dart';
import 'package:quiz_me/main/imports.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

class NotesProvider extends ChangeNotifier {
  final GuideDetailsEntity guideDetails;
  final String contentID;

  NotesProvider({required this.guideDetails, required this.contentID}) {
    generateNotes();
  }

  ChapterDetailsEntity get chapterDetails =>
      guideDetails.chaptersDetail.firstWhere((e) => e.id == contentID);
  Failure? _failure;
  Failure? get failure => _failure;
  set setFailure(Failure? fail) {
    _failure = fail;
    notifyListeners();
  }

  NotesModel? _result;
  NotesModel? get result => _result;
  set setResult(NotesModel res) {
    _result = res;
    notifyListeners();
  }

  Future<void> generateNotes() async {
    String prompt = promptFormate(chapterDetails.content);
    final payload = NotesEntity(
      messages: [
        NotesMessage(role: "system", content: "You are a QuizMe assistant."),
        NotesMessage(role: "user", content: prompt),
      ],
    );
    NotesRepository repository = NotesRepoImpl();
    final failOrResult =
        await GetNotes(repository).get(payload: payload, contentID: contentID);
    failOrResult.fold((fail) {
      setFailure = fail;
    }, (result) {
      setResult = result;
    });
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
* Format the output strictly as markdown,
* Please must follow the format define, otherwise, the system will not accept the response.

Provided Content: 
$content
''';
  }

  shareNotes() {
    final pdf = pw.Document();
    final data = result != null
        ? pw.Text(result!.description)
        : pw.Text("No notes generated");
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(child: data);
        },
      ),
    );
    shareFile(pdf);
  }

  shareFile(pw.Document data) async {
    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/${chapterDetails.title}.pdf';
    final file = File(filePath);
    await file.writeAsBytes(await data.save());
    await Share.shareXFiles([XFile(file.path)], text: 'Check out this file!');
  }
}
