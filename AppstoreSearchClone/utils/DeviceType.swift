//
//  DeviceType.swift
//  KakaoMinsoo
//
//  Created by ZES2017MBP on 2020/09/20.
//  Copyright © 2020 Minsoo. All rights reserved.
//

import UIKit

struct ScreenSize {
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
    static let frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: ScreenSize.height)
    static let maxWH = max(ScreenSize.width, ScreenSize.height)
}


struct DeviceType {
    static let iPhone4orLess = isPhone && ScreenSize.maxWH < 568.0
    static let iPhone5orSE   = isPhone && ScreenSize.maxWH == 568.0
    static let iPhone678     = isPhone && ScreenSize.maxWH == 667.0
    static let iPhone678p    = isPhone && ScreenSize.maxWH == 736.0
    static let iPhoneX       = isPhone && ScreenSize.maxWH == 812.0
    static let iPhoneXRMax   = isPhone && ScreenSize.maxWH == 896.0
    
    static var isPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
}

