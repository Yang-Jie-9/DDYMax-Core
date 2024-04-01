//
//  BaseSdkConfig.h
//  DDYFramework
//
//  Created by engineBUD on 2023/11/2.
//

//#import <JSONModel/JSONModel.h>

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <DDYMax_JSONModel/JSONModelLib.h>
NS_ASSUME_NONNULL_BEGIN

@interface BaseSdkConfig : JSONModel
@property(nonatomic) BOOL enable;
-(instancetype)initWith:(id)config;

@end

NS_ASSUME_NONNULL_END
