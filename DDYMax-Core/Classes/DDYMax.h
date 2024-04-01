//
//  DDYMax.h
//  DDYMax
//
//  Created by engineBUD on 2023/11/2.
//
#import <Foundation/Foundation.h>
//Base
#import "BaseSdk.h"
#import "BaseSdkConfig.h"

//Ad
#import "AdCallBackDelegate.h"
#import "AdDelegate.h"
#import "AdStatus.h"
#import "BaseAdData.h"
#import "BaseAdInfo.h"
#import "BaseAdParams.h"

//Device
#import "DeviceCallBackDelegate.h"

//Event
#import "EventDelegate.h"

//Login
#import "LoginCallBackDelegate.h"
#import "LoginDelegate.h"

//Pay
#import "BasePayInfo.h"
#import "BasePayParams.h"
#import "PayCallBackDelegate.h"
#import "PayDelegate.h"


NS_ASSUME_NONNULL_BEGIN

@interface DDYMax  : NSObject


+ (instancetype) share;


- (NSMutableArray<BaseSdk*>*)getSdks;
- (UIViewController*) getViewController;

- (void)login:(NSString*)type;
- (void)logout:(NSString*)type;

@property(nonatomic) id<AdCallBackDelegate> adCallBack;
@property(nonatomic) id<PayCallBackDelegate> payCallBack;
@property(nonatomic) id<LoginCallBackDelegate> loginCallBack;
@property(nonatomic) id<DeviceCallBackDelegate> deviceCallBack;


@end

NS_ASSUME_NONNULL_END

