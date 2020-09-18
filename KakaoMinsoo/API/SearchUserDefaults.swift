//
//  SearchUserDefaults.swift
//  KakaoMinsoo
//
//  Created by ZES2017MBP on 2020/09/17.
//  Copyright © 2020 Minsoo. All rights reserved.
//

import Foundation

@propertyWrapper
struct LatestSearchKeyword {
    let key: String = "latestSearchKeywords"
    public var wrappedValue: [String] {
        get {
            UserDefaults.standard.array(forKey: key) as? [String] ?? []
        }
        set {
            UserDefaults.standard.setValue(newValue, forKeyPath: key)
        }
    }
}

class SearchUserDefaults {
    @LatestSearchKeyword
    static var latestSearchKeywords: [String]
}
