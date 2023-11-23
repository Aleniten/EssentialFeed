//
//  FeedImagePresenter.swift
//  EssentialFeed
//
//  Created by Jose Herrero on 2023-10-26.
//

public final class FeedImagePresenter {
    
    public static func map(_ image: FeedImage) -> FeedImageViewModel {
        FeedImageViewModel(
            description: image.description,
            location: image.location
            )
    }
}
