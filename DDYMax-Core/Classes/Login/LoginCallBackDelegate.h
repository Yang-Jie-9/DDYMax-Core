//
//  LoginCallBackDelegate.h
//  DDYMax
//
//  Created by engineBUD on 2023/11/2.
//

#ifndef LoginCallBackDelegate_h
#define LoginCallBackDelegate_h

@protocol LoginCallBackDelegate <NSObject>



-(void)onLoginSuccess:(NSString*)type
             userData:(NSString*)userData;

-(void)onLoginFailed:(NSString*)type
             err:(NSString*)err;

-(void)onLogout:(NSString*)type
             err:(NSString*)err;


-(void)onAccountChange:(NSString*)newUserData;

@end

#endif /* LoginCallBackDelegate_h */
