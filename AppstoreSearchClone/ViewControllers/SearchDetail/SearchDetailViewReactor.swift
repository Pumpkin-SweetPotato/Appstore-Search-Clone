//
//  SearchDetailViewReactor.swift
//  KakaoMinsoo
//
//  Created by ZES2017MBP on 2020/09/17.
//  Copyright © 2020 Minsoo. All rights reserved.
//

import UIKit
import ReactorKit

final class SearchDetailViewReactor: Reactor {
    enum Action {
        case prepareViewStates
    }
    
    enum Mutation {
        case setIconImage(UIImage?)
    }
    
    struct State {
        var iconImage: UIImage?
    }
    
    var initialState: State
    let searchResult: SearchResult
    
    init(searchResult: SearchResult) {
        self.searchResult = searchResult
        
        initialState = State()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .prepareViewStates:
            return ImageDownloadManager.shared.downloadImage(searchResult.artworkUrl100, indexPath: nil)
                .flatMap { Observable<Mutation>.just(.setIconImage($0.0)) }
            
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setIconImage(let image):
            state.iconImage = image
        }
        return state
    }
    
    func transform(action: Observable<Action>) -> Observable<Action> {
        return action.startWith(.prepareViewStates)
    }
}

