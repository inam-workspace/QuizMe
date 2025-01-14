import 'package:quiz_me/main/imports.dart';

class GetAuth {
  AuthRepository repository = AuthRepositoryImpl();
  static GetAuth instance = GetAuth._();

  factory GetAuth() {
    return instance;
  }
  GetAuth._();

  Future<Either<Failure, AuthModel>> signInWithGoogle() async {
    return await repository.signInWithGoogle();
  }

  Future<Either<Failure, AuthModel>> signInWithApple() async {
    return await repository.signInWithApple();
  }

  Future<Either<Failure, AuthModel>> loginWithEmail(
      String email, String password) async {
    return await repository.loginWithEmail(email, password);
  }

  Future<Either<Failure, AuthModel>> signUpWithEmail(
      String username, String email, String password) async {
    return await repository.signUpWithEmail(username, email, password);
  }

  Future<Either<Failure, void>> logout() async {
    return await repository.logout();
  }

  Future<Either<Failure, void>> forgetPassword(String email) async {
    return await repository.forgetPassword(email);
  }

  Future<Either<Failure, void>> deleteAccount() async {
    return await repository.deleteAccount();
  }

  Future<Either<Failure, void>> updateProfileImage(
      String id, Uint8List image) async {
    return await repository.updateProfileImage(id, image);
  }

  Future<Either<Failure, AuthModel>> getAuthDetails(String id) async {
    return await repository.getAuthDetails(id);
  }

  Future<User?> checkAuthState() {
    return repository.checkAuthState();
  }

  Future<Either<Failure, StreakModel?>> getUserStreak(String id) async {
    return await repository.getUserStreak(id);
  }

  Future<Either<Failure, void>> updateUserStreak(
      String id, StreakModel streakData) async {
    return await repository.updateUserStreak(id, streakData);
  }
}
