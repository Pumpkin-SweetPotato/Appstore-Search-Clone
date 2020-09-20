//
//  InformationViewReactor.swift
//  KakaoMinsoo
//
//  Created by ZES2017MBP on 2020/09/20.
//  Copyright © 2020 Minsoo. All rights reserved.
//

import Foundation
import ReactorKit

final class InformationViewReactor: Reactor {
    enum Action {
        case itemSelected(IndexPath)
    }
    
    enum Mutation {}
    
    struct State {
        var information: [AppInformationItem]
        var needReload: Bool
    }
    
    var initialState: State
    var searchResult: SearchResult
    
    init(searchResult: SearchResult) {
        self.searchResult = searchResult
        
        var byteString: String = ""
        
        if let fileSize = Int64(searchResult.fileSizeBytes) {
            let byteCountFormatter = ByteCountFormatter()
            byteCountFormatter.countStyle = .file
            byteString = byteCountFormatter.string(fromByteCount: fileSize)
        }
        
        let supportDeviceString: String = {
            if !searchResult.supportedDevices.filter { $0.contains(UIDevice.current.localizedModel) }.isEmpty {
                return "Works on this \(UIDevice.current.localizedModel)"
            } else {
                return ""
            }
        }()
        
        let languageString: String? = {
            var primaryLanguage: String = ""
            guard searchResult.languageCodesISO2A.isEmpty == false else { return "" }
            
            if let code = searchResult.languageCodesISO2A.first(where: { $0 == Locale.current.identifier }) {
                primaryLanguage = Locale.current.localizedString(forLanguageCode: code) ?? ""
            } else {
                primaryLanguage = Locale.current.localizedString(forLanguageCode: searchResult.languageCodesISO2A.first!) ?? ""
            }
            
            if searchResult.languageCodesISO2A.count > 1 {
                return "\(primaryLanguage) and \(searchResult.languageCodesISO2A.count - 1) more"
            }
            
            return primaryLanguage
        }()
        
        var information: [AppInformationItem] = [
            .default(searchResult, "Provider", searchResult.sellerName),
            .default(searchResult, "Size",  byteString),
            .default(searchResult, "Category", searchResult.primaryGenreName),
            
        ]
        
        if !supportDeviceString.isEmpty {
            information.append(.default(searchResult, "Compatibility", supportDeviceString))
        }
        
        if languageString?.isEmpty == false {
            information.append(.default(searchResult, "Languages", languageString!))
        }
        
        information.append(.age(searchResult))
        information.append(.default(searchResult, "Copyright", "© \(searchResult.sellerName)"))
        
        if searchResult.sellerURL?.isEmpty != nil {
            information.append(.developerWebsite(searchResult))
        }
        
//        information.append(.privacyPolicy(searchResult))
        
        initialState = State(information: information, needReload: true)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .itemSelected(let indexPath):
            switch currentState.information[indexPath.row] {
            case .developerWebsite:
                if let urlString = searchResult.sellerURL, let url = URL(string: urlString) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            case .privacyPolicy:
                return .empty()
            default:
                break;
            }
            
            return .empty()
        }
        return .empty()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        return state
    }
}
