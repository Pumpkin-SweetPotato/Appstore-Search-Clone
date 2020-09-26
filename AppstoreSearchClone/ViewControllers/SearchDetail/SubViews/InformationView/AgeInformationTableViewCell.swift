//
//  AgeInformationTableViewCell.swift
//  KakaoMinsoo
//
//  Created by ZES2017MBP on 2020/09/20.
//  Copyright © 2020 Minsoo. All rights reserved.
//

import UIKit
import ReactorKit

class AgeInformationTableViewCell: UITableViewCell, ReactorKit.View {
    static let reuseIdentifier: String = String(describing: AgeInformationTableViewCell.self)
    
    let verticalStackView: UIStackView = {
        let verticalStackView = UIStackView()
        verticalStackView.alignment = .leading
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .fill
        
        return verticalStackView
    }()
    
    let shortInfoContainer: UIView = UIView()
    
    let catogoryLabel: UILabel = {
        let caterotyLabel = UILabel()
        caterotyLabel.font = .systemFont(ofSize: 14)
        caterotyLabel.textColor = .searchGray(alpha: 0.8)
        
        return caterotyLabel
    }()
    
    let shortInfoLabel: UILabel = {
        let shortInfoLabel = UILabel()
        shortInfoLabel.font = .systemFont(ofSize: 14)
        shortInfoLabel.textAlignment = .right
        
        return shortInfoLabel
    }()
    
    let showDetailButton: UIImageView = {
        let showDetailButton = UIImageView()
        showDetailButton.contentMode = .scaleAspectFit
        showDetailButton.isHidden = true
        showDetailButton.tintColor = .searchGray
        
        return showDetailButton
    }()
    
    let detailLabel: UILabel = {
        let detailLabel = UILabel()
        detailLabel.font = .systemFont(ofSize: 14)
        detailLabel.isHidden = true
        detailLabel.numberOfLines = 0
        
        return detailLabel
    }()
    
    let learnMoreLabel: UILabel = {
        let learnMoreLabel = UILabel()
        learnMoreLabel.font = .systemFont(ofSize: 14)
        learnMoreLabel.textColor = UIColor.systemBlue
        learnMoreLabel.text = "Learn More"
        learnMoreLabel.isHidden = true
        
        return learnMoreLabel
    }()
    
    var disposeBag: DisposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(shortInfoContainer)
        shortInfoContainer.addSubview(catogoryLabel)
        shortInfoContainer.addSubview(shortInfoLabel)
        shortInfoContainer.addSubview(showDetailButton)
        verticalStackView.addArrangedSubview(detailLabel)
        verticalStackView.addArrangedSubview(learnMoreLabel)
        
        verticalStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
        
        shortInfoContainer.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
        }
        
        catogoryLabel.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
        }
        
        shortInfoLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(catogoryLabel.snp.trailing)
        }
        
        showDetailButton.snp.makeConstraints { make in
            make.leading.equalTo(shortInfoLabel.snp.trailing)
            make.trailing.equalToSuperview()
        }
        
        catogoryLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        showDetailButton.setContentHuggingPriority(.init(rawValue: 752), for: .horizontal)
        shortInfoLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        verticalStackView.setCustomSpacing(10, after: shortInfoContainer)
        verticalStackView.setCustomSpacing(10, after: detailLabel)
        
        detailLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
        }
    }
    
    var isExpanded: Bool = false
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func bind(reactor: InformationTableViewCellReactor) {
        reactor.state.map { $0.categoryString }
            .bind(to: catogoryLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.infoString }
            .bind(to: shortInfoLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.detailButtonImage }
            .bind(to: showDetailButton.rx.image)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isHiddenDetailButton }
            .bind(to: showDetailButton.rx.isHidden)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.detailString }
            .bind(to: detailLabel.rx.text)
            .disposed(by: disposeBag)
    }
}

extension AgeInformationTableViewCell: ExpandableCell {
    func expand(completion: @escaping((Bool) -> Void)) {
        guard !isExpanded else { completion(false); return }
        isExpanded = true
        DispatchQueue.main.async {
            self.detailLabel.isHidden = false
            self.detailLabel.alpha = 0

            UIView.animate(withDuration: 0.20, animations: {
                self.shortInfoLabel.alpha = 0
                self.detailLabel.alpha = 1
                self.showDetailButton.alpha = 0
                self.detailLabel.isHidden = false
                self.learnMoreLabel.isHidden = false
            }) { _ in
                completion(true)
            }
        }
    }
}

