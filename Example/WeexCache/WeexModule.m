//
//  WeexModule.m
//  WeexCache_Example
//
//  Created by 陈广川 on 2018/1/18.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

#import "WeexModule.h"

@implementation WeexModule
WX_EXPORT_METHOD(@selector(weexModuleWithURLString:callback:))

- (void)weexModuleWithURLString: (NSString *)urlString callback: (WXModuleCallback *)callback {
	NSLog(@"weexModuleWithURLString: %@, callback: %@", urlString, callback);
}

@end
