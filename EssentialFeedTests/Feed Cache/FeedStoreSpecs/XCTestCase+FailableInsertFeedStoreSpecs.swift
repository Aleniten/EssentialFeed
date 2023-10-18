//
//  XCTestCase+FailableInsertFeedStoreSpecs.swift
//  EssentialFeedTests
//
//  Created by Jose Herrero on 2023-10-17.
//

import XCTest
import EssentialFeed

extension FailableInsertFeedStoreSpecs where Self: XCTestCase {
    func assertThatInsertDeliversErrorOnInsertionError(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
        let insertionError = insert(uniqueImageFeed().local, timestamp: Date(), to: sut)

        XCTAssertNotNil(insertionError, "Expected cache insertion to fail with an error", file: file, line: line)
    }

    func assertThatInsertHasNoSideEffectsOnInsertionError(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
        insert(uniqueImageFeed().local, timestamp: Date(), to: sut)

        expect(sut, toRetrieve: .success(.none), file: file, line: line)
    }
}
