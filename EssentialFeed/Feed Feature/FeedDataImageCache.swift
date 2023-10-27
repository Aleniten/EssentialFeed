//
//  FeedDataImageCache.swift
//  EssentialFeed
//
//  Created by Jose Herrero on 2023-10-27.
//

import Foundation

public protocol FeedDataImageCache {
    typealias Result = Swift.Result<Void, Error>
    func save(_ data: Data, for url: URL, completion: @escaping (Result) -> Void)
}
