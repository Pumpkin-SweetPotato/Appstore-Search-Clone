//
//  SearchViewController+UITableViewDelegate.swift
//  KakaoMinsoo
//
//  Created by ZES2017MBP on 2020/09/17.
//  Copyright © 2020 Minsoo. All rights reserved.
//

import UIKit

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case latestSearchTableView, filteredLatestSearchTableView:
            return 30
        case searchResultTableView:
            return 300
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case latestSearchTableView, filteredLatestSearchTableView:
            return 35
        case searchResultTableView:
            return DeviceType.iPhoneX || DeviceType.iPhoneXRMax ? 340 : 315
        default:
            return 0
        }
    }
}


extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case latestSearchTableView:
            return reactor?.currentState.latestSearchedKeywords.count ?? 0
        case filteredLatestSearchTableView:
            return reactor?.currentState.filteredLatestSearchedKeywords.count ?? 0
        case searchResultTableView:
            return reactor?.currentState.slicedSearchResults.count ?? 0
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
//        switch tableView {
            return 1
//        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case latestSearchTableView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LatestSearchedKeywordCell.reuseIdentifier, for: indexPath) as? LatestSearchedKeywordCell else { fatalError("couldnt instantiate latest search keyword table view cell") }
            
            guard let keyword = reactor?.currentState.latestSearchedKeywords[indexPath.row] else { fatalError("Coudlnt reireve latest search keyword")}
            
            cell.reactor = LatestSearchedKeywordCellReactor(keyword: .normal(keyword))
            
            return cell
        case filteredLatestSearchTableView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LatestSearchedKeywordCell.reuseIdentifier, for: indexPath) as? LatestSearchedKeywordCell else { fatalError("couldnt instantiate latest search keyword table view cell") }
            
            guard let latestKeyword = reactor?.currentState.filteredLatestSearchedKeywords[indexPath.row],
                  let currentKeyword = reactor?.currentState.searchKeyword else { fatalError("Coudlnt reireve latest search keyword")}
            
            cell.reactor = LatestSearchedKeywordCellReactor(keyword: .highlighted(latestKeyword, currentKeyword))
            
            return cell
        case searchResultTableView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.reuseIdentifier, for: indexPath) as? SearchResultTableViewCell else { fatalError("couldnt instantiate result table view cell") }
            
            guard let results = reactor?.currentState.slicedSearchResults,
                results.count > indexPath.row,
                let result = reactor?.currentState.slicedSearchResults[indexPath.row] else { fatalError("couldnt retrieve search result \(indexPath.row)") }
            
            cell.reactor = SearchResultTableCellReator(searchResult: result)
            
            return cell
        default:
            return UITableViewCell()
        }
        
    }
}

extension SearchViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let reactor = self.reactor else { return }
        let results = indexPaths.map { reactor.currentState.searchResults[$0.row] }
        
        let urls = results.map { $0.artworkUrl100 }
        
        urls.forEach {
            ImageDownloadManager.shared.downloadImage($0, indexPath: nil, handler: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        guard let reactor = self.reactor else { return }
        let results = indexPaths.map { reactor.currentState.searchResults[$0.row] }
        
        let urls = results.map { $0.artworkUrl100 }
        
        urls.forEach {
            ImageDownloadManager.shared.cancelDownloadImage($0, indexPath: nil)
        }
    }
}
