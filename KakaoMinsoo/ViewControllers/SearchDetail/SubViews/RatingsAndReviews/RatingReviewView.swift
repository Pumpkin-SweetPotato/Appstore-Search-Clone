//
//  RatingReviewView.swift
//  KakaoMinsoo
//
//  Created by ZES2017MBP on 2020/09/19.
//  Copyright © 2020 Minsoo. All rights reserved.
//

import UIKit
import ReactorKit
import Cosmos

class RatingReviewView: UIView, ReactorKit.View {
    let ratingsReviewsLabel: UILabel = {
        let ratingsReviewsLabel = UILabel()
        ratingsReviewsLabel.text = "Ratings & Reviews"
        ratingsReviewsLabel.font = .systemFont(ofSize: 20, weight: .bold)
        
        return ratingsReviewsLabel
    }()
    
    let seeAllLabel: UILabel = {
        let seeAllLabel = UILabel()
        seeAllLabel.font = .systemFont(ofSize: 14)
        seeAllLabel.text = "See All"
        seeAllLabel.textColor = .systemBlue
        
        return seeAllLabel
    }()
    
    let ratingContainer = UIView()
    
    let floatRatingLabel: UILabel = {
        let floatRatingLabel = UILabel()
        floatRatingLabel.font = .systemFont(ofSize: 30, weight: .bold)
        floatRatingLabel.textColor = UIColor.black.withAlphaComponent(0.9)
        
        return floatRatingLabel
    }()
    
    let outOfRatingLabel: UILabel = {
        let outOfRatingLabel = UILabel()
        outOfRatingLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        outOfRatingLabel.textColor = UIColor.black.withAlphaComponent(0.7)
        
        return outOfRatingLabel
    }()
    
    let ratingStarContainer =  UIView()
    
    let fiveStarCosmos: CosmosView = {
        let fiveStarCosmos = CosmosView()
        fiveStarCosmos.settings.fillMode = .precise
        fiveStarCosmos.settings.disablePanGestures = true
        fiveStarCosmos.settings.updateOnTouch = false
        fiveStarCosmos.settings.starSize = 8
        fiveStarCosmos.settings.starMargin = 0
        fiveStarCosmos.settings.filledColor = UIColor.searchGray(alpha: 0.8)
        fiveStarCosmos.settings.emptyBorderColor = UIColor.searchGray(alpha: 0.8)
        fiveStarCosmos.settings.filledBorderColor = UIColor.searchGray(alpha: 0.8)
        
        fiveStarCosmos.rating = 5
        
        return fiveStarCosmos
    }()
    
    let fiveStarRatingBar = RatingBar()
    
    let fourStarCosmos: CosmosView = {
        let fourStarCosmos = CosmosView()
        fourStarCosmos.settings.fillMode = .precise
        fourStarCosmos.settings.disablePanGestures = true
        fourStarCosmos.settings.updateOnTouch = false
        fourStarCosmos.settings.starSize = 8
        fourStarCosmos.settings.starMargin = 0
        fourStarCosmos.settings.filledColor = UIColor.searchGray(alpha: 0.8)
        fourStarCosmos.settings.emptyBorderColor = UIColor.searchGray(alpha: 0.8)
        fourStarCosmos.settings.filledBorderColor = UIColor.searchGray(alpha: 0.8)
        
        fourStarCosmos.rating = 5
        
        return fourStarCosmos
    }()
    
    let fourStarRatingBar = RatingBar()
    
    let threeStarCosmos: CosmosView = {
        let threeStarCosmos = CosmosView()
        threeStarCosmos.settings.fillMode = .precise
        threeStarCosmos.settings.disablePanGestures = true
        threeStarCosmos.settings.updateOnTouch = false
        threeStarCosmos.settings.starSize = 8
        threeStarCosmos.settings.starMargin = 0
        threeStarCosmos.settings.filledColor = UIColor.searchGray(alpha: 0.8)
        threeStarCosmos.settings.emptyBorderColor = UIColor.searchGray(alpha: 0.8)
        threeStarCosmos.settings.filledBorderColor = UIColor.searchGray(alpha: 0.8)
        
        threeStarCosmos.rating = 5
        
        return threeStarCosmos
    }()
    
    let threeStarRatingBar = RatingBar()
    
    let twoStarCosmos: CosmosView = {
        let twoStarCosmos = CosmosView()
        twoStarCosmos.settings.fillMode = .precise
        twoStarCosmos.settings.disablePanGestures = true
        twoStarCosmos.settings.updateOnTouch = false
        twoStarCosmos.settings.starSize = 8
        twoStarCosmos.settings.starMargin = 0
        twoStarCosmos.settings.filledColor = UIColor.searchGray(alpha: 0.8)
        twoStarCosmos.settings.emptyBorderColor = UIColor.searchGray(alpha: 0.8)
        twoStarCosmos.settings.filledBorderColor = UIColor.searchGray(alpha: 0.8)
        
        twoStarCosmos.rating = 5
        
        return twoStarCosmos
    }()
    
    let twoStarRatingBar = RatingBar()
    
    let oneStarCosmos: CosmosView = {
        let oneStarCosmos = CosmosView()
        oneStarCosmos.settings.fillMode = .precise
        oneStarCosmos.settings.disablePanGestures = true
        oneStarCosmos.settings.updateOnTouch = false
        oneStarCosmos.settings.starSize = 8
        oneStarCosmos.settings.starMargin = 0
        oneStarCosmos.settings.filledColor = UIColor.searchGray(alpha: 0.8)
        oneStarCosmos.settings.emptyBorderColor = UIColor.searchGray(alpha: 0.8)
        oneStarCosmos.settings.filledBorderColor = UIColor.searchGray(alpha: 0.8)
        
        oneStarCosmos.rating = 5
        
        return oneStarCosmos
    }()
    
    let oneStarRatingBar = RatingBar()
    
    let ratingNumberLabel: UILabel = {
        let ratingNumberLabel = UILabel()
        ratingNumberLabel.font = .systemFont(ofSize: 14, weight: .light)
        
        return ratingNumberLabel
    }()
    
    let reviewCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let reviewCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        
        
        return reviewCollectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    
}
