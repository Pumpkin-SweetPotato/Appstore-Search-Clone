//
//  AppCommonInformationView.swift
//  KakaoMinsoo
//
//  Created by ZES2017MBP on 2020/09/18.
//  Copyright © 2020 Minsoo. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Cosmos

class AppCommonInformationView: UIView {
    let topContainer = UIView()
    
    let appIconImageView: UIImageView = {
        let appIconImageView = UIImageView()
        appIconImageView.contentMode = .scaleAspectFit
        appIconImageView.layer.cornerRadius = 20
        appIconImageView.layer.masksToBounds = true
        
        return appIconImageView
    }()
    
    let appTitleLabel: UILabel = {
        let appTitleLabel = UILabel()
        appTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        appTitleLabel.numberOfLines = 2
        
        return appTitleLabel
    }()
    
    let corpLabel: UILabel = {
        let corpLabel = UILabel()
        corpLabel.font = UIFont.systemFont(ofSize: 14)
        corpLabel.textColor = .searchGray(alpha: 0.8)
        
        return corpLabel
    }()
    
    let getButton: UIButton = {
        let getButton = UIButton(type: .system)
        getButton.setTitle("GET", for: .normal)
        getButton.setTitleColor(.white, for: .normal)
        getButton.backgroundColor = .systemBlue
        
        return getButton
    }()
    
    let inAppPurchaseLabel: UILabel = {
        let inAppPurchaseLabel = UILabel()
        inAppPurchaseLabel.font = .systemFont(ofSize: 8)
        
        return inAppPurchaseLabel
    }()
    
    let shareButton: UIButton = {
        let shareButton = UIButton(type: .system)
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        shareButton.tintColor = .systemBlue
        
        return shareButton
    }()
    
    let horizontalAppDetailInfoStackView: UIStackView = {
        let horizontalAppDetailInfoStackView = UIStackView()
        horizontalAppDetailInfoStackView.axis = .horizontal
        horizontalAppDetailInfoStackView.alignment = .top
        horizontalAppDetailInfoStackView.distribution = .equalSpacing
        
        return horizontalAppDetailInfoStackView
    }()
    
    let ratingContainer = UIView()
    
    let ratingFloatLabel: UILabel = {
        let ratingFloatLabel = UILabel()
        ratingFloatLabel.font = .systemFont(ofSize: 18)
        ratingFloatLabel.textColor = .searchGray(alpha: 1)
        
        return ratingFloatLabel
    }()
    
    let cosmosView: CosmosView = {
        let cosmosView = CosmosView()
        cosmosView.settings.fillMode = .precise
        cosmosView.settings.disablePanGestures = true
        cosmosView.settings.updateOnTouch = false
        cosmosView.settings.starSize = 18
        cosmosView.settings.starMargin = 0
        cosmosView.settings.filledColor = UIColor.searchGray(alpha: 1)
        cosmosView.settings.emptyBorderColor = UIColor.searchGray(alpha: 1)
        cosmosView.settings.filledBorderColor = UIColor.searchGray(alpha: 1)
    
        return cosmosView
    }()
    
    let ratingNumberLabel: UILabel = {
        let ratingNumberLabel = UILabel()
        ratingNumberLabel.font = .systemFont(ofSize: 12, weight: .light)
        ratingNumberLabel.textColor = .searchGray(alpha: 0.8)
        
        return ratingNumberLabel
    }()
    
    let editorsChoiceContainer = UIView()
    
    let editorsChoiceImageView: UIImageView = {
        let editorsChoiceImageView = UIImageView()
        
        return editorsChoiceImageView
    }()
    
    let editorsChoiceAppLabel: UILabel = {
        let editorsChoiceAppLabel = UILabel()
        
        return editorsChoiceAppLabel
    }()
    
    let rankingContainer = UIView()
    
    let rankingNumberContainer = UIView()
    
    let noLabel: UILabel = {
        let noLabel = UILabel()
        noLabel.text = "No"
        noLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        noLabel.textColor = .searchGray(alpha: 1)
        
        return noLabel
    }()
    
    let rankingNumberLabel: UILabel = {
        let rankingNumberLabel = UILabel()
        rankingNumberLabel.text = "3"
        rankingNumberLabel.font = .systemFont(ofSize: 18, weight: .bold)
        rankingNumberLabel.textColor = .searchGray(alpha: 1)
        
        return rankingNumberLabel
    }()
    
    let genreLabel: UILabel = {
        let genreLabel = UILabel()
        genreLabel.font = .systemFont(ofSize: 12, weight: .light)
        genreLabel.textColor = .searchGray(alpha: 0.8)
        
        return genreLabel
    }()
    
    let advisoryContainer = UIView()
    
    let advisoryLabel: UILabel = {
        let advisoryLabel = UILabel()
        advisoryLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        advisoryLabel.textColor = .searchGray(alpha: 1)
        
        return advisoryLabel
    }()
    
    let ageLabel: UILabel = {
        let ageLabel = UILabel()
        ageLabel.text = "Age"
        ageLabel.font = .systemFont(ofSize: 12, weight: .light)
        ageLabel.textColor = .searchGray(alpha: 0.8)
        
        return ageLabel
    }()
    
    let screenShotCollectionView: UICollectionView = {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.minimumInteritemSpacing = .zero
        flowlayout.minimumLineSpacing = .zero
        flowlayout.scrollDirection = .horizontal
        
        let screenShotCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
        screenShotCollectionView.isPagingEnabled = false
        screenShotCollectionView.showsHorizontalScrollIndicator = false
        screenShotCollectionView.register(AppScreenshotCell.self,
                                          forCellWithReuseIdentifier: AppScreenshotCell.reuseIdentifier)
        screenShotCollectionView.alpha = 0
        screenShotCollectionView.contentInset = .init(top: 0, left: 20, bottom: 0, right: 10)
        screenShotCollectionView.backgroundColor = .systemBackground
        
        return screenShotCollectionView
    }()
    
    let availableDeviceContainer = UIView()
    
    let availableDevicesStackView: UIStackView = {
        let availableDevicesStackView = UIStackView()
        availableDevicesStackView.axis = .horizontal
        availableDevicesStackView.alignment = .bottom
        availableDevicesStackView.distribution = .fillEqually
        
        return availableDevicesStackView
    }()
    
    let availableDeviceDescriptionLabel: UILabel = {
       let availableDeviceDescriptionLabel = UILabel()
        
        return availableDeviceDescriptionLabel
    }()

    let showAllAvailableDeviceChevronButton: UIButton = {
        let showAllAvailableDeviceChevronButton = UIButton()

        return showAllAvailableDeviceChevronButton
    }()
    
    class AvailableDeviceImageView: UIImageView {
        init(deviceImage: UIImage?) {
            super.init(frame: .init(origin: .zero, size: .init(width: 20, height: 20)))
            image = deviceImage
            tintColor = .searchGray(alpha: 0.8)
        }
        
        override init(frame: CGRect) {
            super.init(frame: .zero)
        }
        
        required init?(coder: NSCoder) {
            nil
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureViews()
        setConstraints()
        setDelegate()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    func configureViews() {
        addSubview(topContainer)
        topContainer.addSubview(appIconImageView)
        topContainer.addSubview(appTitleLabel)
        topContainer.addSubview(corpLabel)
        topContainer.addSubview(getButton)
        topContainer.addSubview(inAppPurchaseLabel)
        topContainer.addSubview(shareButton)
        
        addSubview(horizontalAppDetailInfoStackView)
        
        horizontalAppDetailInfoStackView.addArrangedSubview(ratingContainer)
        
        ratingContainer.addSubview(ratingFloatLabel)
        ratingContainer.addSubview(cosmosView)
        ratingContainer.addSubview(ratingNumberLabel)
        
        horizontalAppDetailInfoStackView.addArrangedSubview(editorsChoiceContainer)
        editorsChoiceContainer.addSubview(editorsChoiceImageView)
        editorsChoiceContainer.addSubview(editorsChoiceAppLabel)
        
        horizontalAppDetailInfoStackView.addArrangedSubview(rankingContainer)
        rankingContainer.addSubview(rankingNumberContainer)
        rankingNumberContainer.addSubview(noLabel)
        rankingNumberContainer.addSubview(rankingNumberLabel)
        rankingContainer.addSubview(genreLabel)
        
        horizontalAppDetailInfoStackView.addArrangedSubview(advisoryContainer)
        advisoryContainer.addSubview(advisoryLabel)
        advisoryContainer.addSubview(ageLabel)
        
        addSubview(screenShotCollectionView)
        addSubview(availableDeviceContainer)
        availableDeviceContainer.addSubview(availableDevicesStackView)
    }
    
    func setConstraints() {
        // MARK: - Top Info
        topContainer.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        appIconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(SearchConstants.defaultLeading)
            make.width.height.equalTo(120)
        }
        
        appTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(appIconImageView).offset(4)
            make.leading.equalTo(appIconImageView.snp.trailing).offset(15)
            make.trailing.equalToSuperview().offset(-SearchConstants.defaultTrailing)
        }
        
        corpLabel.snp.makeConstraints { make in
            make.top.equalTo(appTitleLabel.snp.bottom).offset(6)
            make.leading.equalTo(appIconImageView.snp.trailing).offset(15)
            make.trailing.equalToSuperview().offset(-SearchConstants.defaultTrailing)
        }
        
        let getButtonHeight: CGFloat = 25

        getButton.snp.makeConstraints { make in
            make.top.equalTo(corpLabel.snp.bottom).offset(30).priority(.medium)
            make.top.lessThanOrEqualTo(corpLabel.snp.bottom).offset(35).priority(.high)
            make.leading.equalTo(appIconImageView.snp.trailing).offset(15)
            make.height.equalTo(getButtonHeight)
            make.width.equalTo(60)
            make.bottom.equalToSuperview()
        }
        
        getButton.layer.cornerRadius = getButtonHeight / 2

        inAppPurchaseLabel.snp.makeConstraints { make in
            make.leading.equalTo(getButton.snp.trailing).offset(2)
            make.centerY.equalTo(getButton)
        }

        shareButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-SearchConstants.defaultTrailing)
            make.height.equalTo(23)
            make.width.equalTo(19)
            make.centerY.equalTo(getButton)
        }
        
        // App Detail Information StackView
        
        horizontalAppDetailInfoStackView.snp.makeConstraints { make in
            make.top.equalTo(topContainer.snp.bottom).offset(35)
            make.leading.equalToSuperview().offset(SearchConstants.defaultLeading)
            make.trailing.equalToSuperview().offset(-SearchConstants.defaultTrailing)
        }
        
        // MARK:- Rating
        ratingContainer.snp.makeConstraints { make in
//            make.top.equalTo(getButton.snp.bottom).offset(35)
//            make.leading.equalToSuperview().offset(SearchConstants.defaultLeading)
        }
        
        ratingFloatLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        cosmosView.snp.makeConstraints { make in
            make.centerY.equalTo(ratingFloatLabel)
            make.leading.equalTo(ratingFloatLabel.snp.trailing).offset(3)
            make.trailing.equalToSuperview()
        }
        
        ratingNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(ratingFloatLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        // MARK: - TODO editor's choice
        
        // MARK: - Ranking
        rankingContainer.accessibilityLabel = "rankingContainer"
        rankingContainer.snp.makeConstraints { make in
//            make.top.equalTo(getButton.snp.bottom).offset(35)
//            make.leading.equalTo(ratingContainer.snp.trailing).offset(40)
//            make.trailing.equalTo(advisoryContainer.snp.leading).offset(-40)
            
        }
//        rankingContainer.setContentHuggingPriority(.init(751), for: .horizontal)
        
        rankingNumberContainer.accessibilityLabel = "rankingNumberContainer"
        rankingNumberContainer.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        noLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.greaterThanOrEqualToSuperview()
        }
        
        rankingNumberLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(noLabel.snp.trailing).offset(-1)
            make.trailing.lessThanOrEqualToSuperview()
            make.bottom.equalToSuperview()
        }
        
        genreLabel.snp.makeConstraints { make in
            make.top.equalTo(rankingNumberContainer.snp.bottom).offset(5)
            make.leading.greaterThanOrEqualToSuperview()
            make.centerX.equalToSuperview()
            make.trailing.lessThanOrEqualToSuperview()
            make.bottom.equalToSuperview()
        }
        
        // MARK: - Advisory
        advisoryContainer.snp.makeConstraints { make in
//            make.width.equalTo(50).priority(.low)
//            make.top.equalTo(getButton.snp.bottom).offset(35)
//            make.trailing.equalToSuperview().offset(-SearchConstants.defaultTrailing)
        }
        
        advisoryLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        ageLabel.snp.makeConstraints { make in
            make.top.equalTo(advisoryLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        screenShotCollectionView.snp.makeConstraints { make in
            make.top.equalTo(horizontalAppDetailInfoStackView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(600)
        }
        
        availableDeviceContainer.snp.makeConstraints { make in
            make.top.equalTo(screenShotCollectionView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(SearchConstants.defaultLeading)
            make.trailing.equalToSuperview().offset(-SearchConstants.defaultTrailing)
            make.bottom.equalToSuperview()
        }
        
        availableDevicesStackView.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
            make.width.lessThanOrEqualToSuperview()
        }
    }
    
    private func setDelegate() {
        screenShotCollectionView.delegate = self
        screenShotCollectionView.dataSource = self
    }
    
    private var _searchResult: SearchResult?
    private var _firstScreenshotImage: UIImage?
    private var screenshotCellSize: CGSize = .zero
    private var screenshotCellSectionInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
    
    public var searchResult: SearchResult? {
        get { _searchResult }
        set {
            _searchResult = newValue
            
            guard let searchResult = newValue else { return }
            
            ImageDownloadManager.shared.downloadImage(searchResult.artworkUrl100, indexPath: nil) { (image, _, _, error) in
                DispatchQueue.main.async {
                    self.appIconImageView.image = image
                }
            }
            
            self.appTitleLabel.text = searchResult.trackName
            self.corpLabel.text = searchResult.sellerName
            
            self.ratingFloatLabel.text = String(format: "%.1f", searchResult.averageUserRating)
            if searchResult.averageUserRating == 0 {
                self.ratingFloatLabel.isHidden = true
            }
            
            self.cosmosView.rating = Double(searchResult.averageUserRating)
            self.ratingNumberLabel.text = "\(searchResult.formattedRatingCount != "0" ? searchResult.formattedRatingCount : "No") Ratings"
            
            self.genreLabel.text = searchResult.primaryGenreName
            
//            self.rankingLabel.text = searchResult.
            self.advisoryLabel.text = searchResult.contentAdvisoryRating
            
            self.availableDevicesStackView.addArrangedSubview(
                AvailableDeviceImageView(deviceImage: UIImage(systemName: "iphone"))
            )
            
            
            if let fisrtScreenshotUrl = searchResult.screenshotUrls.first {
                 ImageDownloadManager.shared.downloadImage(fisrtScreenshotUrl, indexPath: nil, handler: { image, _,  _, error in
                    guard let image = image else { return }
                    self._firstScreenshotImage = image
                    DispatchQueue.main.async {
                        self.determineCollectionViewSize(with: image)
                        self.determineScreenshotItemSize(with: image)
                        self.screenShotCollectionView.reloadData()
                    }
                })
            }
            
        }
    }
    
    private func determineScreenshotItemSize(with firstImage: UIImage) {
        guard let firstScreenshotImage = _firstScreenshotImage else { return }
        
        var itemSize: CGSize = .zero

        if firstScreenshotImage.size.width > firstScreenshotImage.size.height {
            let heightFactor: CGFloat = (DeviceType.iPhoneX || DeviceType.iPhoneXRMax) ? 0.24 : 0.3
            itemSize = CGSize(width: UIScreen.main.bounds.width * 0.90 - 1,
                              height: UIScreen.main.bounds.height * heightFactor - 1)
        } else {
            let heightFactor: CGFloat = (DeviceType.iPhoneX || DeviceType.iPhoneXRMax) ? 0.55 : 0.55
            let widthFactor: CGFloat = (DeviceType.iPhoneX || DeviceType.iPhoneXRMax) ? 0.7: 0.56
            itemSize = CGSize(width: UIScreen.main.bounds.width * widthFactor - 1,
                              height: UIScreen.main.bounds.height * heightFactor - 1)
        }
        
        screenshotCellSize = itemSize
    }
    
    private func determineCollectionViewSize(with firstImage: UIImage) {
        if firstImage.size.width > firstImage.size.height {
            let heightFactor: CGFloat = (DeviceType.iPhoneX || DeviceType.iPhoneXRMax) ? 0.24 : 0.3
            
            screenShotCollectionView.snp.updateConstraints { make in
                make.height.equalTo(UIScreen.main.bounds.height * heightFactor)
            }
        } else {
            let heightFactor: CGFloat = (DeviceType.iPhoneX || DeviceType.iPhoneXRMax) ? 0.55 : 0.55
            
            screenShotCollectionView.snp.updateConstraints { make in
                make.height.equalTo(UIScreen.main.bounds.height * heightFactor)
            }
        }
        
        screenShotCollectionView.setNeedsLayout()
        screenShotCollectionView.layoutIfNeeded()
    
        self.screenShotCollectionView.collectionViewLayout.invalidateLayout()
        
        UIView.animate(withDuration: 0.25) {
            self.screenShotCollectionView.alpha = 1
        }
    }
    
//    public var searchResult: Binder<SearchResult> {
//        return Binder(self) { appCommonInformationView, searchResult in
//            let _self = appCommonInformationView
//            ImageDownloadManager.shared.downloadImage(searchResult.artworkUrl100, indexPath: nil) { (image, _, _, error) in
//                _self.appIconImageView.image = image
//            }
//
//            _self.appTitleLabel.text = searchResult.trackName
//            _self.corpLabel.text = searchResult.sellerName
////            _self.inAppPurchaseLabel
//
//            _self.ratingFloatLabel.text = String(format: "%.1f", searchResult.averageUserRating)
//            _self.cosmosView.rating = Double(searchResult.averageUserRating)
//            _self.ratingNumberLabel.text = "\(searchResult.formattedRatingCount) Ratings"
//
//            _self.genreLabel.text = searchResult.primaryGenreName
//
////            _self.rankingLabel.text = searchResult.
//            _self.advisoryLabel.text = searchResult.contentAdvisoryRating
//
//
//        }
//    }
}


extension AppCommonInformationView: UICollectionViewDelegate {
    
}

extension AppCommonInformationView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return _searchResult?.screenshotUrls.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _searchResult?.screenshotUrls.isEmpty == false ? 1 : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppScreenshotCell.reuseIdentifier, for: indexPath) as? AppScreenshotCell,
            let screenshotUrl: String = _searchResult?.screenshotUrls[indexPath.section] else { fatalError("Couldn't instantiate AppScreenshotCell")}
        
        ImageDownloadManager.shared.downloadImage(screenshotUrl, indexPath: nil, handler: { image, _,  _, error in
            guard let image = image else { return }
            
            cell.screenshatImageView.fadeImage(image: image)
        })
        
        return cell
    }
}

extension AppCommonInformationView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return screenshotCellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return screenshotCellSectionInset
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let screenshotUrlsCount = _searchResult?.screenshotUrls.count else { return }
        let pageWidth = screenshotCellSize.width
        targetContentOffset.pointee = scrollView.contentOffset
        
        let targetIndexCGFloat: CGFloat =
            scrollView.contentOffset.x / (pageWidth + screenshotCellSectionInset.left + screenshotCellSectionInset.right)
    
        var factor: CGFloat = 0.5
        
        if velocity.x < 0 {
            factor = -factor
        }
        
        var index = Int( round(targetIndexCGFloat + factor))
        
        if index < 0 {
            index = 0
        } else {
            index = min(screenshotUrlsCount - 1, index)
        }
        
        let indexPath = IndexPath(row: 0, section: index)
        screenShotCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        
    }
}

extension AppCommonInformationView: SearchDetailViewDelegate {
    func didLayoutSubviews() {
    }
}
