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

public final class FeedPresenter {
    private let feedView: FeedView
    private let loadingView: ResourceLoadingView
    private let errorView: ResourceErrorView
    
    public static var title: String {
        Localized.Feed.title
    }
    
    private var feedLoadError: String {
        Localized.Shared.loadError
    }
    
   public init(feedView: FeedView, loadingView: ResourceLoadingView, errorView: ResourceErrorView) {
        self.feedView = feedView
        self.loadingView = loadingView
        self.errorView = errorView
    }
    
    public func didStartLoadingFeed() {
        errorView.display(.noError)
        loadingView.display(ResourceLoadingViewModel(isLoading: true))
    }
    
    public func didFinishLoadingFeed(with feed: [FeedImage]) {
        feedView.display(FeedViewModel(feed: feed))
        loadingView.display(ResourceLoadingViewModel(isLoading: false))
    }
    
    public func didFinishLoadingFeed(with error: Error) {
        errorView.display(ResourceErrorViewModel(errorMessage: feedLoadError))
        loadingView.display(ResourceLoadingViewModel(isLoading: false))
    }
}
