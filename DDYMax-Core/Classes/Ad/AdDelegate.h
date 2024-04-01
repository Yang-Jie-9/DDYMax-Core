//
//  AdDelegate.h
//  DDYMax
//
//  Created by engineBUD on 2023/11/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AdDelegate <NSObject>

-(BOOL) showAd:(NSString*) adParamsValue;
-(BOOL) isAdReady:(NSString*) adParamsValue;

@end

NS_ASSUME_NONNULL_END
