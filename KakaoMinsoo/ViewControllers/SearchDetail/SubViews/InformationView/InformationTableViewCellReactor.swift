//
//  InformationTableViewReactor.swift
//  KakaoMinsoo
//
//  Created by ZES2017MBP on 2020/09/20.
//  Copyright © 2020 Minsoo. All rights reserved.
//

import UIKit
import ReactorKit

final class InformationTableViewCellReactor: Reactor {
    enum Action {
        case tabelTapped
    }
    
    enum Mutation {
        case setExpandInfo(Bool)
        case setDetailViewController(UIViewController?)
    }
    
    struct State {
        var isTruncated: Bool
        var categoryString: String
        var infoString: String
        var detailString: String?
        var detailButtonImage: UIImage?
        var isHiddenDetailButton: Bool = true
        var isShowDetail: Bool = false
    }
    
    var initialState: State
    let searchResult: SearchResult
    let appInformationItem: AppInformationItem
    
    init(appInformationItem: AppInformationItem) {
        self.appInformationItem = appInformationItem
        var categoryString: String = ""
        var infoString: String = ""
        var detailString: String? = nil
        var detailButtonImage: UIImage? = nil
        var isHiddenDetailButton: Bool = true
        
        self.searchResult = appInformationItem.searchResult
        
        switch appInformationItem {
        case .default(_, let category, let info):
            detailButtonImage = UIImage(systemName: "chevron.down")
            infoString = info
            categoryString = category
            if category.lowercased() == "compatibility" {
                var appleDevices: [String] = ["iPhone", "iPad", "iPod", "iWatch"]
                
                let devices: [String] = {
                    var _devices = Set<String>()
                    
                    for device in appInformationItem.searchResult.supportedDevices {
                        for appleDevice in appleDevices {
                            if device.contains(appleDevice) {
                                appleDevices.removeAll(where: { $0.lowercased() == device.lowercased() })
                                _devices.insert(appleDevice)
                                break
                            }
                        }
                        if appleDevices.isEmpty {
                            break
                        }
                    }
                    return Array(_devices)
                }()
                
                let combinedDevices: String = {
                    var sortedAvailableDevices = appleDevices.filter { devices.contains($0) }
                    var devicesString: String = sortedAvailableDevices.removeFirst()
                    
                    for index in 0 ..< sortedAvailableDevices.count {
                        devicesString += "\(index != sortedAvailableDevices.count - 1 ? "," : " and") \(sortedAvailableDevices[index])"
                    }
                    
                    return devicesString
                }()
                if !appInformationItem.searchResult.supportedDevices.filter({ $0.contains(UIDevice.current.localizedModel) }).isEmpty {
                    infoString = "Works on this \(UIDevice.current.localizedModel)"
                } else {
                    infoString = "Not wors on this device"
                }
                
                detailString = "Requires iOS \(searchResult.minimumOSVersion) or later. Compatible with \(combinedDevices)."
                isHiddenDetailButton = false
            } else if category.lowercased() == "languages" {
                let combinedLaungage: String = {
                    var _combindedLanguage: String = ""
    
                    let languages: [String] = appInformationItem.searchResult
                                                .languageCodesISO2A
                                                .compactMap { Locale.current.localizedString(forLanguageCode: $0) }
    
                    if languages.isEmpty {
                        return ""
                    }
    
                    for index in 0..<languages.count {
                        if index == 0 {
                            _combindedLanguage = languages[index]
                        } else {
                            _combindedLanguage += ", \(languages[index])"
                        }
                    }
    
                    return _combindedLanguage
                }()
                
                detailString = combinedLaungage
                isHiddenDetailButton = combinedLaungage.isEmpty
            }
        case .age:
            detailButtonImage = UIImage(systemName: "chevron.down")
            categoryString = "Age Ratings"
            infoString = searchResult.contentAdvisoryRating
            detailString = searchResult.contentAdvisoryRating
            isHiddenDetailButton = false
        case .developerWebsite:
            detailButtonImage = UIImage(systemName: "safari")
            categoryString = "Developer Website"
            isHiddenDetailButton = false
        case .privacyPolicy:
            detailButtonImage = UIImage(systemName: "hand_raised.fill")
            categoryString = "Privacy Policy"
            isHiddenDetailButton = false
        }
        
        initialState = State(
            isTruncated: false,
            categoryString: categoryString,
            infoString: infoString,
            detailString: detailString,
            detailButtonImage: detailButtonImage,
            isHiddenDetailButton: isHiddenDetailButton
        )
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .tabelTapped:
            switch appInformationItem {
            case .default:
                guard currentState.detailString != nil else { return .empty() }
                return .concat(.just(.setExpandInfo(true)), .just(.setExpandInfo(false)))
            case .age:
                return .concat(.just(.setExpandInfo(true)), .just(.setExpandInfo(false)))
            case .developerWebsite:
                if let urlString = searchResult.sellerURL, let url = URL(string: urlString) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
                
                return .empty()
            case .privacyPolicy:
                return .empty()
            default:
                return .empty()
            }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case .setExpandInfo(let set):
            state.isShowDetail = set
        case .setDetailViewController(_):
            print("setDetailViewController")
        }
        
        return state
    }
}
