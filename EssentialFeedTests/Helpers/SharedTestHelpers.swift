//
//  SharedTestHelpers.swift
//  EssentialFeedTests
//
//  Created by Jose Herrero on 2023-10-13.
//

import Foundation

func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 1)
}

func anyURL() -> URL {
    return URL(string: "https://any-url.com")!
}