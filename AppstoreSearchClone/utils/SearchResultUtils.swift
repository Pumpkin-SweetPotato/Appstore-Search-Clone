//
//  SearchResultUtils.swift
//  KakaoMinsoo
//
//  Created by ZES2017MBP on 2020/09/18.
//  Copyright © 2020 Minsoo. All rights reserved.
//

import Foundation

extension SearchResult {
    var formattedRatingCount: String {
        get {
            let floatRating: Float = Float(userRatingCount)
            if floatRating / 1000 > 1 {
               return String(format: "%.1fK", floatRating / 1000)
            } else {
               return String(userRatingCount)
            }
        }
    }
}
