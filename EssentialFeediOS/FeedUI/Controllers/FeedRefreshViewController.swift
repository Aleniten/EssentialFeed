//
//  FeedRefreshViewController.swift
//  EssentialFeediOS
//
//  Created by Jose Herrero on 2023-10-23.
//

import UIKit

final class FeedRefreshViewController: NSObject, FeedLoadingView {
   
    
    private(set) lazy var view: UIRefreshControl = loadView()

    private let loadFeed: () -> Void

    init(loadFeed: @escaping () -> Void) {
        self.loadFeed = loadFeed
    }

    @objc func refresh() {
        loadFeed()
    }
    
    private func loadView() -> UIRefreshControl {
        let view = UIRefreshControl()
        view.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return view
    }
    
    func display(_ viewModel: FeedLoadingViewModel) {
        viewModel.isLoading ? view.beginRefreshing() : view.endRefreshing()
    }
}
