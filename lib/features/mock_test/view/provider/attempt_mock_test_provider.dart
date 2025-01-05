import 'package:quiz_me/main/imports.dart';

class AttemptMockTestProvider extends ChangeNotifier {
  final guideProvider =
      Provider.of<AddGuideProvider>(Push.context, listen: false);
  final GuideDetailsEntity guideDetails;
  final MockTestType type;
  AttemptMockTestProvider({
    required this.guideDetails,
    required this.type,
  }) {
    generateMockTest();
  }

  Failure? _failure;
  Failure? get failure => _failure;
  set setFailure(Failure? fail) {
    _failure = fail;
    notifyListeners();
  }

  List<MockTestModel> _results = [];
  List<MockTestModel> get results => _results;
  set setResults(List<MockTestModel> res) {
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

  next(context) {
    if (type == MockTestType.custom) FocusScope.of(context).unfocus();
    if (currentIndex == results.length - 1) {
      calculateScore();
      if (reviewMode == false) updateMockTestScore();
      setReviewMode = false;
      Push.to(
        route: '/mockTestScoreSheet',
        arg: MockTestScoreSheetArguments(
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

  Future<void> generateMockTest() async {
    String combineContent = guideDetails.chaptersDetail
        .map((chapter) => chapter.content)
        .join('\n\n');

    String prompt = promptFormate(combineContent, type);
    final payload = MockTestEntity(
      messages: [
        MockTestMessage(role: "system", content: "You are a QuizMe assistant."),
        MockTestMessage(role: "user", content: prompt),
      ],
    );
    MockTestRepository repository = MockTestRepositoryImpl();
    final failOrResult =
        await GetMockTest(repository).generate(payload: payload);
    failOrResult.fold((fail) {
      setFailure = fail;
    }, (result) {
      setResults = result;
      setSelectedAnswers = result
          .map((q) => q.options.isEmpty ? "" : q.options.first as String)
          .toList();

      logInfo(selectedAnswers.length.toString());
    });
  }

  void setAnswer(int index, String answer) {
    _selectedAnswers[index] = answer;
    notifyListeners();
  }

  void calculateScore() {
    setScore = 0;
    for (int i = 0; i < results.length; i++) {
      if (type == MockTestType.custom) {
        if (isApproximateAnswer(selectedAnswers[i].toLowerCase().trim(),
            results[i].acceptedKeywords)) {
          setScore = score + 1;
        }
      } else {
        if (results[i].answer == selectedAnswers[i]) {
          setScore = score + 1;
        }
      }
    }
  }

  bool isApproximateAnswer(String userAnswer, List<dynamic> acceptedKeywords) {
    for (var keyword in acceptedKeywords) {
      String word = keyword as String;
      if (userAnswer.contains(word.toLowerCase().trim())) {
        return true;
      }
    }
    return false;
  }

  String promptFormate(String content, MockTestType type) {
    String answerRules = '';
    String reponseRules = '';
    if (type == MockTestType.mcq) {
      answerRules = '''
        * Provide the 4 options, one correct option and three incorrect options.
        * Each option must be between 10 and 20 characters.
        * Avoid ambiguity and ensure the answer is derived from the content.
        ''';
      reponseRules = '''[
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
        ]''';
    } else if (type == MockTestType.statement) {
      answerRules = '''
        * Provide the 2 options for statement questions - "True"/"False".
        * Answer is either "True" of "False".
        * Avoid ambiguity and ensure the answer is derived from the content.
        ''';
      reponseRules = '''[
          {
            "id": 1,
            "question": "",
            "answer": "False",
            "explination": "Correct explanation of the option goes here.",
            "options": ["True","False""]
          },
          {
            "id": 2,
            "question": "",
            "answer": "True",
            "explination": "Correct explanation of the option goes here.",
            "options": ["True", "False"]
          }
        ]''';
    } else {
      answerRules = '''
        * Provide the correct answer directly and concisely.
        * Each answer must be between 50 and 100 characters.
        * Avoid ambiguity and ensure the answer is derived from the content.
        * Provider list of Accepted Keywords that must be included in the answer e.g. If the question is about the color of the sky, we match keywords like "blue"
        ''';
      reponseRules = '''[
          {
            "id": 1,
            "question": "",
            "answer": "",
            "explination": "Correct explanation of the option goes here."
            "accepted_keywords": ["",""] 
          },
          {
            "id": 2,
            "question": "",
            "answer": "",
            "explination": "Correct explanation of the option goes here.",    
            "accepted_keywords": ["",""] 
          }
        ]''';
    }
    return '''
You are QuizMe Assistant, specialized in creating MockTest questions and answers. Your task is to generate exactly 20 questions based on the given chapter content. Follow these rules carefully:

For "questions":
* Each question must be between 50 and 70 characters.
* Ensure clarity, relevance, and that the phrasing tests understanding.

For "answers":
$answerRules

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
$reponseRules

Provided Content: 
$content
''';
  }

  updateMockTestScore() {
    double currentScore = guideDetails.mockPercentage;
    double quizPercentage = guideDetails.quizPercentage;
    double chapterScore = score / 20;
    int totalChapters = guideDetails.chaptersDetail.length;
    double chapterWeight = 1 / totalChapters;
    double chapterContribution = chapterScore * chapterWeight;
    currentScore += chapterContribution;
    guideDetails.mockPercentage = currentScore;
    guideDetails.overallPercentage = currentScore + quizPercentage;
    guideProvider.update(guideDetails);
  }
}
