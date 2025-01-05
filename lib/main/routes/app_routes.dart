import 'package:quiz_me/features/drawer/widgets/faqs_screen.dart';
import 'package:quiz_me/main/imports.dart';

class AppRoutes {
  static Route<dynamic>? Function(RouteSettings)? onGenerateRoute = (settings) {
    switch (settings.name) {
      case '/':
        return NavigationAnimation(
          settings: settings,
          page: SplashScreen(),
        );
      case '/dashboardScreen':
        return NavigationAnimation(
          settings: settings,
          page: DashboardScreen(),
        );
      case '/addStudyGuide':
        return NavigationAnimation(
          settings: settings,
          page: AddGuideScreen(),
        );
      case '/flashcardsScreen':
        return NavigationAnimation(
          settings: settings,
          page: FlashcardsScreen(),
        );
      case '/flashcardsScoreSheet':
        return NavigationAnimation(
          settings: settings,
          page: FlashcardsScoreSheet(),
        );
      case '/attemptQuizScreen':
        return NavigationAnimation(
          settings: settings,
          page: AttemptQuizScreen(),
        );
      case '/quizScoreSheet':
        return NavigationAnimation(
          settings: settings,
          page: QuizScoreSheet(),
        );
      case '/attemptMockTestScreen':
        return NavigationAnimation(
          settings: settings,
          page: AttemptMockTestScreen(),
        );
      case '/mockTestScoreSheet':
        return NavigationAnimation(
          settings: settings,
          page: MockTestScoreSheet(),
        );
      case '/notesScreen':
        return NavigationAnimation(
          settings: settings,
          page: NotesScreen(),
        );
      case '/chatScreen':
        return NavigationAnimation(
          settings: settings,
          page: ChatScreen(),
        );
      //Auth
      case '/loginScreen':
        return NavigationAnimation(
          settings: settings,
          page: LoginScreen(),
        );
      case '/registrationScreen':
        return NavigationAnimation(
          settings: settings,
          page: RegistrationScreen(),
        );
      case '/forgetPasswordScreen':
        return NavigationAnimation(
          settings: settings,
          page: ForgetPasswordScreen(),
        );
      case '/faqsScreen':
        return NavigationAnimation(
          settings: settings,
          page: FaqsScreen(),
        );
    }
    return null;
  };
}
