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
        return UITableViewCell()
    }
    
    
}
