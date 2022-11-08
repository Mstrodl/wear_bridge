import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'wear_bridge_platform_interface.dart';

/// An implementation of [WearBridgePlatform] that uses method channels.
class MethodChannelWearBridge extends WearBridgePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('wear_bridge');

  @override
  Future<bool> isWatch() async {
    try {
      final result = await methodChannel.invokeMethod<bool>('isWatch');
      return result ?? false;
    } on MissingPluginException {
      return false;
    }
  }

  @override
  Future<void> openUrl(String url) async {
    return await methodChannel.invokeMethod<void>('openUrl', url);
  }
}
