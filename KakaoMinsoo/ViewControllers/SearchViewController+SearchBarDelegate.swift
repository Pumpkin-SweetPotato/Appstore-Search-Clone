//
//  SearchViewController+SearchBarDelegate.swift
//  KakaoMinsoo
//
//  Created by ZES2017MBP on 2020/09/17.
//  Copyright © 2020 Minsoo. All rights reserved.
//

import UIKit

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.reactor?.action.onNext(.searchBegin)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.reactor?.action.onNext(.searchCancel)
    }
}
