//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Jose Herrero on 2023-10-04.
//

import Foundation

public enum LoadFeedResult {
    case success([FeedItem])
    case failure(Error)
}

public protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
