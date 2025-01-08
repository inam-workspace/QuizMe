class AuthModel {
  final String? uid;
  final String? email;
  final String? displayName;
  final String? photoURL;
  final List<dynamic>? studyGuides;

  const AuthModel({
    this.uid,
    this.email,
    this.displayName,
    this.photoURL,
    this.studyGuides,
  });

  Map<String, Object?> toJson() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoURL': photoURL,
      'study_guides': studyGuides,
    };
  }

  static AuthModel fromJson(Map<String, Object?> json) {
    return AuthModel(
      uid: json['uid'] == null ? null : json['uid'] as String,
      email: json['email'] == null ? null : json['email'] as String,
      displayName:
          json['displayName'] == null ? null : json['displayName'] as String,
      photoURL: json['photoURL'] == null ? null : json['photoURL'] as String,
      studyGuides: json['study_guides'] == null
          ? null
          : json['study_guides'] as List<dynamic>,
    );
  }
}
