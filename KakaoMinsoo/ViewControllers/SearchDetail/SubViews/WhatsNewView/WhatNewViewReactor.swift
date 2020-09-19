//
//  WhatNewViewReactor.swift
//  KakaoMinsoo
//
//  Created by ZES2017MBP on 2020/09/20.
//  Copyright © 2020 Minsoo. All rights reserved.
//

import Foundation
import ReactorKit

final class WhatsNewViewReactor: Reactor {
    enum Action {
        case moreButtonTapped
    }
    
    enum Mutation {
        case setExpandWhatsNew(Bool)
    }
    
    var initialState: State
    
    struct State {
        var version: String
        var releasedDateString: String?
        var releaseNote: String?
        
        var isExpandWhatsNew: Bool = false
    }
    
    let searchResult: SearchResult
    
    init(searchResult: SearchResult) {
        self.searchResult = searchResult
        
        var releasedDateString: String?
        
        if let releaseDate = DateConverter.convertDate(searchResult.currentVersionReleaseDate) {
            let calendar = Calendar.current
            
            let components = calendar.dateComponents([.day], from: releaseDate, to: Date())
            releasedDateString = components.day != nil ? String(format: "%dd ago", components.day!) : ""
            
        }
        
        initialState = State(
            version: searchResult.version,
            releasedDateString: releasedDateString,
            releaseNote: searchResult.releaseNotes
        )
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .moreButtonTapped:
            return .just(.setExpandWhatsNew(true))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
            case .setExpandWhatsNew(let set):
                state.isExpandWhatsNew = set
        }
        
        return state
    }
}

