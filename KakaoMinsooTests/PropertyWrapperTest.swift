//
//  PropertyWrapperTest.swift
//  KakaoMinsooTests
//
//  Created by ZES2017MBP on 2020/09/17.
//  Copyright © 2020 Minsoo. All rights reserved.
//

import XCTest

class PropertyWrapperTest: XCTestCase {


    func testSearchKeywordMustbeSame() throws {
        let searchKeywords =  ["search1", "search2", "search3"]
        
        SearchUserDefaults.latestSearchKeywords = searchKeywords
        
        
        XCTAssertEqual(SearchUserDefaults.latestSearchKeywords.filter { searchKeywords.contains($0) }.count, searchKeywords.count)
    }

}
