//
//  KakaoMinsooTests.swift
//  Appstore-search-clone-Tests
//
//  Created by ZES2017MBP on 2020/09/16.
//  Copyright © 2020 Minsoo. All rights reserved.
//

import XCTest
@testable import AppstoreSearchClone

class AppstoreTests: XCTestCase {
    
    func testAPIRouterParameter() throws {
        let searchRequestParameter: SearchRequestParameter =
        .init(term: "카카오뱅크",
              country: "KR",
              media: .software([.software]),
              attribute: nil,
              callback: "",
              limit: 2,
              lang: .korea,
              version: 2,
              explicit: .no)
        
        let apiRouter: APIRouter = .requestList(searchRequestParameter)
        
        print("paramsString", apiRouter.paramsString)
        print("queryItems", apiRouter.queryItems)
    }

    func testItunesSearch() throws {
        let searchRequestParameter: SearchRequestParameter =
            .init(term: "카카오뱅크",
                  country: "KR",
                  media: .software([.software]),
                  attribute: nil,
                  callback: "",
                  limit: nil,
                  lang: .korea,
                  version: 2,
                  explicit: .no)
        
        let apiRouter: APIRouter = .requestList(searchRequestParameter)
        
        print("paramsString", apiRouter.paramsString)
        print("queryItems", apiRouter.queryItems)
        
        let dataReceivedExpectation = expectation(description: "data must not nil")
        
        let completionHandler: ((Data?, URLResponse?, Error?) -> Void) = { (data, response, error) in

            guard let data = data, let _ = response else { return }
            
            let json = try? JSONSerialization.jsonObject(with: data, options: [.allowFragments])
            
            
            print("--- response ---")
            print(json ?? "")
            dataReceivedExpectation.fulfill()
            print("--- response ---")
        }
        let request = APIClient().makeRequest(apiRouter: apiRouter, completionHandler: completionHandler)
        
        request?.resume()
        
        
        wait(for: [dataReceivedExpectation], timeout: 2)
    }
    
    func testJSONConvert() throws {
        let limit: Int = 2
        let searchRequestParameter: SearchRequestParameter =
            .init(term: "카카오뱅크",
                  country: "KR",
                  media: .software([.software]),
                  attribute: nil,
                  callback: "",
                  limit: limit,
                  lang: .korea,
                  version: 2,
                  explicit: .no)
        
        let apiRouter: APIRouter = .requestList(searchRequestParameter)
        
        print("paramsString", apiRouter.paramsString)
        print("queryItems", apiRouter.queryItems)
        
        let jsonConvertSucceed = expectation(description: "data must not nil")
        
        let completionHandler: ((Data?, URLResponse?, Error?) -> Void) = { (data, response, error) in

            guard let data = data, let _ = response else { return }
            
            do {
                print("--- response ---")
                let searchResponse = try JSONDecoder().decode(SearchResponse.self, from: data)
                
                XCTAssertEqual(searchResponse.resultCount, limit)
                print(searchResponse)
                print("--- response ---")
                jsonConvertSucceed.fulfill()
            } catch {
                print("json decode failed")
            }
            
            
            
            
        }
        let request = APIClient().makeRequest(apiRouter: apiRouter, completionHandler: completionHandler)
        
        request?.resume()
        
        
        wait(for: [jsonConvertSucceed], timeout: 2)
    }

}
