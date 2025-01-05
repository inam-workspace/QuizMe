class StreakModel {
  final int streak;
  final DateTime lastLoginDate;

  StreakModel({required this.streak, required this.lastLoginDate});

  factory StreakModel.fromMap(Map<String, dynamic> data) {
    return StreakModel(
      streak: data['streak'],
      lastLoginDate: DateTime.parse(data['lastLoginDate']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'streak': streak,
      'lastLoginDate': lastLoginDate.toIso8601String(),
    };
  }
}
