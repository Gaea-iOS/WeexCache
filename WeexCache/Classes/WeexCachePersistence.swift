//
//  WeexCachePersistence.swift
//  WeexCache_Example
//
//  Created by 陈广川 on 2018/1/10.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit

public protocol CacheConfig {
	var cachePath: String { get }
}

public class WeexCachePersistence {

	private let fileManager = FileManager.default
	
	private let cacheconfig: CacheConfig

	public init(config: CacheConfig) {
		self.cacheconfig = config
		checkCachePath()
	}
	
	private func checkCachePath() {
		guard !fileManager.fileExists(atPath: cacheconfig.cachePath) else {
			return
		}
		do {
			try fileManager.createDirectory(atPath: cacheconfig.cachePath, withIntermediateDirectories: true, attributes: nil)
		} catch let error {
			WXCDprint("error when create directory path: \(cacheconfig.cachePath)\n error:\(error)")
		}
	}
	
	func url(fromKey key: String) -> URL {
		let path = NSString(string: cacheconfig.cachePath).appendingPathComponent(key)
		return URL.init(fileURLWithPath: path)
	}
	
	public func set(model: CacheModelList, with key: String) {
		let url = self.url(fromKey: key)
		do {
			let data = try JSONEncoder().encode(model)
			try data.write(to: url)
		} catch let error {
			print("error when set model:\(model)\n to path: \(url.absoluteString)\n error: \(error)")
		}
	}

	public func set(data: Data, With key: String) {
		let url = self.url(fromKey: key)
		do {
			try data.write(to: url)
		} catch let error {
			print("error when write data to path: \(url.absoluteString)\n error: \(error)")
		}
	}
	
	public func read(fromKey key: String) -> Data? {
		let url = self.url(fromKey: key)
		do {
			let data = try Data.init(contentsOf: url)
			return data
		} catch let error {
			print("error when read data from path: \(url.absoluteString)\n error: \(error)")
			return nil
		}
	}
	
	public func remove(withKey key: String) {
		let url = self.url(fromKey: key)
		do {
			try fileManager.removeItem(at: url)
		} catch let error {
			print("error when remove file from path: \(url.absoluteString)\n error: \(error)")
		}
	}
	
}
