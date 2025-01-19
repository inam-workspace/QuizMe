import 'package:quiz_me/main/imports.dart';

class AttemptQuizProvider extends ChangeNotifier {
  final guideProvider =
      Provider.of<AddGuideProvider>(Push.context, listen: false);
  final ChapterDetailsEntity chaptersDetail;
  final GuideDetailsEntity guideDetails;
  AttemptQuizProvider({
    required this.chaptersDetail,
    required this.guideDetails,
  }) {
    generateQuiz();
  }
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

  Failure? _failure;
  Failure? get failure => _failure;
  set setFailure(Failure? fail) {
    _failure = fail;
    notifyListeners();
  }

  List<QuizModel> _results = [];
  List<QuizModel> get results => _results;
  set setResults(List<QuizModel> res) {
    _results = res;
    notifyListeners();
  }

  final pageController = PageController(initialPage: 0);

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  set setCurrentIndex(int index) {
    pageController.jumpToPage(index);
    _currentIndex = index;
    notifyListeners();
  }

  List<String> _selectedAnswers = [];
  List<String> get selectedAnswers => _selectedAnswers;
  set setSelectedAnswers(List<String> value) {
    _selectedAnswers = value;
    notifyListeners();
  }

  int _score = 0;
  int get score => _score;
  set setScore(int value) {
    _score = value;
    notifyListeners();
  }

  bool _reviewMode = false;
  bool get reviewMode => _reviewMode;
  set setReviewMode(bool value) {
    _reviewMode = value;
    notifyListeners();
  }

  next() {
    if (selectedAnswers[currentIndex] == '') {
      showWarningToast('Alert!!!', 'Please must select one of the option');
      return;
    }
    if (currentIndex == results.length - 1) {
      calculateScore();
      if (reviewMode == false) updateQuizScore();
      setReviewMode = false;
      Push.to(
        route: '/quizScoreSheet',
        arg: QuizScoreSheetArguments(
          guideDetails: guideDetails,
          correct: score,
          total: results.length,
        ),
      ).then((value) {
        if (value == 'review') {
          setCurrentIndex = 0;
          setReviewMode = true;
        }
      });
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }

  back() {
    if (currentIndex > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }

  Future<void> generateQuiz() async {
    String prompt = promptFormate(chaptersDetail.content);
    final payload = QuizEntity(
      messages: [
        QuizMessage(role: "system", content: "You are a QuizMe assistant."),
        QuizMessage(role: "user", content: prompt),
      ],
    );
    QuizRepository repository = QuizRepositoryImpl();
    final failOrResult = await GetQuiz(repository).generate(payload: payload);
    failOrResult.fold((fail) {
      setFailure = fail;
    }, (result) {
      setResults = result;
      setSelectedAnswers = List.generate(result.length, (index) {
        return '';
      });
    });
  }

  void setAnswer(int index, String answer) {
    _selectedAnswers[index] = answer;
    notifyListeners();
  }

  void calculateScore() {
    setScore = 0;
    for (int i = 0; i < results.length; i++) {
      if (results[i].answer == selectedAnswers[i]) {
        setScore = score + 1;
      }
    }
  }

  String promptFormate(String content) {
    return '''
You are QuizMe Assistant, specialized in creating quiz questions and answers. Your task is to generate exactly 20 questions based on the given chapter content. Follow these rules carefully:

For "questions":
* Each question must be between 50 and 70 characters.
* Ensure clarity, relevance, and that the phrasing tests understanding.

For "answers":
* Provide the 4 options, one correct option and three incorrect options.
* Each option must be between 10 and 20 characters.
* Avoid ambiguity and ensure the answer is derived from the content.

For "explination":
* please provider correct explanation of the option.
* Each explanation must be between 20 and 30 characters.
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
    "answer": "Option 3",
    "explination": "Correct explanation of the option goes here.",
    "options": [ "Option 1",  "Option 2", "Option 3", "Option 4" ]
  },
  {
    "id": 2,
    "question": "",
    "answer": "Option 2",
    "explination": "Correct explanation of the option goes here.",
    "options": [ "Option 1",  "Option 2", "Option 3", "Option 4" ]
  }
]

Provided Content: 
$content
''';
  }

  updateQuizScore() {
    double currentScore = guideDetails.quizPercentage;
    double mockPercentage = guideDetails.mockPercentage;
    double chapterScore = score / 20;
    int totalChapters = guideDetails.chaptersDetail.length;
    double chapterWeight = 1 / totalChapters;
    double chapterContribution = chapterScore * chapterWeight;
    currentScore += chapterContribution;
    guideDetails.quizPercentage = currentScore;
    guideDetails.overallPercentage = (currentScore + mockPercentage) / 2;
    guideProvider.update(guideDetails);
  }
}
