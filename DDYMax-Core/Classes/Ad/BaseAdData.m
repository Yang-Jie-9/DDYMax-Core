//
//  AdData.m
//  DDYMax
//
//  Created by engineBUD on 2023/11/2.
//

#import "BaseAdData.h"

@implementation BaseAdData

- (nonnull instancetype)initWith:(nonnull id)config {
    NSDictionary* tmpConfig = config;
    self.adId = tmpConfig[@"adId"];
    self.status = NONE;
    return self;
}

@end
