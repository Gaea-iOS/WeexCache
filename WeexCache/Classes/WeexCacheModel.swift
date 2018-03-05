//
//  WeexCacheModel.swift
//  WeexCache_Example
//
//  Created by 陈广川 on 2018/1/11.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit

public typealias CacheModelList = [String: CacheModel]

public struct CacheModel: Codable {
	let md5: String
	let path: String
}
