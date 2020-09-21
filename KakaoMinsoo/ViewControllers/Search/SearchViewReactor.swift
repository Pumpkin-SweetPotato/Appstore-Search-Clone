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
        case initial
        case searchBarFocused
        case inputContinuing
        case showingResult
    }
    
    enum Action {
        case searchBarSelected
        case searchBarTextDidChanged(String)
        case searchBegin
        case searchCancel
        case latestSearchKeywordSelected(IndexPath)
        case filteredLatestSearchKeywordSelected(IndexPath)
        case searchResultSelected(IndexPath)
        
        case loadMore
    }
    
    enum Mutation {
        case setSearchKeyword(String)
        case setLatestSearchedKeywords([String])
        
        case setSearchResults([SearchResult])
        case setSlicedSearchResults([SearchResult])
        case setSliceIndex(Int)
        
        case setFilteredSearchResults([String])
        case setSelectedSearchKeyword(String?)
        case setSearchViewMode(SearchViewMode)
        case setSearchDetailViewController(SearchDetailViewController?)
        case setIsHiddenSearchLabel(Bool)
        case setIsShowCancelButtonOnSearchBar(Bool)
        case setIsHiddenLatestSeachLabel(Bool)
        case setIsHiddenLatestSearchTableView(Bool)
        case setIsHiddenSearchResultTableView(Bool)
        
        case setNeedReload(Bool)
        case setAddedIndexPaths([IndexPath])
        case setIsNeedReloadFilteredKeywordTableView(Bool)
    }
    
    struct State {
        var searchKeyword: String
        var latestSearchedKeywords: [String]
        var filteredLatestSearchedKeywords: [String]
        
        var searchResults: [SearchResult]
        var slicedSearchResults: [SearchResult]
        var sliceIndex: Int = 1

        var selectedSearchKeyword: String?
        var searchViewMode: SearchViewMode = .initial
        var searchDetailViewController: SearchDetailViewController?
        
        var isHiddenSearchLabel: Bool = false
        var isShowCancelButtonOnSearchBar: Bool = true
        var isHiddenLatestSearchLabel: Bool = false
        var isHiddenLatestSearchTableView: Bool = false
        var isHiddenSearchResultTabbleView: Bool = true
        
        var addedIndexPaths: [IndexPath] = []
        var isNeedReload: Bool = false
        var isNeedReloadFilteredKeywordTableView: Bool = false
    }
    
    var initialState: State
    let apiClient: APIClient
    let sliceCount: Int = 20
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
        initialState = State(searchKeyword: "",
                             latestSearchedKeywords: SearchUserDefaults.latestSearchKeywords,
                             filteredLatestSearchedKeywords: [],
                             searchResults: [],
                             slicedSearchResults: [])
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .searchBarSelected:
            return .just(.setSearchViewMode(.searchBarFocused))
            
        case .searchBarTextDidChanged(let keyword):
            if keyword.isEmpty {
                return .concat([.just(.setSearchViewMode(.initial)), .just(.setSearchKeyword(keyword))])
            } else {
                var uniqueKeywords: Set<String> = Set<String>()
                SearchUserDefaults.latestSearchKeywords
                    .filter { $0.contains(keyword) }
                    .forEach { uniqueKeywords.insert($0) }
                
                let setNeedReloadFilteredTableView = Observable<Mutation>.concat(
                    .just(.setIsNeedReloadFilteredKeywordTableView(true)), .just(.setIsNeedReloadFilteredKeywordTableView(false))
                )
            
                return .concat([
                    .just(.setSearchViewMode(.inputContinuing)),
                    .just(.setSearchKeyword(keyword)),
                    .just(.setFilteredSearchResults(Array(uniqueKeywords).sorted(by: { $0.count > $1.count }))),
                    setNeedReloadFilteredTableView
                ])
            }
        case .searchBegin:
            let currentKeyword = currentState.searchKeyword
//            SearchUserDefaults.latestSearchKeywords.append(currentKeyword)
            addLatestSearchKeyword(currentKeyword)
            
            let setLatestSearchKeyword = Observable<Mutation>.just(.setLatestSearchedKeywords(SearchUserDefaults.latestSearchKeywords))
            
            let requsetSearchResults = makeRequest(keyword: currentKeyword)
                .map { $0.results }
                .flatMap { [unowned self] results -> Observable<Mutation> in
                    if results.count < self.sliceCount {
                        return Observable<Mutation>.concat([.just(.setSearchResults(results)),
                                                            .just(.setSlicedSearchResults(results))])
                    } else {
                        return Observable<Mutation>.concat([.just(.setSearchResults(results)),
                                                            .just(.setSlicedSearchResults(Array(results[0..<sliceCount])))])
                    }
                }
                
            let setSearchViewMode = Observable<Mutation>.just(.setSearchViewMode(.showingResult))
            
            let setNeedReload: Observable<Mutation> = .concat(.just(.setNeedReload(true)), .just(.setNeedReload(false)))
                
            let setSliceIndex: Observable<Mutation> = .just(.setSliceIndex(1))
            return .concat(setLatestSearchKeyword, requsetSearchResults, setSliceIndex, setSearchViewMode, setNeedReload)
            
        case .searchCancel:
            let setSearchViewMode = Observable<Mutation>.just(.setSearchViewMode(.initial))
            let setSearchResults = Observable<Mutation>.just(.setSearchResults([]))
            return .concat(.just(.setSearchKeyword("")), setSearchResults, setSearchViewMode)
            
        case .latestSearchKeywordSelected(let indexPath):
            let keyword = currentState.latestSearchedKeywords[indexPath.row]
//            SearchUserDefaults.latestSearchKeywords.append(keyword)
            addLatestSearchKeyword(keyword)
            
            let setLatestSearchKeyword = Observable<Mutation>.just(.setLatestSearchedKeywords(SearchUserDefaults.latestSearchKeywords))
            
            let setSelectedKeyword: Observable<Mutation> = .concat(.just(.setSelectedSearchKeyword(keyword)), .just(.setSelectedSearchKeyword(nil)))
            
            let setKeyword: Observable<Mutation> = .just(.setSearchKeyword(keyword))
            
            let requsetSearchResults = makeRequest(keyword: keyword)
                .map { $0.results }
                .flatMap { [unowned self] results -> Observable<Mutation> in
                    if results.count < self.sliceCount {
                        return Observable<Mutation>.concat([.just(.setSearchResults(results)),
                                                            .just(.setSlicedSearchResults(results))])
                    } else {
                        return Observable<Mutation>.concat([.just(.setSearchResults(results)),
                                                            .just(.setSlicedSearchResults(Array(results[0..<sliceCount])))])
                    }
                }
            
            let setViewMode: Observable<Mutation> = .just(.setSearchViewMode(.showingResult))
            
            let setNeedReload: Observable<Mutation> = .concat(.just(.setNeedReload(true)), .just(.setNeedReload(false)))
            
            let setSliceIndex: Observable<Mutation> = .just(.setSliceIndex(1))
            
            return .concat([setLatestSearchKeyword, setKeyword, setSelectedKeyword, requsetSearchResults, setSliceIndex, setViewMode, setNeedReload])
        case .filteredLatestSearchKeywordSelected(let indexPath):
            let keyword = currentState.filteredLatestSearchedKeywords[indexPath.row]
//            SearchUserDefaults.latestSearchKeywords.append(keyword)
            addLatestSearchKeyword(keyword)
            
            let setLatestSearchKeyword = Observable<Mutation>.just(.setLatestSearchedKeywords(SearchUserDefaults.latestSearchKeywords))
            
            let setSelectedKeyword: Observable<Mutation> = .concat(.just(.setSelectedSearchKeyword(keyword)), .just(.setSelectedSearchKeyword(nil)))
            
            let setKeyword: Observable<Mutation> = .just(.setSearchKeyword(keyword))
            
            let requsetSearchResults = makeRequest(keyword: keyword)
                .map { $0.results }
                .flatMap { [unowned self] results -> Observable<Mutation> in
                    if results.count < self.sliceCount {
                        return Observable<Mutation>.concat([.just(.setSearchResults(results)),
                                                            .just(.setSlicedSearchResults(results))])
                    } else {
                        return Observable<Mutation>.concat([.just(.setSearchResults(results)),
                                                            .just(.setSlicedSearchResults(Array(results[0..<sliceCount])))])
                    }
                }
            
            let setViewMode: Observable<Mutation> = .just(.setSearchViewMode(.showingResult))
            
            let setNeedReload: Observable<Mutation> = .concat(.just(.setNeedReload(true)), .just(.setNeedReload(false)))
            
            let setSliceIndex: Observable<Mutation> = .just(.setSliceIndex(1))
            
            return .concat([setLatestSearchKeyword, setKeyword, setSelectedKeyword, setSliceIndex, requsetSearchResults, setViewMode, setNeedReload])
        case .searchResultSelected(let indexPath):
            guard currentState.searchResults.count > indexPath.row else { return .empty() }
            let result = currentState.searchResults[indexPath.row]
            
            let storyboard = UIStoryboard(name: "SearchDetailViewController", bundle: nil)
            
            guard let viewController = storyboard.instantiateViewController(withIdentifier: "SearchDetailViewController") as? SearchDetailViewController else { return .empty() }
            
            viewController.reactor = SearchDetailViewReactor(searchResult: result)
            
            let setViewController: Observable<Mutation> = .just(.setSearchDetailViewController(viewController))
            
            let unsetViewController: Observable<Mutation> =
                .just(.setSearchDetailViewController(nil))
            return .concat(setViewController, unsetViewController)
        case .loadMore:
            guard currentState.sliceIndex * sliceCount < currentState.searchResults.count else { return .empty() }
            
            let _sliceIndex = currentState.sliceIndex + 1
            let _sliceCount: Int = _sliceIndex * sliceCount
            let originalSearchResults = currentState.searchResults
            
            var slicedSearchResult: [SearchResult] = []
            if _sliceCount > currentState.searchResults.count {
                slicedSearchResult = originalSearchResults
            } else {
                slicedSearchResult = Array(originalSearchResults[0..<_sliceCount])
            }
            
            var addedIndexPath: [IndexPath] = []
            
            for row in currentState.slicedSearchResults.count ..< slicedSearchResult.count {
                addedIndexPath.append(IndexPath(row: row, section: 0))
            }
            
            let setAddedIndexPath = Observable<Mutation>.concat(.just(.setAddedIndexPaths(addedIndexPath)), .just(.setAddedIndexPaths([])))
            
            return .concat([.just(.setSliceIndex(_sliceIndex)),
                            .just(.setSlicedSearchResults(slicedSearchResult)),
                            setAddedIndexPath])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case .setSearchKeyword(let keyword):
            state.searchKeyword = keyword
        case .setLatestSearchedKeywords(let keywords):
            state.latestSearchedKeywords = keywords
        case .setFilteredSearchResults(let keywords):
            state.filteredLatestSearchedKeywords = keywords
        case .setSearchResults(let results):
            state.searchResults = results
        case .setSliceIndex(let index):
            state.sliceIndex = index
        case .setSlicedSearchResults(let results):
            state.slicedSearchResults = results
        case .setSelectedSearchKeyword(let keyword):
            state.selectedSearchKeyword = keyword
        case .setSearchViewMode(let mode):
            state.searchViewMode = mode
        case .setSearchDetailViewController(let viewController):
            state.searchDetailViewController = viewController
        case .setIsHiddenSearchLabel(let set):
            state.isHiddenSearchLabel = set
        case .setIsShowCancelButtonOnSearchBar(let set):
            state.isShowCancelButtonOnSearchBar = set
        case .setIsHiddenLatestSeachLabel(let set):
            state.isHiddenLatestSearchLabel = set
        case .setIsHiddenLatestSearchTableView(let set):
            state.isHiddenLatestSearchTableView = set
        case .setIsHiddenSearchResultTableView(let set):
            state.isHiddenSearchResultTabbleView = set
        case .setNeedReload(let set):
            state.isNeedReload = set
        case .setAddedIndexPaths(let indexPaths):
            state.addedIndexPaths = indexPaths
        case .setIsNeedReloadFilteredKeywordTableView(let set):
            state.isNeedReloadFilteredKeywordTableView = set
        }
        
        return state
    }
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        return mutation
    }

    func makeParameter(with keyword: String) -> SearchRequestParameter {
        return SearchRequestParameter(
            term: keyword,
            attribute: nil,
            limit: 100
        )
    }
    
    
    func makeRequest(keyword: String) -> Observable<SearchResponse> {
        let parameter = makeParameter(with: keyword)
        let requsetSearchResults = apiClient.reqeust(SearchResponse.self, .requestList(parameter))
        
        return requsetSearchResults
    }
    
    func setViewsHidden(mode: SearchViewMode) -> Observable<Mutation> {
        var mutations: [Observable<Mutation>] = []
        
//        switch mode {
//        case .watingInput:
//            mutations.append(.just(.setIsHiddenSearchLabel(false)))
//            mutations.append(.just(.setIsHiddenLatestSeachLabel(false)))
//            mutations.append(.just(.setIsHiddenLatestSearchTableView(false)))
//            mutations.append(.just(.setIsHiddenSearchResultTableView(true)))
//            mutations.append(.just(.setIsShowCancelButtonOnSearchBar(false)))
//        case .beginEditing:
////            let statusbarHeight = SearchConstants.statusBarHeight(rootView: self.rootView) ?? 0
////            self.stackView.snp.updateConstraints { make in
////                make.top.equalToSuperview().offset(statusbarHeight)
////            }
//            mutations.append(.just(.setIsHiddenSearchLabel(true)))
//            mutations.append(.just(.setIsShowCancelButtonOnSearchBar(true)))
//        case .inputContinuing:
////            let statusbarHeight = SearchConstants.statusBarHeight(rootView: self.rootView) ?? 0
////            self.stackView.snp.updateConstraints { make in
////                make.top.equalToSuperview().offset(statusbarHeight)
////            }
//
//            mutations.append(.just(.setIsHiddenSearchLabel(true)))
//            mutations.append(.just(.setIsHiddenLatestSeachLabel(true)))
//            mutations.append(.just(.setIsShowCancelButtonOnSearchBar(true)))
//        case .showingResult:
////            self.stackView.setCustomSpacing(0, after: self.searchBar)
//            mutations.append(.just(.setIsHiddenSearchLabel(true)))
//            mutations.append(.just(.setIsHiddenLatestSeachLabel(true)))
//            mutations.append(.just(.setIsHiddenLatestSearchTableView(true)))
//            mutations.append(.just(.setIsHiddenSearchResultTableView(false)))
//            mutations.append(.just(.setIsShowCancelButtonOnSearchBar(true)))
//        }
//
        return .concat(mutations)
    }
    
    func addLatestSearchKeyword(_ keyword: String) {
        while SearchUserDefaults.latestSearchKeywords.count > 20 {
            SearchUserDefaults.latestSearchKeywords.removeLast()
        }
        
        SearchUserDefaults.latestSearchKeywords.insert(keyword, at: 0)
    }
}
