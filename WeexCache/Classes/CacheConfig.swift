//
//  CacheConfig.swift
//  WeexCache_Example
//
//  Created by 陈广川 on 2018/3/5.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import Foundation

struct CacheManagerConfig: CacheConfig {
	
	static let weexPath: String = {
		guard let pathStirng = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first else {
			return ""
		}
		return NSString(string: pathStirng).appendingPathComponent("WeexCache")
	}()
	
	var cachePath: String {
		return CacheManagerConfig.weexPath
	}
	
}
