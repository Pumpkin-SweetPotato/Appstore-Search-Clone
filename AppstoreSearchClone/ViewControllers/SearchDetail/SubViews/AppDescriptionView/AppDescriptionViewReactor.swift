//
//  AppDescriptionViewReactor.swift
//  KakaoMinsoo
//
//  Created by ZES2017MBP on 2020/09/19.
//  Copyright © 2020 Minsoo. All rights reserved.
//

import UIKit
import ReactorKit

final class AppDescriptionViewReactor: Reactor {
    enum Action {
        case moreButtonTapped
        case developerButtonTappedd
    }
    
    enum Mutation {
        case setExpandDescriptonButton(Bool)
        case setDeveloperDetailViewController(UIViewController)
    }
    
    var initialState: State
    
    struct State {
        var descriptionText: String
        var sellarName: String
        var isExpandDescription: Bool = false
        var developerDetailViewController: UIViewController? = nil
    }
    
    let searchResult: SearchResult
    
    init(searchResult: SearchResult) {
        self.searchResult = searchResult
        initialState = .init(descriptionText: searchResult.resultDescription,
                             sellarName: searchResult.sellerName)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .developerButtonTappedd:
            return .empty()
        case .moreButtonTapped:
            return .concat(.just(.setExpandDescriptonButton(true)))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setExpandDescriptonButton(let set):
            state.isExpandDescription = set
        case .setDeveloperDetailViewController(let viewcontroller):
            state.developerDetailViewController = viewcontroller
        }
        
        return state
    }
}
