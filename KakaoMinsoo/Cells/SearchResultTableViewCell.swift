//
//  SearchResultTableViewCell.swift
//  KakaoMinsoo
//
//  Created by ZES2017MBP on 2020/09/17.
//  Copyright © 2020 Minsoo. All rights reserved.
//

import UIKit
import ReactorKit
import SnapKit
import Cosmos

class ThumbnailImageView: UIView {
    let horizonStackView: UIStackView = {
        let horizonStackView = UIStackView()
        horizonStackView.axis = .horizontal
        horizonStackView.distribution = .equalSpacing
        horizonStackView.alignment = .top
        
        return horizonStackView
    }()
    
    let leftThumbnailImageView: UIImageView = {
        let leftThumbnailImageView = UIImageView()
        leftThumbnailImageView.contentMode = .scaleAspectFit
        
        return leftThumbnailImageView
    }()
    
    let middleThumbnailImageView: UIImageView = {
        let middleThumbnailImageView = UIImageView()
        middleThumbnailImageView.contentMode = .scaleAspectFit
        
        return middleThumbnailImageView
    }()
    
    let rightThumbnailImageView: UIImageView = {
        let rightThumbnailImageView = UIImageView()
        rightThumbnailImageView.contentMode = .scaleAspectFit
        
        return rightThumbnailImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(horizonStackView)
        horizonStackView.addArrangedSubview(leftThumbnailImageView)
        horizonStackView.addArrangedSubview(middleThumbnailImageView)
        horizonStackView.addArrangedSubview(rightThumbnailImageView)
        
        setContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setContraints() {
        horizonStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        horizonStackView.arrangedSubviews.forEach {
            $0.snp.makeConstraints { make in
                make.width.equalToSuperview().multipliedBy(0.317)
                make.bottom.equalToSuperview()
            }
        }
        
        horizonStackView.arrangedSubviews.forEach {
            $0.layer.cornerRadius = 5
            $0.layer.masksToBounds = true
            $0.layer.borderColor = UIColor.lightGray.cgColor
            $0.layer.borderWidth = 0.5
        }
    }
    
//    func setImages(_ images: [UIImage?]) {
//        DispatchQueue.main.async {
//            for index in 0 ..< self.horizonStackView.arrangedSubviews.count {
//                guard let imageView = self.horizonStackView.arrangedSubviews[index] as? UIImageView else { continue }
//
//                imageView.image = images.count > index ? images[index] : nil
//            }
//        }
//    }
}

class SearchResultTableViewCell: UITableViewCell, ReactorKit.View {
    static let reuseIdentifier = String(describing: SearchResultTableViewCell.self)
    
    let iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        
        return iconImageView
    }()
    
    let resultInfoVerticalStackView: UIStackView = {
        let resultInfoVerticalStackView = UIStackView()
        resultInfoVerticalStackView.axis = .vertical
        resultInfoVerticalStackView.distribution = .fill
        resultInfoVerticalStackView.alignment = .leading
        
        return resultInfoVerticalStackView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.lineBreakMode = .byTruncatingTail
        
        return label
    }()
    
    let genreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        
        return label
    }()
    
    let ratingContainerView = UIView()
    
    let cosmosView: CosmosView = {
        let cosmosView = CosmosView()
        cosmosView.settings.fillMode = .precise
        cosmosView.settings.disablePanGestures = true
        cosmosView.settings.updateOnTouch = false
        cosmosView.settings.starSize = 14
        cosmosView.settings.starMargin = 0
        cosmosView.settings.filledColor = UIColor.searchGray
        cosmosView.settings.emptyBorderColor = UIColor.searchGray
        cosmosView.settings.filledBorderColor = UIColor.searchGray
    
        return cosmosView
    }()
    
    let ratingLabel: UILabel = {
        let ratingLabel = UILabel()
        ratingLabel.font = UIFont.systemFont(ofSize: 12)
        ratingLabel.textColor = UIColor.searchGray
        
        return ratingLabel
    }()
    
    let getButton: UIButton = {
        let getButton = UIButton(type: .system)
        
        getButton.setTitle("GET", for: .normal)
        getButton.backgroundColor = UIColor.searchGray(alpha: 0.1)
        
        return getButton
    }()
    
    let thumbnailImageView = ThumbnailImageView()
    
    var disposeBag: DisposeBag = DisposeBag()
    
    func addViews() {
        contentView.addSubview(iconImageView)
        
        contentView.addSubview(resultInfoVerticalStackView)
        resultInfoVerticalStackView.addArrangedSubview(titleLabel)
        resultInfoVerticalStackView.addArrangedSubview(genreLabel)
        resultInfoVerticalStackView.addArrangedSubview(ratingContainerView)
        ratingContainerView.addSubview(cosmosView)
        ratingContainerView.addSubview(ratingLabel)
        
        contentView.addSubview(getButton)
        
        contentView.addSubview(thumbnailImageView)
    }
    
    func setConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview()
            make.width.height.equalTo(60)
        }
        
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.cornerRadius = 10
        
        resultInfoVerticalStackView.snp.makeConstraints { make in
            make.top.equalTo(iconImageView)
            make.leading.equalTo(iconImageView.snp.trailing).offset(6)
        }
        
        resultInfoVerticalStackView.setCustomSpacing(4, after: titleLabel)
        resultInfoVerticalStackView.setCustomSpacing(4, after: genreLabel)
        
        ratingContainerView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
        }
        
        cosmosView.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.leading.equalTo(cosmosView.snp.trailing).offset(5)
            make.trailing.lessThanOrEqualToSuperview()
            make.top.equalTo(cosmosView)
        }
        
        let getButtonHeight: CGFloat = 25
        
        getButton.snp.makeConstraints { make in
            make.centerY.equalTo(iconImageView)
            make.leading.equalTo(resultInfoVerticalStackView.snp.trailing).offset(35)
            make.width.equalTo(60)
            make.height.equalTo(getButtonHeight)
            make.trailing.equalToSuperview()
        }
        
        getButton.layer.cornerRadius = getButtonHeight / 2
        
        thumbnailImageView.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(25)
            make.height.equalTo(190)
            make.leading.trailing.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview().offset(-15)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        addViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func bind(reactor: SearchResultTableCellReator) {
        reactor.state.map { $0.appIconImage }
            .bind(to: iconImageView.rx.fadeImage())
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.appNameString }
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.subtitleString }
            .bind(to: genreLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.ratingFloat }
            .subscribe(onNext: { [weak self] in
                self?.cosmosView.rating = Double($0)
            }).disposed(by: disposeBag)
        
        reactor.state.map { $0.ratingCountString }
            .bind(to: ratingLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.leftThumbnailImage }
            .bind(to: thumbnailImageView.leftThumbnailImageView.rx.fadeImage())
            .disposed(by: disposeBag)

        reactor.state.map { $0.middleThumbnailImage }
            .bind(to: thumbnailImageView.middleThumbnailImageView.rx.fadeImage())
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.rightThumbnailImage }
            .bind(to: thumbnailImageView.rightThumbnailImageView.rx.fadeImage())
            .disposed(by: disposeBag)
    }
}
