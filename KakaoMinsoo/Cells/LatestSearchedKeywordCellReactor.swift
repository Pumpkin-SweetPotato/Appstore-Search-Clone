//
//  LatestSearchedKeywordCellReactor.swift
//  KakaoMinsoo
//
//  Created by eazel7 on 2020/09/21.
//  Copyright © 2020 Minsoo. All rights reserved.
//

import UIKit
import ReactorKit

final class LatestSearchedKeywordCellReactor: Reactor {
    enum Action {}
    
    enum Mutation {}
    
    struct State {
        var attributedSearchKeyword: NSMutableAttributedString?
        var searchKeyword: String?
        var isHiddenGlassIcon: Bool = false
        var labelColor: UIColor = UIColor.systemBlue
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
                attributedSearchKeyword: keyword.highlightKeyword(keyword: latestSearchedKeyword, font: UIFont.systemFont(ofSize: 19, weight: .medium), color: UIColor.black),
                searchKeyword: nil,
                isHiddenGlassIcon: false,
                labelColor: UIColor.lightGray
            )
        }
        
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
    }
}

