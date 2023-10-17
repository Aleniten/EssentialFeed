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
  
    /// The Completion  handler  can be invoked in  any thread.
    /// Clients are responsible to dispatch to  appropiate threads,  if  needed.
    func deleteCachedFeed(completion: @escaping DeletionCompletion)
    /// The Completion  handler  can be invoked in  any thread.
    /// Clients are responsible to dispatch to  appropiate threads,  if  needed.
    func insert(_ feed: [LocalFeedImage], timeStamp: Date, completion: @escaping InsertionCompletion)
    /// The Completion  handler  can be invoked in  any thread.
    /// Clients are responsible to dispatch to  appropiate threads,  if  needed.
    func retrieve(completion: @escaping RetrievalCompletion)
}
