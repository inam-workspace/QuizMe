import 'package:quiz_me/main/imports.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppController extends ChangeNotifier {
  static AppController instance = AppController._();

  factory AppController() {
    return instance;
  }
  AppController._();

  AuthModel _authDetails = AuthModel();
  AuthModel get authDetails => _authDetails;
  set setAuthDetails(AuthModel details) {
    _authDetails = details;
  }

  set setAndNotifyAuthDetails(AuthModel details) {
    _authDetails = details;
    notifyListeners();
  }

  StreakModel? _streakModel;
  StreakModel? get streakModel => _streakModel;
  set setStreakModel(StreakModel? details) {
    _streakModel = details;
  }

  set setAndNotifyStreakModel(StreakModel? details) {
    _streakModel = details;
    notifyListeners();
  }

  User? _currentUser;
  User? get currentUser => _currentUser;
  set setCurrentUser(User? user) {
    _currentUser = user;
  }

  set setAndNotifyCurrentUser(User? user) {
    _currentUser = user;
    notifyListeners();
  }

  Future<bool> checkAuth() async {
    return GetAuth.instance.checkAuthState().then(
      (User? user) async {
        if (user != null) {
          setCurrentUser = user;
          await getAuthDetails(user.uid);
          await getUserStreak(user.uid);
          return true;
        } else {
          return false;
        }
      },
    );
  }

  Future getAuthDetails(String id) async {
    final result = await GetAuth.instance.getAuthDetails(id);
    result.fold(
      (fail) {
        logError(fail.errorMessage);
      },
      (model) {
        setAuthDetails = model;
      },
    );
  }

  Future getUserStreak(String id, {bool notify = false}) async {
    final result = await GetAuth.instance.getUserStreak(id);
    result.fold(
      (fail) {
        logError(fail.errorMessage);
        setStreakModel = null;
        if (notify) notifyListeners();
      },
      (model) async {
        setStreakModel = model;
        if (notify) notifyListeners();
        DateTime today = DateTime.now();
        if (model == null) {
          StreakModel newStreak = StreakModel(streak: 1, lastLoginDate: today);
          await GetAuth.instance.updateUserStreak(id, newStreak);
          return;
        }
        DateTime lastLogin = model.lastLoginDate;
        Duration diff = today.difference(lastLogin);
        if (diff.inDays == 1) {
          StreakModel updatedStreak = StreakModel(
            streak: model.streak + 1,
            lastLoginDate: today,
          );
          await GetAuth.instance.updateUserStreak(id, updatedStreak);
        } else if (diff.inDays > 1) {
          StreakModel resetStreak = StreakModel(
            streak: 1,
            lastLoginDate: today,
          );
          await GetAuth.instance.updateUserStreak(id, resetStreak);
        }
      },
    );
  }

  Future<bool> checkOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    bool? onboarding = prefs.getBool('onboarding');
    if (onboarding == null) {
      return false;
    } else {
      return onboarding;
    }
  }
}
