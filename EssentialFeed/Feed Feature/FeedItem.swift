//
//  FeedItem.swift
//  EssentialFeed
//
//  Created by Jose Herrero on 2023-10-04.
//

import Foundation

public struct FeedItem: Equatable {
    let id: UUID
    let description: String?
    let location: String?
    let imageURL: URL
}
