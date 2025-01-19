import 'package:quiz_me/main/imports.dart';

class FlashcardsProvider extends ChangeNotifier {
  bool isDispose = false;

  @override
  notifyListeners() {
    if (isDispose) return;
    super.notifyListeners();
  }

  @override
  void dispose() {
    isDispose = true;
    super.dispose();
  }

  final GuideDetailsEntity guideDetails;
  final String chapter;

  Failure? _failure;
  Failure? get failure => _failure;
  set setFailure(Failure? fail) {
    _failure = fail;
    notifyListeners();
  }

  List<FlashcardModel> _results = [];
  List<FlashcardModel> get results => _results;
  set setResults(List<FlashcardModel> res) {
    _results = res;
    notifyListeners();
  }

  int _currentIndex = 1;
  int get currentIndex => _currentIndex;
  set setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  int _learnedCount = 1;
  int get learnedCount => _learnedCount;
  set setLearnedCount(int index) {
    _learnedCount = index;
    notifyListeners();
  }

  final controller = AppinioSwiperController();

  FlashcardsProvider({required this.guideDetails, required this.chapter}) {
    generateFlipcards();
  }

  swipeEnd(int previousIndex, int targetIndex, SwiperActivity activity) {
    switch (activity) {
      case Swipe():
        setCurrentIndex = targetIndex + 1;
        if (activity.direction == AxisDirection.right) {
          setLearnedCount = learnedCount + 1;
        }
        break;
      default:
        break;
    }
  }

  onEnd() {
    Push.to(
      route: '/flashcardsScoreSheet',
      arg: FlashcardsScoreSheetArguments(
        guideDetails: guideDetails,
        learned: learnedCount,
        total: results.length,
      ),
    ).then((value) {
      if (value == 'review') {
        setCurrentIndex = 0;
        setLearnedCount = 0;
      }
    });
  }

  Future<void> generateFlipcards() async {
    String prompt = promptFormate(guideDetails.chaptersDetail
        .firstWhere((e) => e.title == chapter)
        .content);
    final payload = FlashcardEntity(
      messages: [
        FlashcardMessage(
            role: "system", content: "You are a QuizMe assistant."),
        FlashcardMessage(role: "user", content: prompt),
      ],
    );
    FlashcardRepository repository = FlashcardRepositoryImpl();
    final failOrResult =
        await GetFlashcard(repository).generate(payload: payload);
    failOrResult.fold((fail) {
      setFailure = fail;
    }, (results) {
      setResults = results;
    });
  }

  String promptFormate(String content) {
    return '''
You are QuizMe Assistant, specialized in creating quiz questions and answers. Your task is to generate exactly 20 questions based on the given chapter content. Follow these rules carefully:

For "questions":
* Each question must be between 50 and 70 characters.
* Ensure clarity, relevance, and that the phrasing tests understanding.

For "answers":
* Provide the correct answer directly and concisely.
* Each answer must be between 70 and 150 characters.
* Avoid ambiguity and ensure the answer is derived from the content.

Additional Rules:
* You must generate exactly 20 questions and answers.
* Questions and answers should be comprehensive and relevant to the chapter.

Response Format:
* Format the output strictly as JSON,
* Please must follow the format below, otherwise, the system will not accept the response.
[
    {   
        "id": 1,
        "question": "",
        "answer": ""
    },
    {   
        "id": 2,
        "question": "",
        "answer": ""
    }
]

Provided Content: 
$content
''';
  }
}
