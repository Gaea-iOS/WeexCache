//
//  WeexNavigatorImp.swift
//  WeexCache_Example
//
//  Created by 陈广川 on 2018/1/18.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
import WeexSDK

class WeexNavigatorImp: NSObject, WXNavigationProtocol {
	func navigationController(ofContainer container: UIViewController!) -> Any! {
		return container.navigationController
	}
	
	func setNavigationBarHidden(_ hidden: Bool, animated: Bool, withContainer container: UIViewController!) {
		container.navigationController?.setNavigationBarHidden(hidden, animated: animated)
	}
	
	func setNavigationBackgroundColor(_ backgroundColor: UIColor!, withContainer container: UIViewController!) {
		
	}
	
	func setNavigationItemWithParam(_ param: [AnyHashable : Any]!, position: WXNavigationItemPosition, completion block: WXNavigationResultBlock!, withContainer container: UIViewController!) {
		
	}
	
	func clearNavigationItem(withParam param: [AnyHashable : Any]!, position: WXNavigationItemPosition, completion block: WXNavigationResultBlock!, withContainer container: UIViewController!) {
		
	}
	
	func pushViewController(withParam param: [AnyHashable : Any]!, completion block: WXNavigationResultBlock!, withContainer container: UIViewController!) {

	}
	
	func popViewController(withParam param: [AnyHashable : Any]!, completion block: WXNavigationResultBlock!, withContainer container: UIViewController!) {
		
	}
	

}
