//
//  AdCallBackDelegate.h
//  DDYMax
//
//  Created by engineBUD on 2023/11/2.
//

#ifndef AdCallBackDelegate_h
#define AdCallBackDelegate_h

@protocol AdCallBackDelegate <NSObject>


-(void)onAdStartLoad:(NSString*)alias
                info:(NSString*)info;
-(void)onAdAttempt:(NSString*)alias
              info:(NSString*)info;
-(void)onAdLoadFail:(NSString*)alias
               info:(NSString*)info;
-(void)onAdLoadSuccess:(NSString*)alias
                  info:(NSString*)info;
-(void)onAdFailed:(NSString*)alias
                 info:(NSString*)info
                 err:(NSString*)err;
-(void)onAdClicked:(NSString*)alias
                  info:(NSString*)info;
-(void)onAdClosed:(NSString*)alias
                 info:(NSString*)info;
-(void)onAdReward:(NSString*)alias
                 info:(NSString*)info;
-(void)onAdShowed:(NSString*)alias
                 info:(NSString*)info;

@end

#endif /* AdCallBackDelegate_h */
