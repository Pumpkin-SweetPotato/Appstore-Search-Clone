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

