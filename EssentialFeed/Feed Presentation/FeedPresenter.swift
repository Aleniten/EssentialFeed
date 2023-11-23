//
//  FeedPresenter.swift
//  EssentialFeed
//
//  Created by Jose Herrero on 2023-10-25.
//

import Foundation

public final class FeedPresenter {
    public static var title: String {
        Localized.Feed.title
    }
    
    public static func map(_ feed: [FeedImage]) -> FeedViewModel{
        FeedViewModel(feed: feed)
    }
}
