//
//  AppScreenshotCell.swift
//  KakaoMinsoo
//
//  Created by ZES2017MBP on 2020/09/19.
//  Copyright © 2020 Minsoo. All rights reserved.
//

import UIKit

class AppScreenshotCell: UICollectionViewCell {
    static let reuseIdentifier: String = String(describing: AppScreenshotCell.self)
    
    let screenshatImageView: UIImageView = {
        let screenshatImageView = UIImageView()
        screenshatImageView.contentMode = .scaleAspectFit
        screenshatImageView.layer.cornerRadius = 10
        screenshatImageView.layer.masksToBounds = true
        
        return screenshatImageView
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        screenshatImageView.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    func configureViews() {
        contentView.addSubview(screenshatImageView)
        
        screenshatImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
