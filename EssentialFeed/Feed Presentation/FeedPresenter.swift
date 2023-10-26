//
//  FeedPresenter.swift
//  EssentialFeed
//
//  Created by Jose Herrero on 2023-10-25.
//

import Foundation

final class Localized {
    static var bundle: Bundle {
        Bundle(for: Localized.self)
    }
}

extension Localized {
    enum Feed {
        static var table: String { "Feed" }

        static var title: String {
            NSLocalizedString(
                "FEED_VIEW_TITLE",
                tableName: table,
                bundle: bundle,
                comment: "Title for the feed view")
        }
        
        static var loadError: String {
            NSLocalizedString(
                "FEED_VIEW_CONNECTION_ERROR",
                tableName: table,
                bundle: bundle,
                comment: "Error message displayed when we can't load the image feed from the server")
        }
    }
}

public struct FeedViewModel {
    public let feed: [FeedImage]
}

public struct FeedLoadingViewModel {
    public let isLoading: Bool
}

public struct FeedErrorViewModel {
    public var errorMessage: String?
    
    static var noError: FeedErrorViewModel {
        return FeedErrorViewModel(errorMessage: nil)
    }
    static func error(message: String) -> FeedErrorViewModel {
        return FeedErrorViewModel(errorMessage: message)
    }
}
public protocol FeedView {
    func display(_ viewModel: FeedViewModel)
}

public protocol FeedLoadingView {
    func display(_ viewModel: FeedLoadingViewModel)
}

public protocol FeedErrorView {
    func display(_ viewModel: FeedErrorViewModel?)
}

public final class FeedPresenter {
    private let feedView: FeedView
    private let loadingView: FeedLoadingView
    private let errorView: FeedErrorView
    
    public static var title: String {
        Localized.Feed.title
    }
    
    private var feedLoadError: String {
        Localized.Feed.loadError
    }
    
   public init(feedView: FeedView, loadingView: FeedLoadingView, errorView: FeedErrorView) {
        self.feedView = feedView
        self.loadingView = loadingView
        self.errorView = errorView
    }
    
    public func didStartLoadingFeed() {
        errorView.display(.noError)
        loadingView.display(FeedLoadingViewModel(isLoading: true))
    }
    
    public func didFinishLoadingFeed(with feed: [FeedImage]) {
        feedView.display(FeedViewModel(feed: feed))
        loadingView.display(FeedLoadingViewModel(isLoading: false))
    }
    
    public func didFinishLoadingFeed(with error: Error) {
        errorView.display(FeedErrorViewModel(errorMessage: feedLoadError))
        loadingView.display(FeedLoadingViewModel(isLoading: false))
    }
}
