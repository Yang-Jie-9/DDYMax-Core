//
//  EventDelegate.h
//  DDYMax
//
//  Created by engineBUD on 2023/11/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol EventDelegate

-(void) level:(NSString*)level status:(int)status;
-(void) trigger:(NSString*)eventName value:(NSDictionary<NSString*, NSString*> *)eventMap;
@end

NS_ASSUME_NONNULL_END
