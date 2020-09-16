//
//  SearchResultTableViewReator.swift
//  KakaoMinsoo
//
//  Created by ZES2017MBP on 2020/09/17.
//  Copyright © 2020 Minsoo. All rights reserved.
//

import Foundation
import ReactorKit

final class SearchResultTableCellReator: Reactor {
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
        var ratingString: String
        var recommendsNumber: Int
        var thumbnailImages: [UIImage]
    }
    
    var initialState: State
    let searchResult: SearchResult
    
    init(searchResult: SearchResult) {
        self.searchResult = searchResult
        
        initialState = State(appIconImage: nil,
                             appNameString: searchResult.trackName, subtitleString: searchResult.resultDescription, ratingString: searchResult.trackContentRating, recommendsNumber: 1, thumbnailImages: [])
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        return .empty()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        return state
    }
    
}
