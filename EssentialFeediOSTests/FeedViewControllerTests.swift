//
//  FeedViewControllerTests.swift
//  EssentialFeediOSTests
//
//  Created by Jose Herrero on 2023-10-19.
//

import XCTest
import UIKit
import EssentialFeed

final class FeedViewController: UITableViewController {
    private var loader: FeedLoader?
    
    convenience init(loader: FeedLoader) {
        self.init()
        self.loader = loader
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(load), for: .valueChanged)
        load()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refreshControl?.beginRefreshing()
        
    }
    
    @objc func load() {
        loader?.load { [weak self] _ in
            self?.refreshControl?.endRefreshing()
        }
    }
}

final class FeedViewControllerTests: XCTestCase {
    
    func test_init_doesNotLoadFeed() {
        let (_ , loader) = makeSUT()
        XCTAssertEqual(loader.loadCallCount, 0)
    }
    
    func test_viewDidLoad_loadsFeed() {
        let (sut , loader) = makeSUT()
        sut.simulateAppearance()
        
        XCTAssertEqual(loader.loadCallCount, 1)
    }
    
    func test_pullToRefresh_loadsFeed() {
        let (sut , loader) = makeSUT()
        sut.simulateAppearance()
        
        sut.refreshControl?.simulatePullToRefresh()
        
        XCTAssertEqual(loader.loadCallCount, 2)
        
        sut.refreshControl?.simulatePullToRefresh()
        
        XCTAssertEqual(loader.loadCallCount, 3 )
    }
    
    func test_viewDidLoad_showLoadingIndicator() {
        let (sut , _) = makeSUT()
        sut.simulateAppearance()
        
        XCTAssertEqual(sut.refreshControl?.isRefreshing, true)
    }
    
    func test_viewDidLoad_hidesLoadingIndicatorOnLoaderCompletion() {
        let (sut , loader) = makeSUT()
        sut.simulateAppearance()
        loader.completeFeedLoading()
        
        XCTAssertEqual(sut.refreshControl?.isRefreshing, false)
    }

    func test_pullToRefresh_showLoadingIndicator() {
        let (sut , _) = makeSUT()
        sut.simulateAppearance()
        sut.refreshControl?.simulatePullToRefresh()
        
        
        XCTAssertEqual(sut.refreshControl?.isRefreshing, true)
    }
    
    func test_pullToRefresh_hidesLoadingIndicatorOnLoaderCompletion() {
        let (sut , loader) = makeSUT()
        sut.refreshControl?.simulatePullToRefresh()
        loader.completeFeedLoading()
        
        XCTAssertEqual(sut.refreshControl?.isRefreshing, false)
    }
    
    
    // MARK: Helpers
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: FeedViewController, loader: LoaderSpy) {
        let loader = LoaderSpy()
        let sut = FeedViewController(loader: loader)
        trackForMemoryLeaks(loader, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, loader)
    }
    
    class LoaderSpy: FeedLoader {
        
        private var completions = [(FeedLoader.Result) -> Void]()
        var loadCallCount: Int {
            return completions.count
        }
        
        func load(completion: @escaping (FeedLoader.Result) -> Void) {
            completions.append(completion)
        }
        
        func completeFeedLoading() {
            completions[0](.success([]))
        }
    }
}

private extension UIRefreshControl {
    func simulatePullToRefresh() {
        allTargets.forEach { target in
            actions(forTarget: target, forControlEvent: .valueChanged)?.forEach {
                (target as NSObject).perform(Selector($0))
            }
        }
    }
}

extension FeedViewController {
    func simulateAppearance() {
            if !isViewLoaded {
                loadViewIfNeeded()
                prepareForFirstAppearance()
            }
            beginAppearanceTransition(true, animated: false)
            endAppearanceTransition()
            }

            private func prepareForFirstAppearance() {
                setSmallFrameToPreventRenderingCells()
                replaceRefreshControlWithSpyForiOS17Support()
            }

            private func setSmallFrameToPreventRenderingCells() {
                tableView.frame = CGRect(x: 0, y: 0, width: 390, height: 1)
            }

            private func replaceRefreshControlWithSpyForiOS17Support() {
                let spyRefreshControl = UIRefreshControlSpy()

                refreshControl?.allTargets.forEach { target in
                    refreshControl?.actions(forTarget: target, forControlEvent: .valueChanged)?.forEach { action in
                        spyRefreshControl.addTarget(target, action: Selector(action), for: .valueChanged)
                    }
                }

                refreshControl = spyRefreshControl
            }

    private class UIRefreshControlSpy: UIRefreshControl {
        private var _isRefreshing = false
        
        override var isRefreshing: Bool { _isRefreshing }
        
        override func beginRefreshing() {
            _isRefreshing = true
        }
        
        override func endRefreshing() {
            _isRefreshing = false
        }
    }
    
    func simulateUserInitiatedReload() {
            refreshControl?.simulatePullToRefresh()
        }
}
