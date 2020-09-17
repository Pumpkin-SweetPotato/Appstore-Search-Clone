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
