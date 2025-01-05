

import 'package:quiz_me/main/imports.dart';

abstract class NetworkInfo {
  Future<bool>? get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  static Dio dio = Dio();
  static Uri testHost = Uri.parse('https://example.com');
  static final Connectivity connectivity = Connectivity();
  @override
  Future<bool> get isConnected => check();
  static Future<bool> check() async {
    bool connected = false;
    await connectivity.checkConnectivity().then((value) async {
      if (value.first == ConnectivityResult.wifi ||
          value.first == ConnectivityResult.mobile) {
        if (await isInternetConnected == true) {
          connected = true;
        } else {
          connected = false;
        }
      } else {
        connected = false;
      }
    });
    return connected;
  }

  static Future<bool> get isInternetConnected async {
    try {
      Response res = await dio.get(testHost.toString());
      if (res.statusCode == 200) {
        return true;
      }
      return false;
    } catch (_) {
      return false;
    }
  }
}
