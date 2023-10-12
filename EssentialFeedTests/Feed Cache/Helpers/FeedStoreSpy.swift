//
//  FeedStoreSpy.swift
//  EssentialFeedTests
//
//  Created by Jose Herrero on 2023-10-12.
//

import Foundation
import EssentialFeed

 class FeedStoreSpy: FeedStore {
    
    enum ReceivedMessage: Equatable {
        case deleteCacheFeed
        case insert([LocalFeedImage], Date)
    }
    
    private(set) var receivedMessages = [ReceivedMessage]()
    
    private var deletionCompletions = [DeletionCompletion]()
    private var insertionCompletions = [InsertionCompletion]()
    
    func deleteCachedFeed(completion: @escaping DeletionCompletion) {
        deletionCompletions.append(completion)
        receivedMessages.append(.deleteCacheFeed)
    }
    
    func completeDeletion(with error: Error, at index: Int = 0) {
        deletionCompletions[index](error)
    }
    
    func completeDeletionSuccesfully(at index: Int = 0) {
       deletionCompletions[index](nil)
    }
    
    func insert(_ feed: [LocalFeedImage], timeStamp: Date, completion: @escaping InsertionCompletion) {
        insertionCompletions.append(completion)
        receivedMessages.append(.insert(feed, timeStamp))
    }
    
    func completeInsertion(with error: Error, at index: Int = 0) {
        insertionCompletions[index](error)
    }
    
    func completeInsertionSuccesfully(at index: Int = 0) {
        insertionCompletions[index](nil)
    }
}
