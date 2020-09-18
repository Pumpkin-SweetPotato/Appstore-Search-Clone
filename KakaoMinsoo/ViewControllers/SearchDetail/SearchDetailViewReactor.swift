//
//  SearchDetailViewReactor.swift
//  KakaoMinsoo
//
//  Created by ZES2017MBP on 2020/09/17.
//  Copyright © 2020 Minsoo. All rights reserved.
//

import Foundation
import ReactorKit

final class SearchDetailViewReactor: Reactor {
    enum Action {
        case prepareViewStates
    }
    
    enum Mutation {
        case setIconImage(UIImage?)
        case setThumbnailImages([UIImage])
    }
    
    struct State {
        var appIconImage: UIImage?
        var appNameString: String
        var subtitleString: String
        var ratingFloat: Float
        var ratingCountString: String
        var thumbnailImages: [UIImage]
    }
    
    var initialState: State
    let searchResult: SearchResult
    
    init(searchResult: SearchResult) {
        self.searchResult = searchResult
        
        let userRatingString: String = {
            let floatRating: Float = Float(searchResult.userRatingCount)
            if floatRating / 1000 > 0 {
                return String(format: "%.1Kf", floatRating / 1000)
            } else {
                return String(searchResult.userRatingCount)
            }
        }()
        
        let userRatingFloat: Float = {
            
            let ratingString = searchResult.contentAdvisoryRating
            
            let lowerBound = ratingString.index(ratingString.startIndex, offsetBy: 0)
            let upperBound = ratingString.index(ratingString.startIndex, offsetBy: 1)
            let rating = String(ratingString[lowerBound..<upperBound])
            let userRatingFloat: Float = Float(rating) ?? 0
            
            
            return userRatingFloat
        }()
        
        initialState = State(appIconImage: nil,
                             appNameString: searchResult.trackName,
                             subtitleString: searchResult.primaryGenreName,
                             ratingFloat: userRatingFloat,
                             ratingCountString: userRatingString,
                             thumbnailImages: [])
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .prepareViewStates:
            return .empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        return state
    }
    
    func transform(action: Observable<Action>) -> Observable<Action> {
        return action.startWith(.prepareViewStates)
    }
}

