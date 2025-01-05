import 'package:quiz_me/main/imports.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class AuthDataSource {
  Future<AuthModel> signInWithGoogle();

  Future<AuthModel> signInWithApple();

  Future<AuthModel> loginWithEmail(String email, String password);

  Future<AuthModel> signUpWithEmail(
      String username, String email, String password);

  Future<void> logout();

  Future<void> forgetPassword(String email);

  Future<User?> checkAuthState();

  Future<void> updateProfileImage(String id, Uint8List image);

  Future<AuthModel> getAuthDetails(String id);

  Future<StreakModel?> getUserStreak(String id);

  Future<void> updateUserStreak(String id, StreakModel streakData);
}

class AuthSource implements AuthDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  @override
  loginWithEmail(String email, String password) async {
    try {
      final user = (await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
      String id = user!.uid;
      DocumentSnapshot doc = await _firestore.collection('users').doc(id).get();
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return AuthModel(
        uid: id,
        email: data['email'],
        displayName: data['username'],
        photoURL: data['imageUrl'],
      );
    } on FireException {
      throw FireException();
    }
  }

  @override
  logout() async {
    try {
      await _auth.signOut();
    } on FireException {
      throw FireException();
    }
  }

  @override
  signInWithApple() {
    try {
      throw UnimplementedError();
    } on FireException {
      throw FireException();
    }
  }

  @override
  signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) throw FireException();
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final user = (await _auth.signInWithCredential(credential)).user;
      String id = user!.uid;
      await _firestore.collection('users').doc(id).set({
        'username': user.displayName,
        'email': user.email,
        'imageUrl': user.photoURL,
      });
      return AuthModel(
        uid: user.uid,
        email: user.email,
        displayName: user.displayName,
        photoURL: user.photoURL,
      );
    } on FireException {
      throw FireException();
    }
  }

  @override
  signUpWithEmail(String username, String email, String password) async {
    try {
      final user = (await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
      String id = user!.uid;
      await _firestore.collection('users').doc(id).set({
        'username': username,
        'email': email,
        'imageUrl': '',
      });
      return AuthModel(
        uid: user.uid,
        email: user.email,
        displayName: user.displayName,
        photoURL: user.photoURL,
      );
    } on FireException {
      throw FireException();
    }
  }

  @override
  forgetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
    } on FireException {
      throw FireException();
    }
  }

  @override
  checkAuthState() async {
    try {
      return _auth.currentUser;
    } on FireException {
      throw FireException();
    }
  }

  @override
  updateProfileImage(String id, Uint8List image) async {
    try {
      Reference ref = _storage.ref().child('profile_images/$id.jpg');
      await ref.putData(image);
      String imageUrl = await ref.getDownloadURL();
      await _firestore.collection('users').doc(id).update({
        'imageUrl': imageUrl,
      });
    } on FireException {
      throw FireException();
    }
  }

  @override
  getAuthDetails(String id) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(id).get();
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return AuthModel(
        uid: id,
        email: data['email'],
        displayName: data['username'],
        photoURL: data['imageUrl'],
      );
    } on FireException {
      throw FireException();
    }
  }

  @override
  getUserStreak(String id) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('users_streak').doc(id).get();
      if (doc.exists) {
        return StreakModel.fromMap(doc.data() as Map<String, dynamic>);
      }
      return null;
    } on FireException {
      throw FireException();
    }
  }

  @override
  updateUserStreak(String id, StreakModel streakData) async {
    try {
      await _firestore
          .collection('users_streak')
          .doc(id)
          .set(streakData.toMap());
    } on FireException {
      throw FireException();
    }
  }
}
