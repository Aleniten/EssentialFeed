//
//  FeedImageViewModel.swift
//  EssentialFeed
//
//  Created by Jose Herrero on 2023-10-26.
//

public struct FeedImageViewModel {
    public let description: String?
    public let location: String?
    
    public var hasLocation: Bool {
        return location != nil
    }
}
