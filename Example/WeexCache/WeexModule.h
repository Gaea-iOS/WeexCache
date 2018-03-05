//
//  WeexModule.h
//  WeexCache_Example
//
//  Created by 陈广川 on 2018/1/18.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WeexSDK/WeexSDK.h>

@interface WeexModule : NSObject <WXModuleProtocol>

- (void)weexModuleWithURLString: (NSString *)urlString callback: (WXModuleCallback *)callback;

@end
