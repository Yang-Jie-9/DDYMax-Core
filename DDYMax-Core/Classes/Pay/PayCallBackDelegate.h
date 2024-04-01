//
//  PayCallBackDelegate.h
//  DDYMax
//
//  Created by engineBUD on 2023/11/2.
//

#ifndef PayCallBackDelegate_h
#define PayCallBackDelegate_h

@protocol PayCallBackDelegate <NSObject>

-(void)onPaySuccess:(NSString*)alias
             result:(NSString*)result;

-(void)onPayFail:(NSString*)alias
             err:(NSString*)err;

-(void)onPayCancel:(NSString*)alias;

-(void)onGet:(NSString*)purchase;
-(void)onConsumeResponse:(int)code
                   token: (NSString*)token;

@end

#endif /* PayCallBackDelegate_h */
