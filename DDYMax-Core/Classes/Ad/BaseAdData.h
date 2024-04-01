//
//  AdData.h
//  DDYMax
//
//  Created by engineBUD on 2023/11/2.
//

#import <Foundation/Foundation.h>
#import "DDYMax_Core/AdStatus.h"
#import <DDYMax_JSONModel/JSONModelLib.h>
NS_ASSUME_NONNULL_BEGIN

@interface BaseAdData : JSONModel
@property(nonatomic, strong) NSString* adId;
@property(nonatomic) AdStatus status;
-(instancetype)initWith:(id)config;
@end

NS_ASSUME_NONNULL_END
