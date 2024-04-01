//
//  LoginDelegate.h
//  DDYMax
//
//  Created by engineBUD on 2023/11/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LoginDelegate <NSObject>
-(void) login;
-(void) logout;

@end

NS_ASSUME_NONNULL_END
