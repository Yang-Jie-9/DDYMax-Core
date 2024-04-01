//
//  BaseSdk.m
//  DDYMax
//
//  Created by engineBUD on 2023/11/2.
//

#import "BaseSdk.h"

@implementation BaseSdk

- (void)didBecomeActive:(nonnull UIApplication *)application {
}

- (void)didEnterBackground:(nonnull UIApplication *)application {
}

- (nonnull NSString *)getType {
    return NSStringFromClass([self class]);
}

- (void)initConfig:(nonnull id)config {
}

- (void)willEnterForeground:(nonnull UIApplication *)application {
}

- (void)willResignActive:(nonnull UIApplication *)application {
}

- (void)willTerminate:(nonnull UIApplication *)application {
}

- (void)application:(nonnull UIApplication *)application didFinishLaunchingWithOptions:(nonnull NSDictionary *)launchOptions {
   
}

- (void)application:(nonnull UIApplication *)application openURL:(nonnull NSURL *)url sourceApplication:(nonnull NSString *)sourceApplication annotation:(nonnull id)annotation {
}

- (void)application:(nonnull UIApplication *)application continueUserActivity:(nonnull NSUserActivity *)userActivity restorationHandler:(nonnull void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable __strong))restorationHandler {
}

@end
