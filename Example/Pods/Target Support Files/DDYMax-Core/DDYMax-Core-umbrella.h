#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "AdCallBackDelegate.h"
#import "AdDelegate.h"
#import "AdStatus.h"
#import "BaseAdData.h"
#import "BaseAdInfo.h"
#import "BaseAdParams.h"
#import "BaseSdk.h"
#import "BaseSdkConfig.h"
#import "CoreLib.h"
#import "DDYMax.h"
#import "DeviceCallBackDelegate.h"
#import "EventDelegate.h"
#import "LoginCallBackDelegate.h"
#import "LoginDelegate.h"
#import "BasePayInfo.h"
#import "BasePayParams.h"
#import "PayCallBackDelegate.h"
#import "PayDelegate.h"
#import "RoleDelegate.h"

FOUNDATION_EXPORT double DDYMax_CoreVersionNumber;
FOUNDATION_EXPORT const unsigned char DDYMax_CoreVersionString[];

