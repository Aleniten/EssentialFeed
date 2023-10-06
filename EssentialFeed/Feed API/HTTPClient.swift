//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by Jose Herrero on 2023-10-06.
//

import Foundation

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
