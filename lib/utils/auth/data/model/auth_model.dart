class AuthModel {
  final String? uid;
  final String? email;
  final String? displayName;
  final String? photoURL;

  const AuthModel({
    this.uid,
    this.email,
    this.displayName,
    this.photoURL,
  });

  Map<String, Object?> toJson() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoURL': photoURL,
    };
  }

  static AuthModel fromJson(Map<String, Object?> json) {
    return AuthModel(
      uid: json['uid'] == null ? null : json['uid'] as String,
      email: json['email'] == null ? null : json['email'] as String,
      displayName:
          json['displayName'] == null ? null : json['displayName'] as String,
      photoURL: json['photoURL'] == null ? null : json['photoURL'] as String,
    );
  }
}
