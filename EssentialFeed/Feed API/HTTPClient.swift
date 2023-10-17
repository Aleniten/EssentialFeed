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
    /// The Completion  handler  can be invoked in  any thread.
    /// Clients are responsible to dispatch to  appropiate threads,  if  needed.
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
