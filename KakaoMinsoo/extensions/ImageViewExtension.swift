//
//  ImageViewExtension.swift
//  KakaoMinsoo
//
//  Created by ZES2017MBP on 2020/09/18.
//  Copyright © 2020 Minsoo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIImageView {
    public func fadeImage(withDuration durationL: TimeInterval = 0.25) -> Binder<UIImage?> {
        return Binder(base) { imageView, image -> Void in
            let alpha = imageView.alpha > 0 ? imageView.alpha : 1
            imageView.alpha = 0
            imageView.image = image
            
            DispatchQueue.main.async {
                UIView.animate(withDuration: durationL) {
                    imageView.alpha = alpha
                }
            }
        }
    }
    
    
}

extension UIImageView {
    public func fadeImage(image: UIImage, withDuration duration: TimeInterval = 0.25) {
        DispatchQueue.main.async {
            let _alpha = self.alpha > 0 ? self.alpha : 1
            self.alpha = 0
            self.image = image
        
            UIView.animate(withDuration: duration) {
                self.alpha = _alpha
            }
        }
    }
}


extension UILabel {
    var isTruncated: Bool {
        
        guard let _ = text else {
            return false
        }
        
        return labelTextSize.height > bounds.size.height
    }
    
    var labelTextSize: CGSize {
        guard let labelText = text else {
            return CGSize(width: 0, height: 0)
        }
        
        let largestSize = CGSize(width: frame.size.width, height: .greatestFiniteMagnitude)

        let labelTextSize = (labelText as NSString).boundingRect(
            with: largestSize,
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: [.font: font],
            context: nil).size
        
        return labelTextSize
    }
}
