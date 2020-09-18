//
//  LatestSearchedKeywordCell.swift
//  KakaoMinsoo
//
//  Created by ZES2017MBP on 2020/09/18.
//  Copyright © 2020 Minsoo. All rights reserved.
//

import UIKit

class LatestSearchedKeywordCell: UITableViewCell {
    static let reuseIdentifier: String = String(describing: LatestSearchedKeywordCell.self)
    
    let searchIconImageView: UIImageView = {
       let searchIconImageView = UIImageView()
        searchIconImageView.image = UIImage(systemName: "magnifyingglass")
        searchIconImageView.tintColor = UIColor.searchGray
        
        return searchIconImageView
    }()
    
    let keywordLabel: UILabel = {
        let keywordLabel = UILabel()
        keywordLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)
        
        
        return keywordLabel
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        keywordLabel.text = ""
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        separatorInset = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 0)
        
        contentView.addSubview(searchIconImageView)
        contentView.addSubview(keywordLabel)
        
        searchIconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
        }
        
        keywordLabel.snp.makeConstraints { make in
            make.leading.equalTo(searchIconImageView.snp.trailing).offset(5)
            make.trailing.lessThanOrEqualToSuperview()
            make.centerY.equalToSuperview()
        }
        
   }
   
   required init?(coder: NSCoder) {
       return nil
   }
   
   override func setSelected(_ selected: Bool, animated: Bool) {
       super.setSelected(selected, animated: animated)

       // Configure the view for the selected state
   }

}
