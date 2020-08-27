#import "AppTrackingTransparencyPlugin.h"
#if __has_include(<app_tracking_transparency/app_tracking_transparency-Swift.h>)
#import <app_tracking_transparency/app_tracking_transparency-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "app_tracking_transparency-Swift.h"
#endif

@implementation AppTrackingTransparencyPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAppTrackingTransparencyPlugin registerWithRegistrar:registrar];
}
@end
