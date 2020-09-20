//
//  AppInformation.swift
//  KakaoMinsoo
//
//  Created by ZES2017MBP on 2020/09/20.
//  Copyright © 2020 Minsoo. All rights reserved.
//

import Foundation

enum AppInformationItem {
    case `default`(SearchResult, String, String)
    case age(SearchResult)
    case developerWebsite(SearchResult)
    case privacyPolicy(SearchResult)
}

extension AppInformationItem {
    var searchResult: SearchResult {
        get {
            switch self {
            case .default(let searchResult, _, _):
                return searchResult
            case .age(let searchResult):
                return searchResult
            case .developerWebsite(let searchResult):
                return searchResult
            case .privacyPolicy(let searchResult):
                return searchResult
            }
        }
    }
}
