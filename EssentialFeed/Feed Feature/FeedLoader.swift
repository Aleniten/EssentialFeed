//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Jose Herrero on 2023-10-04.
//

import Foundation

enum LoadFeedResult {
    case success([FeedItem])
    case error(Error)
}

protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
