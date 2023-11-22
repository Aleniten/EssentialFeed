//
//  FeedErrorViewModel.swift
//  EssentialFeed
//
//  Created by Jose Herrero on 2023-10-25.
//

public struct ResourceErrorViewModel {
    public var errorMessage: String?
    
    static var noError: ResourceErrorViewModel {
        return ResourceErrorViewModel(errorMessage: nil)
    }
    static func error(message: String) -> ResourceErrorViewModel {
        return ResourceErrorViewModel(errorMessage: message)
    }
}
