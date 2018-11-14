#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#include "FlutterJPushPlugin.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [GeneratedPluginRegistrant registerWithRegistry:self];
    [self startupJPush:launchOptions appKey:@"fd47901d984c863d4febe834" channel:@"jpush" isProduction:FALSE];
  // Override point for customization after application launch.
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
