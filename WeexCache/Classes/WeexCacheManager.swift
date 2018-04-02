//
//  WeexCacheManager.swift
//  WeexCache_Example
//
//  Created by 陈广川 on 2018/1/10.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit

//http://61.143.225.69:8088/weex/manifest.json

/// Weex Manifest 方案: https://www.teambition.com/project/57033c1ad549d95a69997eb5/posts/post/5a433d37dd756d7a7ed49281

let manifestCacheKey = "manifest_key"

public struct WeexBundleInfo {
	public var bundleUrl: String
	public var localFile: String
	public var isLocalFile: Bool
}

public class WeexCacheManager: NSObject {
	
	public static let shared = WeexCacheManager()
	
	private var persistence = WeexCachePersistence(config: CacheManagerConfig())
	
	private var service = WeexCacheService()
	
	private var newManafestModelList: CacheModelList = [:]
	
	private var cacheModelList: CacheModelList = [:]

	private var manifestURL: String = ""

	override public init() {
		super.init()
		cacheModelList = loadLocalManifest() ?? [:]
	}
	
	private func loadLocalManifest() -> CacheModelList? {
		guard let data = persistence.read(fromKey: manifestCacheKey) else {
			return nil
		}
		return try? JSONDecoder().decode(CacheModelList.self, from: data)
	}
	
	private func loadLocalJsFile(bundle: String) -> String {
		let localFilePath = persistence.url(fromKey: bundle)
		do {
			let data = try Data.init(contentsOf: localFilePath)
			return String(data: data, encoding: .utf8) ?? ""
		} catch let error {
			WXCDprint("error when load Local Js File, error: \(error)")
		}
		return ""
	}
	
	public func getBundleInfo(_ bundle: String) -> WeexBundleInfo? {
		let localManifest = cacheModelList[bundle]
		let newManifest = newManafestModelList[bundle]
		if localManifest == nil && newManifest == nil {
			return nil
		} else if localManifest == nil && newManifest != nil {
			return WeexBundleInfo(bundleUrl: newManifest!.path, localFile: "", isLocalFile: false)
		} else if localManifest != nil && newManifest == nil {
			let localFile = loadLocalJsFile(bundle: bundle)
			return WeexBundleInfo(bundleUrl: localManifest!.path, localFile: localFile, isLocalFile: true)
		} else {
			let cacheIsNew = localManifest!.md5 == newManifest!.md5
			let localFile = cacheIsNew ? loadLocalJsFile(bundle: bundle) : ""
			let isLocalFile = cacheIsNew
			return WeexBundleInfo(bundleUrl: newManifest!.path.appending("?md5=\(newManifest!.md5)"), localFile: localFile, isLocalFile: isLocalFile)
		}
	}
	
	public func isBundleNeededUpdateCache(_ bundle: String) -> Bool {
		guard let localManifest = cacheModelList[bundle] else { return true }
		guard let newManifest = newManafestModelList[bundle] else { return false }
		return localManifest.md5 != newManifest.md5
	}
	
	public func updateCache(data: Data?, bundle: String) {
		guard let data = data else { return }
		guard !bundle.isEmpty else { return }
		guard isBundleNeededUpdateCache(bundle) else { return }
		persistence.set(data: data, With: bundle)
		if let manifest = newManafestModelList[bundle] {
			cacheModelList[bundle] = manifest
			persistence.set(model: cacheModelList, with: manifestCacheKey)
		}
	}
	
	public func fetchNewManifest(_ url: String?) {
		manifestURL = url ?? ""
		service.syscWeexManifest(urlString: manifestURL, complitionHandler: { [weak self] (cacheModelList, data) in
			WXCDprint(" syscWeexManifest success: cacheModelList:\(cacheModelList)\n data:\(data)")
			guard let `self` = self else { return }
			self.newManafestModelList = cacheModelList
		})
	}
}
