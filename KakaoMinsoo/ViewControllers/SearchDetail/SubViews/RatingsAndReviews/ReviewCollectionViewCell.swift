//
//  ReviewCollectionViewCell.swift
//  KakaoMinsoo
//
//  Created by ZES2017MBP on 2020/09/19.
//  Copyright © 2020 Minsoo. All rights reserved.
//

import UIKit
import Cosmos

class ReviewCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier: String = String(describing: ReviewCollectionViewCell.self)
    
    let innerContainerView: UIView = UIView()
    
    let writingContainer = UIView()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "안녕하세욥"
        titleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        
        return titleLabel
    }()
    
    let writingDateLabel: UILabel = {
        let writingDateLabel = UILabel()
        writingDateLabel.text = "2y ago"
        writingDateLabel.font = .systemFont(ofSize: 12, weight: .light)
        writingDateLabel.textColor = .searchGray(alpha: 0.8)
        
        return writingDateLabel
    }()
    
    let cosmosView: CosmosView = {
        let cosmosView = CosmosView()
        cosmosView.settings.fillMode = .precise
        cosmosView.settings.disablePanGestures = true
        cosmosView.settings.updateOnTouch = false
        cosmosView.settings.starSize = 15
        cosmosView.settings.starMargin = 0
        cosmosView.settings.filledColor = UIColor(red: 220/255, green: 180/255, blue: 0, alpha: 1)
        cosmosView.settings.emptyBorderColor = UIColor(red: 220/255, green: 180/255, blue: 0, alpha: 1)
        cosmosView.settings.filledBorderColor = UIColor(red: 220/255, green: 180/255, blue: 0, alpha: 1)
        cosmosView.rating = 5
        
        return cosmosView
    }()
    
    let reviewContainer = UIView()
    
    let writerLabel: UILabel = {
        let writerLabel = UILabel()
        writerLabel.text = "닉네임"
        writerLabel.font = .systemFont(ofSize: 14, weight: .light)
        writerLabel.textColor = .searchGray(alpha: 0.8)
        
        return writerLabel
    }()
    
    let reviewContentLabel: UILabel = {
        let reviewContentLabel = UILabel()
        reviewContentLabel.text = """
        안녕하세요 카카오뱅크를 잘 사용하고 있는 사람입니다. 다름아니라 제가 세이프 박스 기능을 사용하고 있는데
                      
        """
        reviewContentLabel.font = .systemFont(ofSize: 14, weight: .light)
        
        reviewContentLabel.numberOfLines = 7
        
        return reviewContentLabel
    }()
    
    let answerContainer = UIView()
    
    let developerResponseLabel: UILabel = {
        let developerResponseLabel = UILabel()
        developerResponseLabel.text = "Developer Response"
        developerResponseLabel.font = .systemFont(ofSize: 14, weight: .medium)
        
        return developerResponseLabel
    }()
    
    let developerAnswerContentLabel: UILabel = {
        let reviewAnswer = UILabel()
        reviewAnswer.text = """
        안녕하세요. 카카오뱅크입니다.
        """
        reviewAnswer.font = .systemFont(ofSize: 14, weight: .light)
        
        return reviewAnswer
    }()
    
    func configureViews() {
        contentView.backgroundColor = UIColor.searchGray(alpha: 0.1)
        contentView.layer.cornerRadius = 8
        contentView.addSubview(innerContainerView)
        innerContainerView.addSubview(writingContainer)
        writingContainer.addSubview(titleLabel)
        writingContainer.addSubview(writingDateLabel)
        writingContainer.addSubview(cosmosView)
        writingContainer.addSubview(reviewContainer)
        writingContainer.addSubview(writerLabel)
        reviewContainer.addSubview(reviewContentLabel)
        innerContainerView.addSubview(answerContainer)
        answerContainer.addSubview(developerResponseLabel)
        answerContainer.addSubview(developerAnswerContentLabel)
    }
    
    func setConstraints() {
        innerContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-12)
        }
        
        writingContainer.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        writingDateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        cosmosView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
            make.leading.equalToSuperview().offset(-2)
            make.bottom.equalToSuperview()
        }
        
        writerLabel.snp.makeConstraints { make in
            make.top.equalTo(writingDateLabel.snp.bottom).offset(3)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        reviewContainer.setContentHuggingPriority(.defaultLow, for: .vertical)
        
        reviewContainer.snp.makeConstraints { make in
            make.top.equalTo(writingContainer.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
        }
        
        
        reviewContentLabel.setContentHuggingPriority(.init(751), for: .vertical)
        
        reviewContentLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
        }
        
        answerContainer.snp.makeConstraints { make in
            make.top.equalTo(reviewContainer.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        developerResponseLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        developerAnswerContentLabel.snp.makeConstraints { make in
            make.top.equalTo(developerResponseLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        configureViews()
        setConstraints()
    }

    required init?(coder: NSCoder) {
       return nil
    }
    
    
}
