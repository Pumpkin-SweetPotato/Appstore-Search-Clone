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
    
    let seeAllButton: UIButton = {
        let seeAllButton = UIButton()
        seeAllButton.titleLabel?.font = .systemFont(ofSize: 14)
        seeAllButton.setTitle("See All", for: .normal)
        seeAllButton.setTitleColor(.systemBlue, for: .normal)
        
        return seeAllButton
    }()
    
    let ratingContainer = UIView()
    
    let floatRatingLabel: UILabel = {
        let floatRatingLabel = UILabel()
        floatRatingLabel.font = .systemFont(ofSize: 45, weight: .bold)
        floatRatingLabel.textColor = UIColor.black.withAlphaComponent(0.9)
        
        return floatRatingLabel
    }()
    
    let outOfRatingLabel: UILabel = {
        let outOfRatingLabel = UILabel()
        outOfRatingLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        outOfRatingLabel.textColor = UIColor.black.withAlphaComponent(0.7)
        outOfRatingLabel.text = "out of 5"
        outOfRatingLabel.textAlignment = .center
        
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
        fiveStarCosmos.settings.filledColor = UIColor.searchGray
        fiveStarCosmos.settings.emptyBorderColor = UIColor.searchGray
        fiveStarCosmos.settings.filledBorderColor = UIColor.searchGray
        
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
        fourStarCosmos.settings.filledColor = UIColor.searchGray
        fourStarCosmos.settings.emptyBorderColor = UIColor.searchGray
        fourStarCosmos.settings.filledBorderColor = UIColor.searchGray
        fourStarCosmos.settings.totalStars = 4
        fourStarCosmos.rating = 4
        
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
        threeStarCosmos.settings.filledColor = UIColor.searchGray
        threeStarCosmos.settings.emptyBorderColor = UIColor.searchGray
        threeStarCosmos.settings.filledBorderColor = UIColor.searchGray
        threeStarCosmos.settings.totalStars = 3
        threeStarCosmos.rating = 3
        
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
        twoStarCosmos.settings.filledColor = UIColor.searchGray
        twoStarCosmos.settings.emptyBorderColor = UIColor.searchGray
        twoStarCosmos.settings.filledBorderColor = UIColor.searchGray
        twoStarCosmos.settings.totalStars = 2
        twoStarCosmos.rating = 2
        
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
        oneStarCosmos.settings.filledColor = UIColor.searchGray
        oneStarCosmos.settings.emptyBorderColor = UIColor.searchGray
        oneStarCosmos.settings.filledBorderColor = UIColor.searchGray
        oneStarCosmos.settings.totalStars = 1
        
        oneStarCosmos.rating = 1
        
        return oneStarCosmos
    }()
    
    let oneStarRatingBar = RatingBar()
    
    let ratingNumberLabel: UILabel = {
        let ratingNumberLabel = UILabel()
        ratingNumberLabel.font = .systemFont(ofSize: 14, weight: .light)
        ratingNumberLabel.textColor = UIColor.searchGray(alpha: 0.8)
        
        return ratingNumberLabel
    }()
    
    let reviewCollectionView: UICollectionView = {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.minimumInteritemSpacing = .zero
        flowlayout.minimumLineSpacing = .zero
        flowlayout.scrollDirection = .horizontal

        let reviewCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
        reviewCollectionView.isPagingEnabled = false
        reviewCollectionView.showsHorizontalScrollIndicator = false
        reviewCollectionView.register(ReviewCollectionViewCell.self,
                                      forCellWithReuseIdentifier: ReviewCollectionViewCell.reuseIdentifier)
        reviewCollectionView.contentInset = .init(top: 0, left: 20, bottom: 0, right: 10)
        reviewCollectionView.backgroundColor = .systemBackground
        
        
        return reviewCollectionView
    }()
    
    let cellWidthFactor: CGFloat = DeviceType.iPhoneX || DeviceType.iPhoneXRMax ? 0.9 : 0.9
    let cellHeightFactor: CGFloat = DeviceType.iPhoneX || DeviceType.iPhoneXRMax ? 0.2 : 0.3
    
    let cellSize: CGSize
    
    let cellInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
    
    var disposeBag: DisposeBag = DisposeBag()
    
    func addSubviews() {
        addSubview(ratingsReviewsLabel)
        addSubview(seeAllButton)
        addSubview(ratingContainer)
        ratingContainer.addSubview(floatRatingLabel)
        ratingContainer.addSubview(outOfRatingLabel)
        addSubview(ratingStarContainer)
        ratingStarContainer.addSubview(fiveStarCosmos)
        ratingStarContainer.addSubview(fiveStarRatingBar)
        ratingStarContainer.addSubview(fourStarCosmos)
        ratingStarContainer.addSubview(fourStarRatingBar)
        ratingStarContainer.addSubview(threeStarCosmos)
        ratingStarContainer.addSubview(threeStarRatingBar)
        ratingStarContainer.addSubview(twoStarCosmos)
        ratingStarContainer.addSubview(twoStarRatingBar)
        ratingStarContainer.addSubview(oneStarCosmos)
        ratingStarContainer.addSubview(oneStarRatingBar)
        ratingStarContainer.addSubview(ratingNumberLabel)
        addSubview(reviewCollectionView)
    }
    
    func setConstraints() {
        ratingsReviewsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(SearchConstants.defaultLeading)
        }
        
        seeAllButton.snp.makeConstraints { make in
            make.bottom.equalTo(ratingsReviewsLabel)
            make.trailing.equalToSuperview().offset(-SearchConstants.defaultTrailing)
        }
        
        ratingContainer.snp.makeConstraints { make in
            make.top.equalTo(ratingsReviewsLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(SearchConstants.defaultLeading)
        }
        
        floatRatingLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        outOfRatingLabel.snp.makeConstraints { make in
            make.top.equalTo(floatRatingLabel.snp.bottom)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        ratingStarContainer.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        ratingStarContainer.snp.makeConstraints { make in
            make.top.equalTo(ratingContainer).offset(8)
            make.leading.equalTo(ratingContainer.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-SearchConstants.defaultTrailing)
        }
        
        fiveStarCosmos.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }
        
        fiveStarRatingBar.snp.makeConstraints { make in
            make.leading.equalTo(fiveStarCosmos.snp.trailing).offset(5)
            make.height.equalTo(2)
            make.trailing.equalToSuperview()
            make.centerY.equalTo(fiveStarCosmos)
        }
        
        fourStarCosmos.snp.makeConstraints { make in
            make.top.equalTo(fiveStarCosmos.snp.bottom).offset(2)
            make.trailing.equalTo(fiveStarCosmos)
        }
        
        fourStarRatingBar.snp.makeConstraints { make in
            make.leading.equalTo(fourStarCosmos.snp.trailing).offset(5)
            make.height.equalTo(2)
            make.trailing.equalToSuperview()
            make.centerY.equalTo(fourStarCosmos)
        }
        
        threeStarCosmos.snp.makeConstraints { make in
            make.top.equalTo(fourStarCosmos.snp.bottom).offset(2)
            make.trailing.equalTo(fiveStarCosmos)
        }
        
        threeStarRatingBar.snp.makeConstraints { make in
            make.leading.equalTo(threeStarCosmos.snp.trailing).offset(5)
            make.height.equalTo(2)
            make.trailing.equalToSuperview()
            make.centerY.equalTo(threeStarCosmos)
        }
        
        twoStarCosmos.snp.makeConstraints { make in
            make.top.equalTo(threeStarCosmos.snp.bottom).offset(2)
            make.trailing.equalTo(fiveStarCosmos)
        }
        
        twoStarRatingBar.snp.makeConstraints { make in
            make.leading.equalTo(twoStarCosmos.snp.trailing).offset(5)
            make.height.equalTo(2)
            make.trailing.equalToSuperview()
            make.centerY.equalTo(twoStarCosmos)
        }
        
        oneStarCosmos.snp.makeConstraints { make in
            make.top.equalTo(twoStarCosmos.snp.bottom).offset(2)
            make.trailing.equalTo(fiveStarCosmos)
        }
        
        oneStarRatingBar.snp.makeConstraints { make in
            make.leading.equalTo(oneStarCosmos.snp.trailing).offset(5)
            make.height.equalTo(2)
            make.trailing.equalToSuperview()
            make.centerY.equalTo(oneStarCosmos)
        }
        
        ratingNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(oneStarCosmos.snp.bottom).offset(3)
            make.trailing.equalToSuperview()
        }
        
        reviewCollectionView.snp.makeConstraints { make in
            make.top.equalTo(ratingContainer.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(cellSize.height + 1)
            make.bottom.equalToSuperview()
        }
    }
    
    override init(frame: CGRect) {
        cellSize = CGSize(width: UIScreen.main.bounds.width * cellWidthFactor - 1,
                                 height: UIScreen.main.bounds.height * cellHeightFactor - 1)
        super.init(frame: frame)
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    
    func bind(reactor: RatingReviewViewReactor) {
        reviewCollectionView.delegate = self
        reviewCollectionView.dataSource = self
        
        reactor.state.map { $0.ratingFloatString }
            .distinctUntilChanged()
            .bind(to: floatRatingLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.ratingNumberString }
            .distinctUntilChanged()
            .compactMap { $0 }
            .map { "\($0) Ratings" }
            .bind(to: ratingNumberLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
}

extension RatingReviewView: UICollectionViewDelegate {
    
}

extension RatingReviewView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewCollectionViewCell.reuseIdentifier, for: indexPath)
            as? ReviewCollectionViewCell else { fatalError() }
        
        if indexPath.section == 2 {
            cell.answerContainer.isHidden = true
        }
        
        return cell
    }
    
    
}


extension RatingReviewView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return cellInset
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageWidth = cellSize.width
        targetContentOffset.pointee = scrollView.contentOffset
        
        let targetIndexCGFloat: CGFloat =
            scrollView.contentOffset.x / (pageWidth + cellInset.left + cellInset.right)
    
        var factor: CGFloat = 0.5
        
        if velocity.x < 0 {
            factor = -factor
        }
        
        var index = Int( round(targetIndexCGFloat + factor))
        
        if index < 0 {
            index = 0
        } else {
            index = min(3, index)
        }
        
        let indexPath = IndexPath(row: 0, section: index)
        reviewCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
    }
}


extension RatingReviewView: SearchDetailViewDelegate {
    func didLayoutSubviews() {
        if fiveStarRatingBar.frame.size != .zero {
            fiveStarRatingBar.rating = 0.6
        }
        if fiveStarRatingBar.frame.size != .zero {
            fourStarRatingBar.rating = 0.2
        }
        if fiveStarRatingBar.frame.size != .zero {
            threeStarRatingBar.rating = 0.3
        }
        if fiveStarRatingBar.frame.size != .zero {
            twoStarRatingBar.rating = 0.1
        }
        if fiveStarRatingBar.frame.size != .zero {
            oneStarRatingBar.rating = 0.3
        }
    }
}
