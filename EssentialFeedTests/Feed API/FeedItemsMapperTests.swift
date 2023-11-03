//
//  RemoteFeedLoaderTest.swift
//  EssentialFeedTests
//
//  Created by Jose Herrero on 2023-10-04.
//

import XCTest
import EssentialFeed

final class FeedItemsMapperTests: XCTestCase {
    
    func test_map_throwsErrorOnNon200HTTPResponse() throws {
        let json = makeItemsJSON([])
        let samples = [199, 201, 300, 400, 500]
        
        try samples.forEach { code in
            XCTAssertThrowsError( try FeedItemsMapper.map(json, from: HTTPURLResponse(code)))
        }
    }
    
    func test_map_throwsErrorOn200HTTPResponseWithInvalidJson() throws {
        let invalidJson = Data("invalid jason".utf8)
        XCTAssertThrowsError(
            try FeedItemsMapper.map(invalidJson, from: HTTPURLResponse(200))
        )
    }
    
    func test_map_deliversNoItemsOn200HTTPResponseWithEmptyList() throws {
        let emptyListJSON = makeItemsJSON([])
        
        let result = try FeedItemsMapper.map(emptyListJSON, from: HTTPURLResponse(200))
       
        XCTAssertEqual(result, [])
    }
    
    func test_map_deliversItemsOn200HTTPResponseWithJSONItems() throws {
        
        let item1 = makeItem(
            id: UUID(),
            imageURL: URL(string: "http://a-url.com")!
        )
        
        let item2 = makeItem(
            id: UUID(),
            description: "a description",
            location: "a location",
            imageURL: URL(string: "http://another-url.com")!
        )
        
        let json = makeItemsJSON([item1.json, item2.json])
        let result = try FeedItemsMapper.map(json, from: HTTPURLResponse(200))
       
        XCTAssertEqual(result, [item1.model, item2.model])
    }
    
    // MARK: Helpers
    
    private func makeItem(id: UUID, description: String? = nil, location: String? = nil, imageURL: URL) -> (model: FeedImage, json: [String: Any]) {
        let item = FeedImage(id: id, description: description, location: location, url: imageURL)
        let json = [
            "id": id.uuidString,
            "description": description,
            "location": location,
            "image": imageURL.absoluteString
        ].compactMapValues { $0 }
        return (item, json)
    }
    
    private func makeItemsJSON(_ items: [[String: Any]]) -> Data {
        let json = ["items": items]
        return try! JSONSerialization.data(withJSONObject: json)
    }
}

private extension HTTPURLResponse {
    convenience init(_ statusCode: Int) {
        self.init(url: anyURL(), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
    }
}
