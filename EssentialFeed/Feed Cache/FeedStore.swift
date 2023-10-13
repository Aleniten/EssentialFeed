//
//  FeedStore.swift
//  EssentialFeed
//
//  Created by Jose Herrero on 2023-10-12.
//

import Foundation

public enum RetrieveCachedResult {
    case empty
    case found([LocalFeedImage], Date)
    case failure(Error)
}

public protocol FeedStore {
    typealias DeletionCompletion = (Error?) -> Void
    typealias InsertionCompletion = (Error?) -> Void
    typealias RetrievalCompletion = (RetrieveCachedResult) -> Void
  
    func deleteCachedFeed(completion: @escaping DeletionCompletion)
    func insert(_ feed: [LocalFeedImage], timeStamp: Date, completion: @escaping InsertionCompletion)
    func retrieve(completion: @escaping RetrievalCompletion)
}
