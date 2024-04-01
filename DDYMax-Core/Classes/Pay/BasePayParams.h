//
//  BasePayParams.h
//  DDYMax
//
//  Created by engineBUD on 2023/11/3.
//

#import <Foundation/Foundation.h>
#import <DDYMax_JSONModel/JSONModelLib.h>
NS_ASSUME_NONNULL_BEGIN

@interface BasePayParams : JSONModel

@property(nonatomic) NSString* alias;
@property(nonatomic, nullable) NSString *orderId;

@end

NS_ASSUME_NONNULL_END
