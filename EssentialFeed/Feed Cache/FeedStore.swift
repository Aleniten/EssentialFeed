//
//  FeedStore.swift
//  EssentialFeed
//
//  Created by Jose Herrero on 2023-10-12.
//

import Foundation

public typealias CachedFeed = (feed: [LocalFeedImage], timestamp: Date)

public protocol FeedStore {
    typealias DeletionResult = Result<Void, Error>
    typealias DeletionCompletion = (DeletionResult) -> Void
    
    typealias InsertionResult = Result<Void, Error>
    typealias InsertionCompletion = (InsertionResult) -> Void
    
    typealias RetrievalResult = Result<CachedFeed?, Error>
    typealias RetrievalCompletion = (RetrievalResult) -> Void
  
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
