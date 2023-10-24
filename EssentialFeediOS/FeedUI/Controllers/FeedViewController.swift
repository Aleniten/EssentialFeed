//
//  FeedViewController.swift
//  EssentialFeediOS
//
//  Created by Jose Herrero on 2023-10-19.
//

import UIKit

final public class FeedViewController: UITableViewController, UITableViewDataSourcePrefetching {
    
    var refreshController: FeedRefreshViewController?
 
    var tableModel = [FeedImageCellController]() {
        didSet { tableView.reloadData() }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.prefetchDataSource = self
        refreshControl = refreshController?.view
        refreshController?.refresh()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refreshControl?.beginRefreshing()
    }

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return tableModel.count
        }

        public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return cellController(forRowAt: indexPath).view()
        }

        public override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            cancelCellControllerLoad(forRowAt: indexPath)
        }

        public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
            indexPaths.forEach { indexPath in
                cellController(forRowAt: indexPath).preload()
            }
        }

        public func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
            indexPaths.forEach(cancelCellControllerLoad)
        }

        private func cellController(forRowAt indexPath: IndexPath) -> FeedImageCellController {
            return tableModel[indexPath.row]
        }

        private func cancelCellControllerLoad(forRowAt indexPath: IndexPath) {
            cellController(forRowAt: indexPath).cancelLoad()
        }
}
