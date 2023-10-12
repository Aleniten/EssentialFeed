//
//  FeedStore.swift
//  EssentialFeed
//
//  Created by Jose Herrero on 2023-10-12.
//

import Foundation

public protocol FeedStore {
    typealias DeletionCompletion = (Error?) -> Void
    typealias InsertionCompletion = (Error?) -> Void
  
    func deleteCachedFeed(completion: @escaping DeletionCompletion)
    func insert(_ items: [FeedItem], timeStamp: Date, completion: @escaping InsertionCompletion)
}
