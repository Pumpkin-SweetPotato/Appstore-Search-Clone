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
        horizonStackView.arrangedSubviews.forEach {
            $0.snp.makeConstraints { make in
                make.width.equalToSuperview().multipliedBy(0.317)
                make.bottom.equalToSuperview()
            }
        }
    }
    
    func setImages(_ images: [UIImage]) {
        for index in 0 ..< horizonStackView.arrangedSubviews.count {
            guard let imageView = horizonStackView.arrangedSubviews[index] as? UIImageView else { continue }
            
            imageView.image = images.count > index ? images[index] : nil
        }
    }
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
        resultInfoVerticalStackView.distribution = .equalSpacing
        resultInfoVerticalStackView.alignment = .leading
        
        return resultInfoVerticalStackView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let genreLabel: UILabel = {
        let label = UILabel()
            
        return label
    }()
    
    let ratingContainerView = UIView()
    
    let cosmosView: CosmosView = {
        let cosmosView = CosmosView()
        cosmosView.settings.fillMode = .precise
        cosmosView.settings.disablePanGestures = true
        cosmosView.settings.updateOnTouch = false
        cosmosView.settings.starSize = 10
        cosmosView.settings.starMargin = 2
        cosmosView.settings.filledColor = UIColor(red: 142, green: 142, blue: 142, alpha: 1.0)
        cosmosView.settings.emptyBorderColor = UIColor(red: 142, green: 142, blue: 142, alpha: 1.0)
        cosmosView.settings.filledBorderColor = UIColor(red: 142, green: 142, blue: 142, alpha: 1.0)
    
        return cosmosView
    }()
    
    let ratingLabel: UILabel = {
        let ratingLabel = UILabel()
        
        ratingLabel.textColor = UIColor.lightGray
        
        return ratingLabel
    }()
    
    let getButton: UIButton = {
        let getButton = UIButton(type: .system)
        
        getButton.setTitle("GET", for: .normal)
        getButton.backgroundColor = UIColor.lightGray
        
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
            make.left.top.equalToSuperview()
            make.width.height.equalTo(50)
        }
        
        resultInfoVerticalStackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(iconImageView.snp.trailing).offset(6)
            make.bottom.equalTo(iconImageView)
        }
        
        ratingContainerView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
        }
        
        cosmosView.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.leading.equalTo(cosmosView.snp.trailing).offset(5)
            make.trailing.lessThanOrEqualToSuperview()
            make.bottom.equalTo(cosmosView)
        }
        
        getButton.snp.makeConstraints { make in
            make.centerY.equalTo(iconImageView)
            make.leading.equalTo(resultInfoVerticalStackView.snp.trailing).offset(6)
            make.trailing.lessThanOrEqualToSuperview()
        }
        
        thumbnailImageView.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(25)
            make.height.equalTo(190)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
            .bind(to: iconImageView.rx.image)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.appNameString }
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.subtitleString }
            .bind(to: genreLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.recommendsNumber }
            .map { "\($0)" }
            .bind(to: ratingLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.thumbnailImages }
            .subscribe(onNext: { [weak self] images in
                self?.thumbnailImageView.setImages(images)
            }).disposed(by: disposeBag)
    }
}
