//
//  SearchDetailViewController.swift
//  KakaoMinsoo
//
//  Created by ZES2017MBP on 2020/09/17.
//  Copyright © 2020 Minsoo. All rights reserved.
//

import UIKit
import ReactorKit
import RxCocoa
import Cosmos

class SearchDetailViewController: UIViewController, ReactorKit.StoryboardView {
    @IBOutlet weak var rootView: UIView!
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        return scrollView
    }()
    
    let srollContentView = UIView()
    
    let verticalStackView: UIStackView = {
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .leading
        verticalStackView.distribution = .fill
        verticalStackView.spacing = 20
        
        return verticalStackView
    }()
    
    let appCommonInformationView = AppCommonInformationView()
    
//    let separator: UIView = UIView()
    
    let appDescriptionView = AppDescriptionView()

//    let separator: UIView = UIView()

    let ratingsReviewsLabel: UILabel = {
        let ratingsReviewsLabel = UILabel()

        return ratingsReviewsLabel
    }()

    let seeAllButton: UIButton = {
        let seeAllButton = UIButton()

        return seeAllButton
    }()

    let bigRatingFloatContainer = UIView()

    let bigRatingFloatLabel: UILabel = {
        let bigRatingFloatLabel = UILabel()
        
        return bigRatingFloatLabel
    }()

    let outOf5Label: UILabel = {
        let outOf5Label = UILabel()

        return outOf5Label
    }()

    let ratingsOf5Stars: UIView = {
        let ratingsOf5Stars = UIView()

        return ratingsOf5Stars
    }()
    
    let ratingsOf4Stars: UIView = {
        let ratingsOf4Stars = UIView()

        return ratingsOf4Stars
    }()

    let ratingsOf3Stars: UIView = {
        let ratingsOf3Stars = UIView()

        return ratingsOf3Stars
    }()

    let ratingsOf2Stars: UIView = {
        let ratingsOf2Stars = UIView()

        return ratingsOf2Stars
    }()

    let ratingsOf1Stars: UIView = {
        let ratingsOf1Stars = UIView()

        return ratingsOf1Stars
    }()

    let reviewContainer: UIView = {
        let reviewContainer = UIView()
        
        let reviewCollectionView: UICollectionView = {
            let flowLayout = UICollectionViewLayout()
            let reviewCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
            
            return reviewCollectionView
        }()
        // cell
        let conclusionLabel: UILabel = {
            let conclusionLabel = UILabel()
            
            return conclusionLabel
        }()
        
        let reviewRatingCosmos: CosmosView = {
            let reviewRatingCosmos = CosmosView()
            reviewRatingCosmos.settings.fillMode = .precise
            reviewRatingCosmos.settings.disablePanGestures = true
            reviewRatingCosmos.settings.updateOnTouch = false
            reviewRatingCosmos.settings.starSize = 30
            reviewRatingCosmos.settings.starMargin = 0
            reviewRatingCosmos.settings.filledColor = UIColor.yellow
            reviewRatingCosmos.settings.emptyBorderColor = UIColor.yellow
            reviewRatingCosmos.settings.filledBorderColor = UIColor.yellow
        
            return reviewRatingCosmos
        }()
        
        let reviewedDateLabel: UILabel = {
            let reviewedDateLabel = UILabel()
            
            return reviewedDateLabel
        }()
        
        let reviewerNameLabel: UILabel = {
            let reviewerNanemLabel = UILabel()
            
            return reviewerNanemLabel
        }()
        
        let moreButton: UIButton = {
           let moreButton = UIButton()
            
            return moreButton
        }()
        //
        return reviewContainer
    }()
    
//    let separator: UIView = UIView()
    
    let whatsNewLabel: UILabel = {
        let whatsNewLabel = UILabel()
        
        return whatsNewLabel
    }()
    
    let versionHistoryButton: UIButton = {
       let versionHistoryButton = UIButton()
        
        return versionHistoryButton
    }()
    
    let versionLabel: UILabel = {
       let versionLabel = UILabel()
        
        return versionLabel
    }()
    
    let versionUpdatedAgoLabel: UILabel = {
        let versionUpdatedAgoLabel = UILabel()
        
        return versionUpdatedAgoLabel
    }()
    
    let versionUpdateDescriptionLabel: UILabel = {
       let versionUpadteDescriptionLabel = UILabel()
        
        return versionUpadteDescriptionLabel
    }()
    
//    let separator = UIView()
    
    let informationContainer: UIView = {
        let informationContainer = UIView()
        
//        let informationView = InformationView()
//
//        addInformation(isHasDetail)
//
//        let developerWebsiteInformation
//        let privacyPolicyInformation
        
        return informationContainer
    }()
    
    let informationLabel: UILabel = {
        let informationLabel = UILabel()
        
        return informationLabel
    }()
    
//    let separator = UIView()
    
    let supportsContainer: UIView = {
        let supportsContainer = UIView()
//
//        let suppertView = SupportView()
//
//        addSupportView
        
        
        return supportsContainer
    }()
    
    let appSuggestionContainer: UIView = {
       let appSugestionContainer = UIView()
        
        
        
        return appSugestionContainer
    }()
    
    
    var disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        
        addSubViews()
        setConstraints()
    }
    
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        
        if parent == nil {
            navigationController?.isNavigationBarHidden = true
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        verticalStackView
            .arrangedSubviews
            .compactMap { $0 as? SearchDetailViewDelegate }
            .forEach { $0.didLayoutSubviews() }
    }
    
    func addSubViews() {
        rootView.addSubview(scrollView)
        scrollView.addSubview(srollContentView)
        srollContentView.addSubview(verticalStackView)
        
        verticalStackView.addArrangedSubview(appCommonInformationView)
        verticalStackView.addArrangedSubview(Separator())
        verticalStackView.addArrangedSubview(appDescriptionView)
    }
    
    func setConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        srollContentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().priority(.low)
        }
        
        verticalStackView.snp.makeConstraints { make in
            let topOffset = (navigationController?.navigationBar.bounds.height ?? 0) + (SearchConstants.statusBarHeight(rootView: view) ?? 0)
            make.top.equalToSuperview().offset(topOffset)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        appCommonInformationView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
        }
        
        appDescriptionView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
        }
    }
    
    func bind(reactor: SearchDetailViewReactor) {
        appCommonInformationView.searchResult = reactor.searchResult
        appDescriptionView.reactor = AppDescriptionViewReactor(searchResult: reactor.searchResult)
    }
}


