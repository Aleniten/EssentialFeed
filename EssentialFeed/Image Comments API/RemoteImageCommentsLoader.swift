//
//  RemoteImageCommentsLoader.swift
//  EssentialFeed
//
//  Created by Jose Herrero on 2023-11-02.
//

import Foundation

public typealias RemoteImageCommentsLoader = RemoteLoader<[ImageComment]>

public extension RemoteImageCommentsLoader {
    convenience init(url: URL, client: HTTPClient) {
        self.init(url: url, client: client, mapper: ImageCommentsMapper.map)
    }
}
