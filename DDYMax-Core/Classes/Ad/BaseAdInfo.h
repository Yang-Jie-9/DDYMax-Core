//
//  AdInfo.h
//  DDYMax
//
//  Created by engineBUD on 2023/11/2.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <DDYMax_JSONModel/JSONModelLib.h>
#import <DDYMax_Core/BaseAdData.h>
NS_ASSUME_NONNULL_BEGIN

@interface BaseAdInfo : JSONModel
@property(nonatomic, strong) NSString* alias;
@property(nonatomic, strong) NSMutableArray<BaseAdData*> *adData;
@property AdStatus status;

-(instancetype)initWith:(id)config;

@end

NS_ASSUME_NONNULL_END
