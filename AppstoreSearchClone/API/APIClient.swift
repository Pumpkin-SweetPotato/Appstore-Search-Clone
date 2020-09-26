//
//  APIClient.swift
//  KakaoMinsoo
//
//  Created by ZES2017MBP on 2020/09/16.
//  Copyright © 2020 Minsoo. All rights reserved.
//

import Foundation


struct SearchRequestParameter {
    let term: String
    let country: String
    let media: MediaType?
    let attribute: AttributeType?
    let callback: String
    let limit: Int?
    let lang: SearchLanguage?
    let version: Int?
    let explicit: ExplitType?
    
    init(term: String,
         country: String = "KR",
         media: MediaType = .software([.software]),
         attribute: AttributeType? = nil,
         callback: String = "",
         limit: Int? = 50,
         lang: SearchLanguage? = .korea,
         version: Int = 2,
         explicit: ExplitType? = .no) {
        self.term = term
        self.country = country
        self.media = media
        self.attribute = attribute
        self.callback = callback
        self.limit = limit
        self.lang = lang
        self.version = version
        self.explicit = explicit
    }
}

enum APIRouter {
    case requestList(SearchRequestParameter)
    
    var paramsString: [String: Any] {
        switch self {
            case .requestList(let params):
                var result: [String: Any] = [:]
                let mirror = Mirror(reflecting: params)
                for (labelMaybe, valueMaybe) in mirror.children {
                    guard let label = labelMaybe else  {
                        continue
                    }
                    
                    if label == "media" {
                        let mediaType = valueMaybe as! MediaType
                        result["media"] = mediaType.mediaType
                        result["entity"] = mediaType.entities
                    } else {
                        result[label] = valueMaybe
                    }
                }


                return result
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
            case .requestList(let params):
                var _queryItems: [URLQueryItem] = []
                
                let mirror = Mirror(reflecting: params)
                
                for (labelMaybe, valueMaybe) in mirror.children {
                    guard let label = labelMaybe else  {
                        continue
                    }
                    
                    if label == "media", let mediaType = valueMaybe as? MediaType {
                        _queryItems.append(.init(name: "media", value: mediaType.mediaType))
                        let entityValue: String = {
                            return String(mediaType.entities.reduce("") { $0 + "\($1)," }.dropLast())
                        }()
                        _queryItems.append(.init(name: "entity", value: entityValue))
                    } else {
                        if let stringValue = valueMaybe as? String {
                            _queryItems.append(.init(name: label, value: stringValue))

                        } else if let integerValue = valueMaybe as? Int {
                            _queryItems.append(.init(name: label, value: String(integerValue)))
                        }
                    }
                }
                
                return _queryItems
        }
    }

    
    public var asURL: URL? {
        switch self {
        case .requestList:
            var urlComponents: URLComponents = .init()
            
            urlComponents.scheme = "https"
            urlComponents.host = APIConstants.baseURL
            urlComponents.path = "/search"
            urlComponents.queryItems = self.queryItems
            
            return urlComponents.url
        }
    }
    
}

class APIClient {
    let session: URLSession = URLSession.shared
    var searchRequest: URLSessionDataTask?
    
    typealias APISearchResult = (Data?, URLResponse?, Error?)
    typealias APICompletionHandler = ((Data?, URLResponse?, Error?) -> Void)
    
    func makeRequest(apiRouter: APIRouter, completionHandler: @escaping APICompletionHandler) -> URLSessionDataTask? {

        guard let url = apiRouter.asURL else { return nil }
        let request = session.dataTask(with: url, completionHandler: completionHandler)
        
        if searchRequest != nil {
            searchRequest?.cancel()
            searchRequest = nil
        }
        
        searchRequest = request
        
        return request
    }
    
    func reqeust(apiRouter: APIRouter, completionHandler: @escaping APICompletionHandler) {
        let request = makeRequest(apiRouter: apiRouter, completionHandler: completionHandler)
        
        request?.resume()
    }
    
    

}

import RxSwift

extension APIClient {
    func reqeust<T: Codable> (_ t: T.Type, _ apiRouter: APIRouter) -> Observable<T> {
        return Observable.create { observer in
            let request = self.makeRequest(apiRouter: apiRouter) { (data, response, error) in
                guard let data = data else {
                    if let error = error {
                        observer.onError(error)
                    } else {
                        observer.onError(NSError(domain: "unknown", code: 999, userInfo: nil))
                    }
                    return
                }
                           
                do {
                   let jsonObject = try JSONDecoder().decode(T.self, from: data)
                    observer.onNext(jsonObject)
                    observer.onCompleted()
                } catch {
                   print("json decode failed")
                }
            }
            
            if request == nil {
                observer.onError(NSError(domain: "couldn't make a request", code: 998, userInfo: nil))
            }
            
            self.searchRequest = request
            
            request?.resume()
            
            return Disposables.create {
                request?.cancel()
            }
        }
    }
}
