import 'package:quiz_me/main/imports.dart';
import 'package:quiz_me/utils/auth/data/source/auth_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource remoteDataSource = AuthSource();
  @override
  loginWithEmail(String email, String password) async {
    try {
      return Right(await remoteDataSource.loginWithEmail(email, password));
    } on FireException {
      return Left(FireFailure(errorType: ErrorType.firebase));
    }
  }

  @override
  logout() async {
    try {
      return Right(await remoteDataSource.logout());
    } on FireException {
      return Left(FireFailure(errorType: ErrorType.firebase));
    }
  }

  @override
  signInWithApple() async {
    try {
      return Right(await remoteDataSource.signInWithApple());
    } on FireException {
      return Left(FireFailure(errorType: ErrorType.firebase));
    }
  }

  @override
  signInWithGoogle() async {
    try {
      return Right(await remoteDataSource.signInWithGoogle());
    } on FireException {
      return Left(FireFailure(errorType: ErrorType.firebase));
    }
  }

  @override
  signUpWithEmail(String username, String email, String password) async {
    try {
      return Right(
          await remoteDataSource.signUpWithEmail(username, email, password));
    } on FireException {
      return Left(FireFailure(errorType: ErrorType.firebase));
    }
  }

  @override
  forgetPassword(String email) async {
    try {
      return Right(await remoteDataSource.forgetPassword(email));
    } on FireException {
      return Left(FireFailure(errorType: ErrorType.firebase));
    }
  }

  @override
  checkAuthState() async {
    return remoteDataSource.checkAuthState();
  }

  @override
  updateProfileImage(String id, Uint8List image) async {
    try {
      return Right(await remoteDataSource.updateProfileImage(id, image));
    } on FireException {
      return Left(FireFailure(errorType: ErrorType.firebase));
    }
  }

  @override
  getAuthDetails(String id) async {
    try {
      return Right(await remoteDataSource.getAuthDetails(id));
    } on FireException {
      return Left(FireFailure(errorType: ErrorType.firebase));
    }
  }

  @override
  getUserStreak(String id) async {
    try {
      return Right(await remoteDataSource.getUserStreak(id));
    } on FireException {
      return Left(FireFailure(errorType: ErrorType.firebase));
    }
  }

  @override
  updateUserStreak(String id, StreakModel streakData) async {
    try {
      return Right(await remoteDataSource.updateUserStreak(id, streakData));
    } on FireException {
      return Left(FireFailure(errorType: ErrorType.firebase));
    }
  }
}
