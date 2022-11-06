#import "WearBridgePlugin.h"
#if __has_include(<wear_bridge/wear_bridge-Swift.h>)
#import <wear_bridge/wear_bridge-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "wear_bridge-Swift.h"
#endif

@implementation WearBridgePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftWearBridgePlugin registerWithRegistrar:registrar];
}
@end
