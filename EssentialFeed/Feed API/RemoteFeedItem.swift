//
//  RemoteFeedItem.swift
//  EssentialFeed
//
//  Created by Jose Herrero on 2023-10-12.
//

import Foundation

struct RemoteFeedItem: Decodable {
    internal let id: UUID
    internal let description: String?
    internal let location: String?
    internal let image: URL
}
