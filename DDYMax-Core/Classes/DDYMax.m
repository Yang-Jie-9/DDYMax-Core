//
//  DDYMax.m
//  DDYMax
//
//  Created by engineBUD on 2023/11/2.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "DDYMax.h"
#import "AudioToolbox/AudioToolbox.h"
#import <AdSupport/ASIdentifierManager.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <StoreKit/StoreKit.h>

NSMutableArray<BaseSdk*>* sdks;
UIViewController* viewController;
id<AdCallBackDelegate> adCallBackDelegate;
id<PayCallBackDelegate> payCallBackDelegate;
id<LoginCallBackDelegate> loginCallBackDelegate;
id<DeviceCallBackDelegate> deviceCallBackDelegate;


static DDYMax* instance;

@implementation DDYMax

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initConfig];
        [self initLifeCycle];
        [self initNotification];
        
    }
    return self;
}


// 初始化配置
- (void)initConfig {
    
    sdks = [NSMutableArray arrayWithCapacity:5];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"SdkConfig" ofType:@"json" inDirectory:@"Data/Raw"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSData *configData = [[NSFileManager defaultManager] contentsAtPath:filePath];
        NSError *error = nil;
        NSLog(@"filePath %@", filePath);
        NSArray *configArray = [NSJSONSerialization JSONObjectWithData:configData options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            NSLog(@"SDKControl JSON转换错误：%@", error);
        } else {
            for (int index = 0; index < configArray.count; index++) {
                NSDictionary* sdkConfig = configArray[index];
                BOOL enable = [sdkConfig valueForKey:@"enable"];
                if (enable == NO) {
                    continue;
                }
                NSString* classPath = [sdkConfig valueForKey:@"className"];
                NSArray *classPathArray = [classPath componentsSeparatedByString:@"."];
                NSString * className = classPathArray[classPathArray.count - 1];
                Class sdkClass = NSClassFromString(className);
                if (sdkClass != nil) {
                    BaseSdk* sdkObj = [[sdkClass alloc] init];
                    [sdkObj initConfig:sdkConfig];
                    NSLog(@"SDKControl: %@", className);
                    [sdks addObject:sdkObj];
                } else {
                    NSLog(@"SDKControl no class: %@", className);
                }
            }
        }
    } else {
        NSLog(@"SDKControl File does not exist. %@", filePath);
    }
}

-(void)initLifeCycle{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishLaunching:) name:UIApplicationDidFinishLaunchingNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willTerminate:) name:UIApplicationWillTerminateNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openURLOptionsSourceApplication:) name:@"kUnityOnOpenURL" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(continueUserActivity:) name:@"kUnityContinueUserActivity" object:nil];
}


- (void)initNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onUnityNotification:) name:@"UnityNotification" object:nil];
}

- (void)onUnityNotification:(NSNotification*) notification {
    NSDictionary* userInfo = notification.userInfo;
    NSString* name = [userInfo objectForKey:@"name"];
    NSObject* args = [userInfo objectForKey:@"args"];
    
    NSLog(@"NSNotification: onUnityNotification name: %@, args: %@", name, args);
    SEL selector = NSSelectorFromString(name);
    NSMethodSignature * methodSignature = [self methodSignatureForSelector:selector];
    if (methodSignature != nil) {
        NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
        [invocation setSelector:selector];
        if(args != nil) {
            [invocation setArgument:&args atIndex:2];
        }
        [invocation invokeWithTarget:self];
    } else {
        NSLog(@"DDYMax: 找不到对应的方法 %@", name);
    }
}

- (void)showAd:(NSString*)args {
    bool isShowed = false;
    for (BaseSdk* tmpSdk in sdks) {
        if ([tmpSdk conformsToProtocol:@protocol(AdDelegate)]) {
            if ([(BaseSdk<AdDelegate>*)tmpSdk showAd:args]) {
                isShowed = true;
                break;
            }
        }
    }
    if (!isShowed && adCallBackDelegate != nil) {
        [adCallBackDelegate onAdFailed:@"" info:@"{}" err:@"无可以展示的广告"];
    }
}

- (void)login:(NSString*)type {
    BaseSdk<LoginDelegate> * defaultLoginSdk = nil;
    bool isLogged = false;
    for (BaseSdk* tmpSdk in sdks) {
        if ([tmpSdk conformsToProtocol:@protocol(LoginDelegate)]) {
            BaseSdk<LoginDelegate> * loginDelegate = (BaseSdk<LoginDelegate>*)tmpSdk;
            if (defaultLoginSdk == nil) {
                defaultLoginSdk = loginDelegate;
            }
            if ([[loginDelegate getType] isEqualToString:type]) {
                [loginDelegate login];
                isLogged = true;
            }
        }
    }
    if (!isLogged && defaultLoginSdk != nil) {
        [defaultLoginSdk login];
    } else if(!isLogged && defaultLoginSdk == nil && loginCallBackDelegate != nil) {
        [loginCallBackDelegate onLoginFailed:type err:@"无可以登陆的SDK"];
    }
}

- (void)logout:(NSString*)type {
    BaseSdk<LoginDelegate> * defaultLoginSdk = nil;
    bool isLogged = false;
    for (BaseSdk* tmpSdk in sdks) {
        if ([tmpSdk conformsToProtocol:@protocol(LoginDelegate)]) {
            BaseSdk<LoginDelegate> * loginDelegate = (BaseSdk<LoginDelegate>*)tmpSdk;
            if (defaultLoginSdk == nil) {
                defaultLoginSdk = loginDelegate;
            }
            if ([[loginDelegate getType] isEqualToString:type]) {
                [loginDelegate logout];
                isLogged = true;
            }
        }
    }
    if (!isLogged && defaultLoginSdk != nil) {
        [defaultLoginSdk logout];
    } else if(!isLogged && defaultLoginSdk == nil && loginCallBackDelegate != nil) {
        [loginCallBackDelegate onLogout:type err:@"无可以登出的SDK"];
    }
}



- (void)pay:(NSString*)args {
    bool isPaid = false;
    JSONModelError* err = nil;
    BasePayParams* basePayParams = [[BasePayParams alloc] initWithString:args error:&err];
    if (err != nil) {
        NSLog(@"Parse PayParams Error: %ld", (long)err.code);
        basePayParams = [BasePayParams alloc];
        basePayParams.alias = args;
    }
    for (BaseSdk* tmpSdk in sdks) {
        if ([tmpSdk conformsToProtocol:@protocol(PayDelegate)]) {
            if ([(BaseSdk<PayDelegate>*)tmpSdk pay:args]) {
                isPaid = true;
                break;
            }
        }
    }
    if (!isPaid && payCallBackDelegate) {
        [payCallBackDelegate onPayFail:basePayParams.alias err:@"无可以支付的SDK"];
    }
}

- (void)getPurchaseList {
    for (BaseSdk* tmpSdk in sdks) {
        if ([tmpSdk conformsToProtocol:@protocol(PayDelegate)]) {
            [(BaseSdk<PayDelegate>*)tmpSdk getPurchaseList];
        }
    }
}

- (void)review {
    if (@available(iOS 10.3, *)) {
        [SKStoreReviewController requestReview];
    } else {
        NSDictionary *infoDictionary=[[NSBundle mainBundle]infoDictionary];
        NSString *appId = [infoDictionary objectForKey:@"AppID"];
        if (appId != nil) {
            NSString* urlStr = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@?action=write-review", appId];
            NSURL* url = [NSURL URLWithString:urlStr];
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        } else {
            NSLog(@"AppID 为null");
        }
    }
}

-(void)trigger:(NSDictionary*)args {
    NSString* eventName = [args objectForKey:@"eventName"];
    NSString* eventData = [args objectForKey:@"eventData"];
    
    NSData * _Nullable data =  [eventData dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary<NSString*, NSString*> *eventDic = nil;
    if (data != nil) {
        NSError *error = nil;
        eventDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error != nil) {
            NSLog(@"error: %@", error.domain);
        }
    }
    
    if (eventDic == nil) {
        if (eventData == NULL || eventData.length == 0) {
            eventDic = [NSMutableDictionary dictionaryWithDictionary:@{}];
        } else {
            eventDic = [NSMutableDictionary dictionaryWithObject:eventData forKey:@"arg"];
        }
    }
    for (BaseSdk* tmpSdk in sdks) {
        if ([tmpSdk conformsToProtocol:@protocol(EventDelegate)]) {
            [(BaseSdk<EventDelegate>*)tmpSdk trigger:eventName value:eventDic];
        }
    }
}

- (void)level:(NSDictionary*)args {
    NSString* levelName = [args objectForKey:@"levelName"];
    NSString* levelStatusValue = [args objectForKey:@"levelStatus"];
    int levelStatus = [levelStatusValue intValue];
    for (BaseSdk* tmpSdk in sdks) {
        if ([tmpSdk conformsToProtocol:@protocol(EventDelegate)]) {
            [(BaseSdk<EventDelegate>*)tmpSdk level:levelName status:levelStatus];
        }
    }
}

- (void)consume:(NSString*)args {
    for (BaseSdk* tmpSdk in sdks) {
        if ([tmpSdk conformsToProtocol:@protocol(PayDelegate)]) {
            [(BaseSdk<PayDelegate>*)tmpSdk consume:args];
        }
    }
}


- (void)getDeviceId {
    if (@available(iOS 14, *)) {
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            if (status == ATTrackingManagerAuthorizationStatusAuthorized) {
                NSString* uuid = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
                if (deviceCallBackDelegate != nil) {
                    [deviceCallBackDelegate onGetDevice:uuid];
                }
            } else {
                if (deviceCallBackDelegate != nil) {
                    [deviceCallBackDelegate onGetDevice:@""];
                }
            }
        }];
    } else {
        NSLog(@"UUID null");
        if ([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]) {
            NSString* uuid = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
            if (deviceCallBackDelegate != nil) {
                [deviceCallBackDelegate onGetDevice:uuid];
            }
        } else {
            if (deviceCallBackDelegate != nil) {
                [deviceCallBackDelegate onGetDevice:@""];
            }
        }
    }
}

- (void)getReferrer {
    NSLog(@"NSNotification getReferrer");
}

- (void)vibrate:(NSString*) milliseconds {
    int value = [milliseconds intValue];
    
    if (value < 1000) {
        UIImpactFeedbackStyle style = UIImpactFeedbackStyleLight;
        if (value <= 100) {
            style = UIImpactFeedbackStyleLight;
        } else if (value <= 200) {
            style = UIImpactFeedbackStyleMedium;
        } else {
            style = UIImpactFeedbackStyleHeavy;
        }
        if (@available(iOS 10.0, *)) {
            UIImpactFeedbackGenerator *r = [[UIImpactFeedbackGenerator alloc] initWithStyle:style];
            [r prepare];
            [r impactOccurred];
        } else {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        }
    } else {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
    
}


- (void)didFinishLaunching:(NSNotification*)notification {
    for (int index = 0; index < sdks.count; index++) {
        [sdks[index] application:(UIApplication*)notification.object didFinishLaunchingWithOptions:notification.userInfo];
    }
    
}


- (void)didBecomeActive:(NSNotification*)notification {
    for (int index = 0; index < sdks.count; index++) {
        [sdks[index] didBecomeActive:(UIApplication*)notification.object];
    }
}


- (void)willResignActive:(NSNotification*)notification {
    for (int index = 0; index < sdks.count; index++) {
        [sdks[index] willResignActive:(UIApplication*)notification.object];
    }
}


- (void)didEnterBackground:(NSNotification*)notification {
    for (int index = 0; index < sdks.count; index++) {
        [sdks[index] didEnterBackground:(UIApplication*)notification.object];
    }
}


- (void)willEnterForeground:(NSNotification*)notification {
    for (int index = 0; index < sdks.count; index++) {
        [sdks[index] willEnterForeground:(UIApplication*)notification.object];
    }
}


- (void)willTerminate:(NSNotification*)notification {
    for (int index = 0; index < sdks.count; index++) {
        [sdks[index] willTerminate:(UIApplication*)notification.object];
    }
}

- (void)openURLOptionsSourceApplication:(NSNotification*)notification {
    NSDictionary* notifData = notification.userInfo;
    NSURL* url = [notifData objectForKey:@"url"];
    NSString* sourceApplication = [notifData objectForKey:@"sourceApplication"];
    id annotation = [notifData objectForKey:@"annotation"];
    for (BaseSdk* tmpSdk in sdks) {
        [tmpSdk application:notification.object openURL:url sourceApplication:sourceApplication annotation:annotation];
    }
}

- (void)continueUserActivity: (NSNotification*)notification {
    
    NSDictionary* notifData = notification.userInfo;
    NSUserActivity * userActivity = [notifData objectForKey:@"userActivity"];
    for (BaseSdk* tmpSdk in sdks) {
        [tmpSdk application:notification.object continueUserActivity:userActivity restorationHandler:[notifData objectForKey:@"restorationHandler"]];
    }
}


- (UIViewController *)getViewController {
    return viewController;
}

- (void)setViewController:(UIViewController*)controller {
    viewController = controller;
}

- (NSMutableArray<BaseSdk *> *)getSdks {
    return sdks;
}



+ (nonnull instancetype)share {
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init] ;
    }) ;
    return instance ;
}

@end
