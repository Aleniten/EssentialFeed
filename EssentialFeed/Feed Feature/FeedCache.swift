//
//  FeedCache.swift
//  EssentialFeed
//
//  Created by Jose Herrero on 2023-10-27.
//

public protocol FeedCache {
    typealias SaveResult = Swift.Result<Void, Error>
    func save(_ feed: [FeedImage], completion: @escaping (SaveResult) -> Void)
}
