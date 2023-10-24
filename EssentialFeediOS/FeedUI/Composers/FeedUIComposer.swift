//
//  FeedUIComposer.swift
//  EssentialFeediOS
//
//  Created by Jose Herrero on 2023-10-23.
//

import Foundation
import UIKit
import EssentialFeed

public final class FeedUIComposer {
    private init() { }
    
    public static func feedComposedWith(feedLoader: FeedLoader, imageLoader: FeedImageDataLoader) -> FeedViewController  {
        let presenter = FeedPresenter(feedLoader: feedLoader)
        let refreshController = FeedRefreshViewController(presenter: presenter)
        let feedController = FeedViewController(refreshController: refreshController)
        presenter.loadingView = refreshController
        presenter.feedView = FeedViewAdapter(controller: feedController, loader: imageLoader)
        return feedController
    }
}

private final class FeedViewAdapter: FeedView {
    private weak var controller: FeedViewController?
    private let loader: FeedImageDataLoader

    init(controller: FeedViewController? = nil, loader: FeedImageDataLoader) {
        self.controller = controller
        self.loader = loader
    }
    
    func display(feed: [EssentialFeed.FeedImage]) {
        controller?.tableModel = feed.map { model in
            FeedImageCellController(viewModel: FeedImageViewModel(model: model, imageLoader: loader, imageTransformer: UIImage.init))
        }
    }
}
