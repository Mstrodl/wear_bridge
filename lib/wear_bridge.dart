
import 'wear_bridge_platform_interface.dart';

class WearBridge {
  static Future<bool> isWatch() {
    return WearBridgePlatform.instance.isWatch();
  }

  static Future<void> openUrl(String url) async {
    return WearBridgePlatform.instance.openUrl(url);
  }
}
