//
//  BaseSdk.h
//  DDYMax
//
//  Created by engineBUD on 2023/11/2.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface BaseSdk : NSObject


-(void)initConfig:(id)config;
-(NSString*) getType;
- (void)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary* )launchOptions;
- (void)didBecomeActive:(UIApplication*)application;
- (void)willResignActive:(UIApplication*)application;
- (void)didEnterBackground:(UIApplication*)application;
- (void)willEnterForeground:(UIApplication*)application;
- (void)willTerminate:(UIApplication*)application;
-(void)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

- (void)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray<id<UIUserActivityRestoring>> * __nullable restorableObjects))restorationHandler;

@end

NS_ASSUME_NONNULL_END
