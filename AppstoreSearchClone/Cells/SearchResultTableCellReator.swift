//
//  SearchResultTableViewReator.swift
//  KakaoMinsoo
//
//  Created by ZES2017MBP on 2020/09/17.
//  Copyright © 2020 Minsoo. All rights reserved.
//

import UIKit
import ReactorKit

final class SearchResultTableCellReator: Reactor {
    enum Action {
        case prepareViewStates
    }
    
    enum Mutation {
        case setIconImage(UIImage?)
        case setLeftThumbnailImage(UIImage?)
        case setMiddleThumbnailImage(UIImage?)
        case setRightThumbnailImage(UIImage?)
    }
    
    struct State {
        var appIconImage: UIImage?
        var appNameString: String
        var subtitleString: String
        var ratingFloat: Float
        var ratingCountString: String
        var leftThumbnailImage: UIImage?
        var middleThumbnailImage: UIImage?
        var rightThumbnailImage: UIImage?
        
        var thumbnailImageCount: Int
    }
    
    var initialState: State
    let searchResult: SearchResult
    let imageDownloadManager = ImageDownloadManager.shared
    
    init(searchResult: SearchResult) {
        self.searchResult = searchResult
        
        let userRatingString: String = searchResult.formattedRatingCount
        
        initialState = State(appIconImage: nil,
                             appNameString: searchResult.trackName,
                             subtitleString: searchResult.primaryGenreName,
                             ratingFloat: searchResult.averageUserRating,
                             ratingCountString: userRatingString,
                             leftThumbnailImage: nil,
                             middleThumbnailImage: nil,
                             rightThumbnailImage: nil,
                             thumbnailImageCount: searchResult.screenshotUrls.count)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .prepareViewStates:
            let setIconImage =
                imageDownloadManager.downloadImage(searchResult.artworkUrl100, indexPath: nil)
                    .map { $0.0 }
                    .flatMap { Observable<Mutation>.just(.setIconImage($0)) }
            
            let setThumbnailImages: [Observable<Mutation>] = {
                var _setThumbnailImages: [Observable<Mutation>] = []
                let urls = self.searchResult.screenshotUrls.prefix(3)
                
                for index in 0 ..< urls.count {
                    _setThumbnailImages.append(self.requestThumbnailImage(index: index, urlString: urls[index]))
                }
                
                return _setThumbnailImages
            }()
            
            return .concat([[setIconImage], setThumbnailImages].flatMap { $0 })
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setIconImage(let image):
            state.appIconImage = image
        case .setLeftThumbnailImage(let image):
            state.leftThumbnailImage = image
        case .setMiddleThumbnailImage(let image):
            state.middleThumbnailImage = image
        case .setRightThumbnailImage(let image):
            state.rightThumbnailImage = image
        }
        return state
    }
    
    func transform(action: Observable<Action>) -> Observable<Action> {
        return action.startWith(.prepareViewStates)
    }
    
    func requestThumbnailImage(index: Int, urlString: String) -> Observable<Mutation> {
        
        return imageDownloadManager.downloadImage(urlString, indexPath: nil)
                .map { $0.0 }
                .flatMap { image -> Observable<Mutation> in
                    switch index {
                    case 0:
                        return .just(.setLeftThumbnailImage(image))
                    case 1:
                        return .just(.setMiddleThumbnailImage(image))
                    case 2:
                        return .just(.setRightThumbnailImage(image))
                    default:
                        return .empty()
                    }
        }
    }
    
//    func requestThumbnailImage(index: Int, urlString: String) -> Observable<Mutation> {
//        var images = currentState.thumbnailImages
//
//        return imageDownloadManager.downloadImage(urlString, indexPath: nil)
//            .map { $0.0 }
//            .do(onNext: { images[index] = $0 })
//            .flatMap { _ in Observable<Mutation>.just(.setThumbnailImages(images)) }
//    }
}

