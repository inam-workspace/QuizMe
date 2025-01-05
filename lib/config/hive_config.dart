
import 'package:quiz_me/main/imports.dart';

class HiveConfigs {
  static final Completer<HiveConfigs> _completer = Completer<HiveConfigs>();
  static HiveConfigs? _instance;

  factory HiveConfigs() {
    return _instance!;
  }

  HiveConfigs._();
  static Future<HiveConfigs> initialize() async {
    if (_instance == null) {
      _instance = HiveConfigs._();
      await Hive.initFlutter();
      // Adapter
      Hive.registerAdapter<GuideDetailsModel>(GuideDetailsAdapter());
      Hive.registerAdapter<NotesModel>(NotesAdapter());
      // Boxes
      await Hive.openBox<GuideDetailsModel>(cachedGuideDetails);
      await Hive.openBox<NotesModel>(cachedNotes);
      _completer.complete(_instance);
    }
    return _completer.future;
  }
}
