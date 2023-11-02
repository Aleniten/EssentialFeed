//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by Jose Herrero on 2023-10-06.
//

import Foundation

public protocol HTTPClientTask {
    func cancel()
}

public protocol HTTPClient {
    typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>
    /// The Completion  handler  can be invoked in  any thread.
    /// Clients are responsible to dispatch to  appropiate threads,  if  needed.
    @discardableResult
    func get(from url: URL, completion: @escaping (Result) -> Void) -> HTTPClientTask
}
