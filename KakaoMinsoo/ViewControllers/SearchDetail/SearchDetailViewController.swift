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
    
    let navigationItemContainer: UIView = {
        let navigationItemContainer = UIView()
        navigationItemContainer.alpha = 0
        
        return navigationItemContainer
    }()
    
    let navigationImageView: UIImageView = {
        let navigationImageView = UIImageView()
        navigationImageView.contentMode = .scaleAspectFit
        navigationImageView.layer.masksToBounds = true
        
        return navigationImageView
    }()
    
    let getButton: UIButton = {
        let getButton = UIButton()
        getButton.setTitle("GET", for: .normal)
        getButton.setTitleColor(.white, for: .normal)
        getButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        getButton.backgroundColor = .systemBlue
        
        return getButton
    }()
    
    let appCommonInformationView = AppCommonInformationView()
    let appDescriptionView = AppDescriptionView()
    let ratingReviewView = RatingReviewView()
    let whatsNewView = WhatsNewView()
    let appInformationView = InformationView()
    
    var disposeBag: DisposeBag = DisposeBag()
    
    var defaultNavigationBarShadowImage: UIImage!
    var defaultNavigationBarBackgroundImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        addSubViews()
        setConstraints()
        setNavigationBarItem()
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
        verticalStackView.addArrangedSubview(Separator(widthFactor: 0.9, height: 0.5))
        verticalStackView.addArrangedSubview(appInformationView)
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
//            let topOffset = (navigationController?.navigationBar.bounds.height ?? 0) + (SearchConstants.statusBarHeight(rootView: view) ?? 0)
            make.top.equalToSuperview()
//                .offset(topOffset)
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
        
        appInformationView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
        }
    }
    
    func setNavigationBarItem() {
        self.navigationItem.titleView = navigationItemContainer
        self.navigationItem.titleView?.addSubview(navigationImageView)
        self.navigationItem.titleView?.addSubview(getButton)

        
        navigationItemContainer.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        navigationImageView.snp.makeConstraints { make in
            make.width.height.equalTo(25)
            make.center.equalToSuperview()
        }
        
        navigationImageView.layer.cornerRadius = 3
        
        getButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(UIScreen.main.bounds.width / 2 - 8 - 30)
            make.height.equalTo(25)
            make.width.equalTo(60)
            make.centerY.equalToSuperview()
        }
        
        getButton.layer.cornerRadius = 25 / 2
    }
    
    func isHiddenNavigationBarItem(_ isHidden: Bool) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
                self.navigationItemContainer.alpha = isHidden ? 0 : 1
                self.appCommonInformationView.topContainer.alpha = isHidden ? 1 : 0
            }, completion: { _ in
                
            })
        }
    }
    
    func bind(reactor: SearchDetailViewReactor) {
        appCommonInformationView.searchResult = reactor.searchResult
        appDescriptionView.reactor = AppDescriptionViewReactor(searchResult: reactor.searchResult)
        ratingReviewView.reactor = RatingReviewViewReactor(searchResult: reactor.searchResult)
        whatsNewView.reactor = WhatsNewViewReactor(searchResult: reactor.searchResult)
        appInformationView.reactor = InformationViewReactor(searchResult: reactor.searchResult)
        
        reactor.state.map { $0.iconImage }
            .bind(to: navigationImageView.rx.image)
            .disposed(by: disposeBag)
        
        scrollView.rx.contentOffset
            .distinctUntilChanged()
            .filter { $0 != .zero }
            .subscribe(onNext: { [weak self] contentOffset in
                guard let self = self else { return }
                let converted = self.appCommonInformationView.convert(self.appCommonInformationView.getButton.frame, to: self.rootView)
                if contentOffset.y >= converted.minY - 44 {
                    self.isHiddenNavigationBarItem(false)
                } else {
                    self.isHiddenNavigationBarItem(true)
                }
            }).disposed(by: disposeBag)
    }
    
    
}


