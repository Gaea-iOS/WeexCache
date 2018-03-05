//
//  ViewController.swift
//  WeexCache
//
//  Created by GarenChen on 01/10/2018.
//  Copyright (c) 2018 GarenChen. All rights reserved.
//

import UIKit
import WeexSDK
import WeexCache

class ViewController: UIViewController {

	let bundle = "MatchGoal"
	
	let weexInstance = WXSDKInstance()
	
	let url = URL.init(string: "http://asweex.nowodds.cn/weex/MatchGoal.bundle.js?leagueId=49")!
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
		WeexCacheManager.shared.fetchNewManifest("http://asweex.nowodds.cn/weex/manifest.json")
		
    }
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		setupView()
	}
	
	func setupView() {
		
		weexInstance.viewController = self
		weexInstance.frame = self.view.bounds
		weexInstance.onCreate = { [weak self] view in
			guard let view = view else { return }
			self?.view.addSubview(view)
		}
		weexInstance.onFailed = { error in
			print("weexInstance.onFailed: \(error)")
		}
		
		weexInstance.onJSDownloadedFinish = { [weak self] (rsp, req, data, error) in
			print("weexInstance.onJSDownloadedFinish rsp: \(rsp)")
			print("weexInstance.onJSDownloadedFinish req: \(req)")
			print("weexInstance.onJSDownloadedFinish error: \(error)")
			print("weexInstance.onJSDownloadedFinish data: \(data)")
			guard let `self` = self else { return }
			WeexCacheManager.shared.updateCache(data: data, bundle: self.bundle)
		}
		
		guard let info = WeexCacheManager.shared.getBundleInfo(bundle) else {
			self.weexInstance.render(with: self.url)
			return
		}
		
		if info.isLocalFile {
			weexInstance.renderView(info.localFile, options: ["bundleUrl" : info.bundleUrl, "leagueId" : "49"] , data: nil)
		} else {
			weexInstance.render(with: URL.init(string: info.bundleUrl), options: ["bundleUrl" : info.bundleUrl, "leagueId" : "49"], data: nil)
		}
		
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		weexInstance.frame = view.bounds
	}
	
	deinit {
		weexInstance.destroy()
		weexInstance.forceGarbageCollection()
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

