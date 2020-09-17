//
//  SearchViewReactor.swift
//  KakaoMinsoo
//
//  Created by ZES2017MBP on 2020/09/17.
//  Copyright © 2020 Minsoo. All rights reserved.
//

import Foundation
import ReactorKit

final class SearchViewReactor: Reactor {
    enum SearchViewMode {
        case watingInput
        case inputContinuing
        case showingResult
    }
    enum Action {
        case searchBarSelected
        case searchBarTextDidChanged(String)
        case searchBegin
        case searchCancel
        case latestSearchKeywordSelected(String)
        case searchResultSelected(String)
    }
    
    enum Mutation {
        case setSearchKeyword(String)
        case setLatestSearchedKeywords([String])
        case setSearchResults([SearchResult])
        case setSelectedSearchKeyword(String?)
        case setSearchViewMode(SearchViewMode)
    }
    
    struct State {
        var searchKeyword: String
        var latestSearchedKeywords: [String]
        var searchResults: [SearchResult]
        var selectedSearchKeyword: String?
        var searchViewMode: SearchViewMode = .watingInput
    }
    
    var initialState: State
    let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
        initialState = State(searchKeyword: "", latestSearchedKeywords: [], searchResults: [])
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .searchBarSelected:
            return .empty()
            
        case .searchBarTextDidChanged(let keyword):
            if keyword.isEmpty {
                return .just(.setSearchViewMode(.watingInput))
            } else {
                return .just(.setSearchViewMode(.inputContinuing))
            }
        case .searchBegin:
            let currentKeyword = currentState.searchKeyword
            SearchUserDefaults.latestSearchKeywords.append(currentKeyword)
            
            let setLatestSearchKeyword = Observable<Mutation>.just(.setLatestSearchedKeywords(SearchUserDefaults.latestSearchKeywords))
            let parameter = makeParameter(with: currentKeyword)
            let requsetSearchResults = apiClient.reqeust(SearchResponse.self, .requestList(parameter))
                .map { $0.results }
                .flatMap { Observable<Mutation>.just(.setSearchResults($0)) }
                
            
            let setSearchViewMode = Observable<Mutation>.just(.setSearchViewMode(.showingResult))
                
            return .concat(setLatestSearchKeyword, requsetSearchResults, setSearchViewMode)
            
        case .searchCancel:
            let setSearchViewMode = Observable<Mutation>.just(.setSearchViewMode(.watingInput))
            return .concat(.just(.setSearchKeyword("")), setSearchViewMode)
            
        case .latestSearchKeywordSelected(let keyword):
            return .just(.setSelectedSearchKeyword(keyword))
            
        case .searchResultSelected(let result):
            return .just(.setSearchKeyword(result))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case .setSearchKeyword(let keyword):
            state.searchKeyword = keyword
        case .setLatestSearchedKeywords(let keywords):
            state.latestSearchedKeywords = keywords
        case .setSearchResults(let results):
            state.searchResults = results
        case .setSelectedSearchKeyword(let keyword):
            state.selectedSearchKeyword = keyword
        case .setSearchViewMode(let mode):
            state.searchViewMode = mode
        }
        
        return state
    }
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        return mutation
    }

    func makeParameter(with keyword: String) -> SearchRequestParameter {
        return SearchRequestParameter(term: keyword, attribute: nil)
    }
    
}
