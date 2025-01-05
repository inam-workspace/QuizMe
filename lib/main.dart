import 'package:quiz_me/main/imports.dart';

void main() => mainCommon();

Future<void> mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfigs.instance.initialize();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}
