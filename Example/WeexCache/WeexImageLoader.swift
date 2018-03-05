//
//  WeexImageLoader.swift
//  WeexCache_Example
//
//  Created by 陈广川 on 2018/1/18.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
import WeexSDK
import WeexCache

class WeexImageLoader: NSObject, WXImgLoaderProtocol  {
	
	func downloadImage(withURL url: String!, imageFrame: CGRect, userInfo options: [AnyHashable : Any]! = [:], completed completedBlock: ((UIImage?, Error?, Bool) -> Void)!) -> WXImageOperationProtocol! {
		guard let imageUrl = URL.init(string: url) else {
			completedBlock?(nil, nil, false)
			return URLSessionDownloadTask()
		}
		return URLSession.shared.downloadTask(with: imageUrl, completionHandler: { (imageLocalUrl, response, error) in
			completedBlock?(UIImage.init(contentsOfFile: imageLocalUrl?.absoluteString ?? ""), error, error != nil)
		})
	}
	
}

extension URLSessionDownloadTask: WXImageOperationProtocol {}


