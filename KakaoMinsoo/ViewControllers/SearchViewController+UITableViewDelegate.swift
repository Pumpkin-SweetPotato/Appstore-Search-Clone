//
//  SearchViewController+UITableViewDelegate.swift
//  KakaoMinsoo
//
//  Created by ZES2017MBP on 2020/09/17.
//  Copyright © 2020 Minsoo. All rights reserved.
//

import UIKit

extension SearchViewController: UITableViewDelegate {
    
}


extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case latestSearchTableView:
            return reactor?.currentState.latestSearchedKeywords.count ?? 0
        case searchResultTableView:
            return reactor?.currentState.searchResults.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case latestSearchTableView:
            return UITableViewCell()
        case searchResultTableView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.reuseIdentifier, for: indexPath) as? SearchResultTableViewCell else { fatalError("couldnt instantiate result table view cell") }
            
            guard let results = reactor?.currentState.searchResults,
                results.count > indexPath.row,
                let result = reactor?.currentState.searchResults[indexPath.row] else { fatalError("couldnt retrieve search result \(indexPath.row)") }
            
            cell.reactor = SearchResultTableCellReator(searchResult: result)
            
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    
}
