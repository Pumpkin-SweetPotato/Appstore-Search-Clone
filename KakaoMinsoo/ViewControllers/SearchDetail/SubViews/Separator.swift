//
//  Separator.swift
//  KakaoMinsoo
//
//  Created by ZES2017MBP on 2020/09/18.
//  Copyright © 2020 Minsoo. All rights reserved.
//

import UIKit

class Separator: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .searchGray(alpha: 0.8)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard self.superview != nil else { return }
        self.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}

