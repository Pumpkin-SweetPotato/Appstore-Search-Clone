//
//  DetailInformationTableViewCell.swift
//  KakaoMinsoo
//
//  Created by ZES2017MBP on 2020/09/20.
//  Copyright © 2020 Minsoo. All rights reserved.
//

import Foundation
import ReactorKit

class DetailInformationTableViewCell: UITableViewCell, ReactorKit.View {
    static let reuseIdentifier: String = String(describing: DetailInformationTableViewCell.self)
    
    let horizontalStackView: UIStackView = {
        let horizontalStackView = UIStackView()
        horizontalStackView.alignment = .center
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fill
        
        return horizontalStackView
    }()
    
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
        shortInfoLabel.textColor = .systemBlue
        
        return shortInfoLabel
    }()
    
    let showDetailButton: UIImageView = {
        let showDetailButton = UIImageView()
        showDetailButton.contentMode = .scaleAspectFit
        
        return showDetailButton
    }()
    
    let detailLabel: UILabel = {
        let detailLabel = UILabel()
        detailLabel.font = .systemFont(ofSize: 14)
        
        return detailLabel
    }()
    
    var disposeBag: DisposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        contentView.addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(catogoryLabel)
        horizontalStackView.addArrangedSubview(shortInfoLabel)
        horizontalStackView.addArrangedSubview(showDetailButton)
        contentView.addSubview(detailLabel)
        
        horizontalStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.trailing.equalToSuperview()
        }
        
        catogoryLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        showDetailButton.setContentHuggingPriority(.init(rawValue: 752), for: .horizontal)
        shortInfoLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        horizontalStackView.setCustomSpacing(8, after: shortInfoLabel)
        
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(horizontalStackView.snp.bottom).offset(2)
            make.leading.equalToSuperview().offset(SearchConstants.defaultLeading)
            make.trailing.equalToSuperview().offset(-SearchConstants.defaultTrailing)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
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
        
//        catogoryLabel.rx.observe(Bool.self, "isTruncated")
//            .subscribe(onNext: { print("\($0)")})
//            .disposed(by: disposeBag)
    }
}
