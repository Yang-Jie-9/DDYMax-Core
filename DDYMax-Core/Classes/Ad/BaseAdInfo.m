//
//  AdInfo.m
//  DDYMax
//
//  Created by engineBUD on 2023/11/2.
//

#import "BaseAdInfo.h"

@implementation BaseAdInfo

- (instancetype)initWith:(nonnull id)config {
    NSDictionary* tmpConfig = config;
    self.alias = [tmpConfig valueForKey:@"alias"];
    self.adData = [NSMutableArray array];
    self.status = NONE;
    return self;
}

@end
