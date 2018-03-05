//
//  WeexCacheService.swift
//  WeexCache_Example
//
//  Created by 陈广川 on 2018/1/10.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit

public class WeexCacheService: NSObject {
	
	public override init() {
		super.init()
	}

	private let queue: OperationQueue = OperationQueue()
	
	private let session = URLSession.init(configuration: URLSessionConfiguration.default)

//	public func cacheWeexJsFile(urlString: String,
//								 complitionHandler: ((CacheModelList, Data) -> Void)?,
//								 errorHandler: ((Error?) -> Void)? = nil) {
//		guard let url = URL.init(string: urlString) else { return }
//		
//	}

	public func syscWeexManifest(urlString: String,
								 complitionHandler: ((CacheModelList, Data) -> Void)?,
								 errorHandler: ((Error?) -> Void)? = nil) {
		guard let url = URL.init(string: urlString) else { return }
		let task = session.dataTask(with: url) { (data, response, error) in
			
			WXCDprint("syscWeexManifest urlString: \(urlString)\n response:\(response)\n error:\(error)")
			
			guard error == nil else {
				errorHandler?(error)
				return
			}
			
			guard  let jsonData = data else {
				let error = NSError.init(domain: "data nil", code: 99999, userInfo: [NSDebugDescriptionErrorKey: "json data is nil!"])
				errorHandler?(error)
				return
			}
			
			do {
				let cacheModelList = try JSONDecoder().decode(CacheModelList.self, from: jsonData)
				complitionHandler?(cacheModelList, jsonData)
			} catch let decodeError {
				errorHandler?(decodeError)
			}
		}
		task.resume()
	}

}

