//
//  WhatsNewView.swift
//  KakaoMinsoo
//
//  Created by ZES2017MBP on 2020/09/20.
//  Copyright © 2020 Minsoo. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift

class WhatsNewView: UIView, ReactorKit.View {
    let topContainer = UIView()
    
    let whatsNewLabel: UILabel = {
        let whatsNewLabel = UILabel()
        whatsNewLabel.font = .systemFont(ofSize: 20, weight: .bold)
        whatsNewLabel.text = "What's New"
        
        return whatsNewLabel
    }()
    
    let versionHistoryButton: UIButton = {
        let versionHistoryButton = UIButton(type: .system)
        versionHistoryButton.setTitle("Version History", for: .normal)
        versionHistoryButton.tintColor = .systemBlue
        versionHistoryButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .light)
        
        return versionHistoryButton
    }()
    
    let latestVersionLabel: UILabel = {
        let latestVersionLabel = UILabel()
        latestVersionLabel.font = .systemFont(ofSize: 12, weight: .light)
        latestVersionLabel.textColor = .searchGray(alpha: 0.8)
        
        return latestVersionLabel
    }()
    
    let latestVersionReleasedDateLabel: UILabel = {
        let latestVersionReleasedDateLabel = UILabel()
        latestVersionReleasedDateLabel.font = .systemFont(ofSize: 12)
        latestVersionReleasedDateLabel.textColor = .searchGray(alpha: 0.8)
        
        return latestVersionReleasedDateLabel
    }()
    
    let versionReleaseNoteContainer = UIView()
    
    let versionReleaseNoteLabel: UILabel = {
        let versionReleaseNoteLabel = UILabel()
        versionReleaseNoteLabel.font = .systemFont(ofSize: 12)
        versionReleaseNoteLabel.numberOfLines = 3
        
        return versionReleaseNoteLabel
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
    
    var disposeBag: DisposeBag = DisposeBag()
    
    func configureViews() {
        addSubview(topContainer)
        topContainer.addSubview(whatsNewLabel)
        topContainer.addSubview(versionHistoryButton)
        topContainer.addSubview(latestVersionLabel)
        topContainer.addSubview(latestVersionReleasedDateLabel)
        
        addSubview(versionReleaseNoteContainer)
        versionReleaseNoteContainer.addSubview(versionReleaseNoteLabel)
        versionReleaseNoteContainer.addSubview(moreLabel)
    }

    func setConstraits() {
        topContainer.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(SearchConstants.defaultLeading)
            make.trailing.equalToSuperview().offset(-SearchConstants.defaultTrailing)
        }
        
        whatsNewLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }
        
        versionHistoryButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
        }
        
        latestVersionLabel.snp.makeConstraints { make in
            make.top.equalTo(whatsNewLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        latestVersionReleasedDateLabel.snp.makeConstraints { make in
            make.top.equalTo(whatsNewLabel.snp.bottom).offset(8)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        versionReleaseNoteContainer.snp.makeConstraints { make in
            make.top.equalTo(topContainer.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(SearchConstants.defaultLeading)
            make.trailing.equalToSuperview().offset(-SearchConstants.defaultTrailing)
            make.bottom.equalToSuperview()
        }
        
        versionReleaseNoteLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        moreLabel.snp.makeConstraints { make in
            make.trailing.equalTo(versionReleaseNoteLabel)
            make.bottom.equalTo(versionReleaseNoteLabel)
        }
    }
    
    var didMoreButtonPlaced: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureViews()
        setConstraits()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    func bind(reactor: WhatsNewViewReactor) {
        let releaseNoteTapGestureRecognizer = UITapGestureRecognizer()
        versionReleaseNoteContainer.addGestureRecognizer(releaseNoteTapGestureRecognizer)

        releaseNoteTapGestureRecognizer.rx.event
            .map { _ in Reactor.Action.moreButtonTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.version }
            .distinctUntilChanged()
            .bind(to: latestVersionLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.releasedDateString }
            .distinctUntilChanged()
            .bind(to: latestVersionReleasedDateLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.releaseNote }
            .compactMap { $0 }
            .distinctUntilChanged()
            .map { $0.replacingOccurrences(of: "\n\n", with: "\n") }
            .bind(to: versionReleaseNoteLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isExpandWhatsNew }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] _ in
                self?.versionReleaseNoteLabel.numberOfLines = 0
            }).disposed(by: disposeBag)
        
        reactor.state.map { $0.isExpandWhatsNew }
            .distinctUntilChanged()
            .filter { $0 }
            .subscribe(onNext: { [weak self] _ in
                self?.versionReleaseNoteLabel.numberOfLines = 0
            }).disposed(by: disposeBag)
    }
}

extension WhatsNewView: SearchDetailViewDelegate {
    func didLayoutSubviews() {
        if versionReleaseNoteLabel.frame.size != .zero, !didMoreButtonPlaced, versionReleaseNoteLabel.isTruncated {
            moreLabel.isHidden = false
            didMoreButtonPlaced = true
            // TODO
//            gradientLayer.frame.size = moreLabel.bounds.size
//            gradientLayer.frame.origin = moreLabel.frame.origin.applying(.init(scaleX: 0.9, y: 1))
//            descriptionLabel.layer.mask = gradientLayer
        }
    }
}
