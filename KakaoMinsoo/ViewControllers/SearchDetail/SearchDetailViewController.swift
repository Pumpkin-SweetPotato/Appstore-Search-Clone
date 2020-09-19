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

    let ratingReviewView = RatingReviewView()
//    let separator: UIView = UIView()
    
    let whatsNewView = WhatsNewView()
    
    
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
        verticalStackView.addArrangedSubview(Separator(widthFactor: 0.9, height: 0.5))
        verticalStackView.addArrangedSubview(appDescriptionView)
        verticalStackView.addArrangedSubview(Separator(widthFactor: 0.9, height: 0.5))
        verticalStackView.addArrangedSubview(ratingReviewView)
        verticalStackView.addArrangedSubview(Separator(widthFactor: 0.9, height: 0.5))
        verticalStackView.addArrangedSubview(whatsNewView)
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
            make.bottom.equalToSuperview().offset(-40)
        }
        
        appCommonInformationView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
        }
        
        appDescriptionView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
        }
        
        ratingReviewView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
        }
        
        whatsNewView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
        }
    }
    
    func bind(reactor: SearchDetailViewReactor) {
        appCommonInformationView.searchResult = reactor.searchResult
        appDescriptionView.reactor = AppDescriptionViewReactor(searchResult: reactor.searchResult)
        ratingReviewView.reactor = RatingReviewViewReactor(searchResult: reactor.searchResult)
        whatsNewView.reactor = WhatsNewViewReactor(searchResult: reactor.searchResult)
    }
}


