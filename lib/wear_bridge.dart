
import 'wear_bridge_platform_interface.dart';

class WearBridge {
  Future<bool> isWatch() {
    return WearBridgePlatform.instance.isWatch();
  }

  Future<void> openUrl(String url) async {
    return WearBridgePlatform.instance.openUrl(url);
  }
}
