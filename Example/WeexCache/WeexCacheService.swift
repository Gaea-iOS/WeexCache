//
//  WeexCacheService.swift
//  WeexCache_Example
//
//  Created by 陈广川 on 2018/1/10.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit

class WeexCacheService: NSObject {
	
	override init() {
		super.init()
	}
	
	private let queue: OperationQueue = OperationQueue()
	
	private lazy var session: URLSession = { [unowned self] in
		let configuration = URLSessionConfiguration.init()
		let session = URLSession(configuration: configuration, delegate: self, delegateQueue: queue)
		return session
	}()
	
	func syscWeexManifest(urlString: String) {
		guard let url = URL.init(string: urlString) else { return }
		let task = session.dataTask(with: url)
		task.resume()
	}
	
}

