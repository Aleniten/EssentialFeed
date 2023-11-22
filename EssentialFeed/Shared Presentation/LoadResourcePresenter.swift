//
//  LoadResourcePresenter.swift
//  EssentialFeed
//
//  Created by Jose Herrero on 2023-11-22.
//

import Foundation

public protocol ResourceView {
    associatedtype ResourceViewModel
    func display(_ viewModel: ResourceViewModel)
}

public final class LoadResourcePresenter<Resource, View: ResourceView> {
    public typealias Mapper = (Resource) -> View.ResourceViewModel
    private let resourceView: View
    private let loadingView: ResourceLoadingView
    private let errorView: FeedErrorView
    private let mapper: Mapper
    
    public static var loadError: String {
        Localized.Shared.loadError
    }
    
    public init(resourceView: View, loadingView: ResourceLoadingView, errorView: FeedErrorView, mapper: @escaping Mapper) {
        self.resourceView = resourceView
        self.loadingView = loadingView
        self.errorView = errorView
        self.mapper = mapper
    }
    
    public func didStartLoading() {
        errorView.display(.noError)
        loadingView.display(ResourceLoadingViewModel(isLoading: true))
    }
    
    public func didFinishLoading(with resource: Resource  ) {
        resourceView.display(mapper(resource))
        loadingView.display(ResourceLoadingViewModel(isLoading: false))
    }
    
    public func didFinishLoading(with error: Error) {
        errorView.display(FeedErrorViewModel(errorMessage: Self.loadError))
        loadingView.display(ResourceLoadingViewModel(isLoading: false))
    }
}
