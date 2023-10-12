//
//  CacheFeedUseCaseTests.swift
//  EssentialFeedTests
//
//  Created by Jose Herrero on 2023-10-12.
//

import XCTest
import EssentialFeed

class LocalFeedLoader {
    private let store: FeedStore
    
    init(store: FeedStore) {
        self.store = store
    }
    
    func save(_ items: [FeedItem]) {
        store.deleteCachedFeed()
    }
}

class FeedStore {
    var deleteCachedFeedCallCount = 0
    
    func deleteCachedFeed() {
        deleteCachedFeedCallCount += 1
    }
}

final class CacheFeedUseCaseTests: XCTestCase {
    
    func test_init_doesNotDeleteCacheUponCreation() {
        let (_ , store) = makeSUT()
        
        XCTAssertEqual(store.deleteCachedFeedCallCount, 0)
    }
    
    func test_save_requestCacheDeletion() {
        let (sut , store) = makeSUT()
        let items = [uniqueItem(), uniqueItem()]
        
        sut.save(items)
        
        XCTAssertEqual(store.deleteCachedFeedCallCount, 1)
    }
    
    // Helpers
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: LocalFeedLoader, store: FeedStore) {
        let store = FeedStore()
        let sut = LocalFeedLoader(store: store)
        trackForMemoryLeaks(store, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return ( sut, store )
    }
    
    private func uniqueItem() -> FeedItem {
        return FeedItem(id: UUID(), description: "anyDescription", location: "anyLocation", imageURL: anyURL())
    }
    
    private func anyURL() -> URL {
        return URL(string: "https://any-url.com")!
    }
    
}
