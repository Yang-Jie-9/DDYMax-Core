//
//  DDYMax.h
//  DDYMax
//
//  Created by engineBUD on 2023/11/2.
//
#import <Foundation/Foundation.h>
#import <DDYMax_Core/CoreLib.h>

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

