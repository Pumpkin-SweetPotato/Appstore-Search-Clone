//
//  Separator.swift
//  KakaoMinsoo
//
//  Created by ZES2017MBP on 2020/09/18.
//  Copyright © 2020 Minsoo. All rights reserved.
//

import UIKit

class Separator: UIView {
    var separator = UIView()
    var widthFactor: CGFloat = 1
    var height: CGFloat = 1
    
    init(widthFactor: CGFloat, height: CGFloat) {
        super.init(frame: .zero)
        
        addSubview(separator)
        separator.backgroundColor = .searchGray(alpha: 0.4)
        
        separator.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(widthFactor)
            make.centerX.equalToSuperview()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard self.superview != nil else { return }
        self.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.height.equalTo(height)
        }
    }
}

