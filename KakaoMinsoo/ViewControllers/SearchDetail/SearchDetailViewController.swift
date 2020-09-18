//
//  SearchDetailViewController.swift
//  KakaoMinsoo
//
//  Created by ZES2017MBP on 2020/09/17.
//  Copyright © 2020 Minsoo. All rights reserved.
//

import UIKit
import ReactorKit
import Cosmos

class SearchDetailViewController: UIViewController, ReactorKit.StoryboardView {
    @IBOutlet var rootView: UIView!
    
    let appIconImageView: UIImageView = {
       let appIconImageView = UIImageView()
        
        return appIconImageView
    }()
    
    let appTitleLabel: UILabel = {
       let appTitleLabel = UILabel()
        
        return appTitleLabel
    }()
    
    let corpLabel: UILabel = {
       let corpLabel = UILabel()
        
        return corpLabel
    }()
    
    let getButton: UIButton = {
        let getButton = UIButton()
        
        return getButton
    }()
    
    let shareButton: UIButton = {
        let shareButton = UIButton()
        
        return shareButton
    }()
    
    let ratingContainer = UIView()
    
    let ratingFloatLabel: UILabel = {
        let ratingFloatLabel = UILabel()
        
        return ratingFloatLabel
    }()
    
    let cosmosView: CosmosView = {
        let cosmosView = CosmosView()
        cosmosView.settings.fillMode = .precise
        cosmosView.settings.disablePanGestures = true
        cosmosView.settings.updateOnTouch = false
        cosmosView.settings.starSize = 30
        cosmosView.settings.starMargin = 0
        cosmosView.settings.filledColor = UIColor.searchGray
        cosmosView.settings.emptyBorderColor = UIColor.searchGray
        cosmosView.settings.filledBorderColor = UIColor.searchGray
    
        return cosmosView
    }()
    
    let rankingContainer = UIView()
    
    let rankingLabel: UILabel = {
        let rankingLabel = UILabel()
        
        return rankingLabel
    }()
    
    let genreLabel: UILabel = {
       let genreLabel = UILabel()
        
        return genreLabel
    }()
    
    let advisoryContainer = UIView()
    
    let advisoryLabel: UILabel = {
       let advisoryLabel = UILabel()
        
        return advisoryLabel
    }()
    
    let ageLabel: UILabel = {
       let ageLabel = UILabel()
        
        return ageLabel
    }()
    
    let ratingNumberLabel: UILabel = {
       let ratingNumberLabel = UILabel()
        
        return ratingNumberLabel
    }()
    
    let screenShotCollectionView: UICollectionView = {
        let flowlayout = UICollectionViewFlowLayout()
        let screenShotCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
        
        return screenShotCollectionView
    }()
    
    let availableDeviceContainer = UIView()
    
    let availableDevicesStackView: UIStackView = {
        let availableDevicesStackView = UIStackView()
        availableDevicesStackView.axis = .horizontal
        availableDevicesStackView.alignment = .bottom
        availableDevicesStackView.distribution = .equalSpacing
        
        return availableDevicesStackView
    }()
    
    let availableDeviceDescriptionLabel: UILabel = {
       let availableDeviceDescriptionLabel = UILabel()
        
        return availableDeviceDescriptionLabel
    }()
    
    let separator: UIView = UIView()
    
    let descriptionLabel: UILabel = {
       let descriptionLabel = UILabel()
        
        return descriptionLabel
    }()

    
    var disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        // Do any additional setup after loading the view.
    }
    
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        
        if parent == nil {
            navigationController?.isNavigationBarHidden = true
        }
    }
    
    func bind(reactor: SearchDetailViewReactor) {
        
    }
}
