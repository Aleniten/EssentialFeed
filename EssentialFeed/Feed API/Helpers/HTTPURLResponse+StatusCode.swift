//
//  HTTPURLResponse+StatusCode.swift
//  EssentialFeed
//
//  Created by Jose Herrero on 2023-10-26.
//

import Foundation

extension HTTPURLResponse {
    private static var OK_200: Int { return 200 }

    var isOK: Bool {
        return statusCode == HTTPURLResponse.OK_200
    }
}
