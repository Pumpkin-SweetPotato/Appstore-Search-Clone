//
//  StringExtension.swift
//  KakaoMinsoo
//
//  Created by eazel7 on 2020/09/21.
//  Copyright © 2020 Minsoo. All rights reserved.
//

import UIKit

extension String {
    func highlightKeyword(keyword: String, font: UIFont, color: UIColor) -> NSMutableAttributedString {
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: self)
        let pattern = keyword.lowercased()
        let range: NSRange = NSMakeRange(0, self.count)
        let regex: NSRegularExpression? = try? NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options())
        
        regex?.enumerateMatches(in: self.lowercased(), options: NSRegularExpression.MatchingOptions(), range: range) { (textCheckingResult, matchingFlags, stop) -> Void in
            let subRange = textCheckingResult?.range
            let attributes: [NSAttributedString.Key: Any] = [
                NSAttributedString.Key.font: font,
                NSAttributedString.Key.foregroundColor: color
            ]
            
            attributedString.addAttributes(attributes, range: subRange!)
        }
        return attributedString
    }
}
