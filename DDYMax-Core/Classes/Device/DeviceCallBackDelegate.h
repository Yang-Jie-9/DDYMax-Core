//
//  DeviceCallBackDelegate.h
//  DDYMax
//
//  Created by engineBUD on 2023/11/6.
//

#ifndef DeviceCallBackDelegate_h
#define DeviceCallBackDelegate_h

@protocol DeviceCallBackDelegate <NSObject>

-(void)onGetDevice:(NSString*) uuid;

@end

#endif /* DeviceCallBackDelegate_h */
