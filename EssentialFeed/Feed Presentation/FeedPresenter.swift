//
//  FeedPresenter.swift
//  EssentialFeed
//
//  Created by Jose Herrero on 2023-10-25.
//

import Foundation

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