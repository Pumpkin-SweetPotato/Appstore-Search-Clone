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
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "안녕하세욥"
        
        return titleLabel
    }()
    
    let writingDateLabel: UILabel = {
        let writingDateLabel = UILabel()
        writingDateLabel.text = "2y ago"
        
        return writingDateLabel
    }()
    
    let cosmosView: CosmosView = {
        let cosmosView = CosmosView()
        cosmosView.settings.fillMode = .precise
        cosmosView.settings.disablePanGestures = true
        cosmosView.settings.updateOnTouch = false
        cosmosView.settings.starSize = 8
        cosmosView.settings.starMargin = 0
        cosmosView.settings.filledColor = UIColor.yellow
        cosmosView.settings.emptyBorderColor = UIColor.yellow
        cosmosView.settings.filledBorderColor = UIColor.yellow
        cosmosView.rating = 5
        
        return cosmosView
    }()
    
    let reviewContainer = UIView()
    
    let writerLabel: UILabel = {
        let writerLabel = UILabel()
        writerLabel.text = "ㅋㅋㅋ아놔 이름 겹침"
        writerLabel.font = .systemFont(ofSize: 10)
        
        return writerLabel
    }()
    
    let reviewContentLabel: UILabel = {
        let reviewContentLabel = UILabel()
        reviewContentLabel.text = """
        안녕하세요 카카오뱅크를 잘 사용하고 있는 사람입니다. 다름아니라 제가 세이프 박스 기능을 사용하고 있는데
                      
        """
        
        return reviewContentLabel
    }()
    
    let answerContainer = UIView()
    
    let developerResponseLabel: UILabel ={
        let developerResponseLabel = UILabel()
        
        return developerResponseLabel
    }()
    
    let developerAnswerContentLabel: UILabel = {
        let reviewAnswer = UILabel()
        reviewAnswer.text = """
        안녕하세요. 카카오뱅크입니다.
        """
        
        return reviewAnswer
    }()
    
    func configureViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(writingDateLabel)
        contentView.addSubview(cosmosView)
        contentView.addSubview(reviewContainer)
        reviewContainer.addSubview(writerLabel)
        reviewContainer.addSubview(reviewContentLabel)
        contentView.addSubview(answerContainer)
        answerContainer.addSubview(developerResponseLabel)
        answerContainer.addSubview(developerAnswerContentLabel)
        
    }
    
    override init(frame: CGRect) {
       super.init(frame: frame)
       
       configureViews()
    }

    required init?(coder: NSCoder) {
       return nil
    }
}
