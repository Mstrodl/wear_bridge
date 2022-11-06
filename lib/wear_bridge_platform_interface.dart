import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'wear_bridge_method_channel.dart';

abstract class WearBridgePlatform extends PlatformInterface {
  /// Constructs a WearBridgePlatform.
  WearBridgePlatform() : super(token: _token);

  static final Object _token = Object();

  static WearBridgePlatform _instance = MethodChannelWearBridge();

  /// The default instance of [WearBridgePlatform] to use.
  ///
  /// Defaults to [MethodChannelWearBridge].
  static WearBridgePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [WearBridgePlatform] when
  /// they register themselves.
  static set instance(WearBridgePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> isWatch() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> openUrl(String url) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
