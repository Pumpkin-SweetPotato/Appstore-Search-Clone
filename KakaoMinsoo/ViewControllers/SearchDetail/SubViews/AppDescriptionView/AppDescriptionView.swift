//
//  AppDescriptionView.swift
//  KakaoMinsoo
//
//  Created by ZES2017MBP on 2020/09/19.
//  Copyright © 2020 Minsoo. All rights reserved.
//

import UIKit
import ReactorKit

class AppDescriptionView: UIView, ReactorKit.View {
    let descriptionContainer = UIView()
    
    let gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradientLayer.startPoint = .init(x: 0.9, y: 0.5)
        gradientLayer.endPoint = .init(x: 1.0, y: 0.5)
        
        return gradientLayer
    }()
    
    let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.font = .systemFont(ofSize: 15, weight: .light)
        descriptionLabel.numberOfLines = 3
        descriptionLabel.lineBreakMode = .byWordWrapping
        
        return descriptionLabel
    }()
    
    let moreLabel: UILabel = {
        let moreLabel = UILabel()
        moreLabel.text = "more"
        moreLabel.font = .systemFont(ofSize: 15)
        moreLabel.textColor = .systemBlue
        moreLabel.isHidden = true
        moreLabel.textAlignment = .right
        
        return moreLabel
    }()
    
    let developerContainer = UIView()
    
    let sellarLabel: UILabel = {
        let sellarLabel = UILabel()
        sellarLabel.font = .systemFont(ofSize: 14)
        sellarLabel.textColor = .systemBlue
        
        return sellarLabel
    }()
    
    let developerLabel: UILabel = {
        let developerLabel = UILabel()
        developerLabel.font = .systemFont(ofSize: 12)
        developerLabel.textColor = .searchGray(alpha: 0.8)
        developerLabel.text = "Developer"
        
        return developerLabel
    }()
    
    let chevronRight: UIImageView = {
        let chevronRight = UIImageView()
        chevronRight.image = UIImage(systemName: "chevron.right")
        chevronRight.tintColor = .searchGray(alpha: 0.8)
        
        return chevronRight
    }()
    
    var disposeBag: DisposeBag = DisposeBag()
    
    func addViews() {
        addSubview(descriptionContainer)
        descriptionContainer.addSubview(descriptionLabel)
        descriptionContainer.addSubview(moreLabel)
        addSubview(developerContainer)
        developerContainer.addSubview(sellarLabel)
        developerContainer.addSubview(developerLabel)
        developerContainer.addSubview(chevronRight)
    }
    
    func setConstraints() {
        descriptionContainer.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(SearchConstants.defaultLeading)
            make.trailing.equalToSuperview().offset(-SearchConstants.defaultTrailing)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        moreLabel.snp.makeConstraints { make in
            make.trailing.equalTo(descriptionLabel)
            make.bottom.equalTo(descriptionLabel)
        }
        
        developerContainer.snp.makeConstraints { make in
            make.top.equalTo(descriptionContainer.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(SearchConstants.defaultLeading)
            make.trailing.equalToSuperview().offset(-SearchConstants.defaultTrailing)
            make.bottom.equalToSuperview().offset(-25)
        }
        
        sellarLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }
        
        developerLabel.snp.makeConstraints { make in
            make.top.equalTo(sellarLabel.snp.bottom).offset(3)
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        chevronRight.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(8)
            make.height.equalTo(16)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    var didMoreButtonPlaced: Bool = false
    
    func bind(reactor: AppDescriptionViewReactor) {
        let descriptionTapGestureRecognizer = UITapGestureRecognizer()
        descriptionContainer.addGestureRecognizer(descriptionTapGestureRecognizer)

        descriptionTapGestureRecognizer.rx.event
            .map { _ in Reactor.Action.moreButtonTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
//        descriptionLabel.rx.observe(String.self, "text")
//            .compactMap { $0 }
//            .filter { !$0.isEmpty }
//            .subscribe(onNext: { [weak self] _ in
//
//                if self?.descriptionLabel.isTruncated == true,
//                    let self = self {
//                    self.moreLabel.isHidden = false
//                    self.gradientLayer.frame = self.descriptionLabel.bounds
//                    self.descriptionLabel.layer.mask = self.gradientLayer
//                }
//            }).disposed(by: disposeBag)
        
        reactor.state.map { $0.descriptionText }
            .distinctUntilChanged()
            .map { $0.replacingOccurrences(of: "\n\n", with: "\n") }
            .bind(to: descriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isExpandDescription }
            .distinctUntilChanged()
            .filter { $0 }
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.descriptionLabel.numberOfLines = 0
                self?.descriptionLabel.text = reactor.currentState.descriptionText
                self?.moreLabel.isHidden = true
            }).disposed(by: disposeBag)
        
        reactor.state.map { $0.sellarName }
            .distinctUntilChanged()
            .bind(to: sellarLabel.rx.text)
            .disposed(by: disposeBag)
        
        let developerTapGestureRecognizer = UITapGestureRecognizer()
        developerContainer.addGestureRecognizer(developerTapGestureRecognizer)
        
        developerTapGestureRecognizer.rx.event
            .map { _ in Reactor.Action.developerButtonTappedd }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
//        reactor.state.map { $0.developerDetailViewController }
//        .compactMap
        
    }
    

}

extension AppDescriptionView: SearchDetailViewDelegate {
    func didLayoutSubviews() {
        if descriptionLabel.frame.size != .zero, !didMoreButtonPlaced, descriptionLabel.isTruncated {
            moreLabel.isHidden = false
            didMoreButtonPlaced = true
            // TODO
//            gradientLayer.frame.size = moreLabel.bounds.size
//            gradientLayer.frame.origin = moreLabel.frame.origin.applying(.init(scaleX: 0.9, y: 1))
//            descriptionLabel.layer.mask = gradientLayer
        }
    }
}
