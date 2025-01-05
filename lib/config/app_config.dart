import 'package:quiz_me/main/imports.dart';

class AppConfigs {
  static AppConfigs instance = AppConfigs._();

  factory AppConfigs() {
    return instance;
  }

  AppConfigs._();
  Future initialize() async {
    await Firebase.initializeApp();
    await HiveConfigs.initialize();
  }
}
