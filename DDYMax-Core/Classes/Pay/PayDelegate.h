//
//  PayDelegate.h
//  DDYMax
//
//  Created by engineBUD on 2023/11/3.
//

#import <Foundation/Foundation.h>
#ifndef PayDelegate_h
#define PayDelegate_h

@protocol PayDelegate


-(bool)pay:(NSString*) payParams;
-(void)getPurchaseList;
-(void)consume:(NSString*) purchaseParams;

@end

#endif /* PayDelegate_h */
