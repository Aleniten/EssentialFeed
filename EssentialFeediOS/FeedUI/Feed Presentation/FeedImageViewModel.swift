//
//  FeedImageViewModel.swift
//  EssentialFeediOS
//
//  Created by Jose Herrero on 2023-10-23.
//

import Foundation
import EssentialFeed

struct FeedImageViewModel<Image> {
    let description: String?
    let location: String?
    let image: Image?
    let isLoading: Bool
    let shouldRetry: Bool
    
    var hasLocation: Bool {
        return location != nil
    }
}
