import 'package:quiz_me/main/imports.dart';

class Push {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static final context = navigatorKey.currentContext!;

  static Future<dynamic> to({required String route, Object? arg}) async {
    return await navigatorKey.currentState?.pushNamed(route, arguments: arg);
  }

  static Future<dynamic> replace({required String route, Object? arg}) async {
    return await navigatorKey.currentState
        ?.pushReplacementNamed(route, arguments: arg);
  }

  static back({Object? result}) {
    return navigatorKey.currentState?.pop(result);
  }
}
