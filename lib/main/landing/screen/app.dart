import 'package:quiz_me/features/onboarding/screen/onboarding_screen.dart';
import 'package:quiz_me/main/imports.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AddGuideProvider()),
        ],
        child: MaterialApp(
          builder: (context, child) {
            return MediaQuery.withNoTextScaling(
              child: child!,
            );
          },
          title: 'QuizMe',
          initialRoute: '/',
          navigatorKey: Push.navigatorKey,
          onGenerateRoute: AppRoutes.onGenerateRoute,
          themeMode: ThemeMode.dark,
          theme: AppTheme.darkTheme,
          darkTheme: AppTheme.darkTheme,
          debugShowCheckedModeBanner: false,
          home: FutureBuilder(
            future: AppController.instance.checkOnboarding(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SplashScreen();
              } else {
                if (snapshot.hasData && snapshot.data == false) {
                  return OnboardingScreen();
                } else {
                  return FutureBuilder(
                    future: AppController.instance.checkAuth(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SplashScreen();
                      } else {
                        return snapshot.hasData && snapshot.data == true
                            ? DashboardScreen()
                            : LoginScreen();
                      }
                    },
                  );
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
