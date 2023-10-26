//
//  FeedErrorViewModel.swift
//  EssentialFeed
//
//  Created by Jose Herrero on 2023-10-25.
//

public struct FeedErrorViewModel {
    public var errorMessage: String?
    
    static var noError: FeedErrorViewModel {
        return FeedErrorViewModel(errorMessage: nil)
    }
    static func error(message: String) -> FeedErrorViewModel {
        return FeedErrorViewModel(errorMessage: message)
    }
}
