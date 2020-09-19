//
//  Constants.swift
//  KakaoMinsoo
//
//  Created by ZES2017MBP on 2020/09/18.
//  Copyright © 2020 Minsoo. All rights reserved.
//

import UIKit

struct SearchConstants {
    static func statusBarHeight(rootView: UIView) -> CGFloat? {
        return rootView.window?.windowScene?.statusBarManager?.statusBarFrame.height
    }
    
    static var defaultLeading: CGFloat = 20
    static var defaultTrailing: CGFloat = 20
}

extension UIColor {
    static let searchGray: UIColor = UIColor(red: 142/255, green: 142/255, blue: 142/255, alpha: 1.0)
    static func searchGray(alpha: CGFloat) -> UIColor {
        UIColor(red: 142/255, green: 142/255, blue: 142/255, alpha: alpha)
    }
}
