class QuizMockCalculator {
  final int totalQuizQuestions = 20; // Questions per chapter quiz
  final int totalMockQuestions = 20; // Questions per mock test
  final double quizWeightage = 40; // 40% weightage for quizzes
  final double mockWeightage = 60; // 60% weightage for mock tests

  // Calculate the final score
  double calculateFinalScore({
    required int totalQuizCorrect, // Total correct answers in all quizzes
    required int totalQuizAttempts, // Total quizzes attempted
    required int totalMockCorrect, // Total correct answers in mock tests
    required int totalMockAttempts, // Total mock tests attempted
  }) {
    // Quizzes score as percentage of 40%
    double quizScore = (totalQuizAttempts > 0)
        ? (totalQuizCorrect / (totalQuizAttempts * totalQuizQuestions)) *
            quizWeightage
        : 0.0;

    // Mock tests score as percentage of 60%
    double mockScore = (totalMockAttempts > 0)
        ? (totalMockCorrect / (totalMockAttempts * totalMockQuestions)) *
            mockWeightage
        : 0.0;

    // Total score
    return quizScore + mockScore;
  }
}
