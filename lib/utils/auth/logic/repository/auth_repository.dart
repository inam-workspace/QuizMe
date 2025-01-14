import 'package:quiz_me/main/imports.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthModel>> signInWithGoogle();

  Future<Either<Failure, AuthModel>> signInWithApple();

  Future<Either<Failure, AuthModel>> loginWithEmail(
      String email, String password);

  Future<Either<Failure, AuthModel>> signUpWithEmail(
      String username, String email, String password);

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, void>> forgetPassword(String email);

  Future<Either<Failure, void>> deleteAccount();

  Future<Either<Failure, void>> updateProfileImage(String id, Uint8List image);

  Future<User?> checkAuthState();

  Future<Either<Failure, AuthModel>> getAuthDetails(String id);

  Future<Either<Failure, StreakModel?>> getUserStreak(String id);

  Future<Either<Failure, void>> updateUserStreak(
      String id, StreakModel streakData);
}
