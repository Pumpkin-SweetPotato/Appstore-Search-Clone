//
//  LatestSearchedKeywordCellReactor.swift
//  KakaoMinsoo
//
//  Created by eazel7 on 2020/09/21.
//  Copyright © 2020 Minsoo. All rights reserved.
//

import Foundation
import ReactorKit

final class LatestSearchedKeywordCellReactor: Reactor {
    enum Action {}
    
    enum Mutation {}
    
    struct State {
        var attributedSearchKeyword: NSMutableAttributedString?
        var searchKeyword: String?
        var isHiddenGlassIcon: Bool = false
    }
    
    var initialState: State
    
    init(keyword: SearchKeyword) {
        switch keyword {
        case .normal(let keyword):
            initialState = State(
                attributedSearchKeyword: nil,
                searchKeyword: keyword,
                isHiddenGlassIcon: true
            )
        case .highlighted(let keyword, let latestSearchedKeyword):
            initialState = State(
                attributedSearchKeyword: latestSearchedKeyword.highlightKeyword(keyword: keyword, size: 13),
                searchKeyword: nil,
                isHiddenGlassIcon: false
            )
        }
        
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        return .empty()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        return state
    }
}

