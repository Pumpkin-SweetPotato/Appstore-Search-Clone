//
//  InformationView.swift
//  KakaoMinsoo
//
//  Created by ZES2017MBP on 2020/09/20.
//  Copyright © 2020 Minsoo. All rights reserved.
//

import UIKit
import ReactorKit

class InformationView: UIView, ReactorKit.View {
    let informationLabel: UILabel = {
        let informationLabel = UILabel()
        informationLabel.text = "Information"
        informationLabel.font = .systemFont(ofSize: 24, weight: .bold)
        
        return informationLabel
    }()
    
    let informationContainerView = UIView()
    
    let informationTableView: UITableView = {
        let informationTableView = UITableView()
        informationTableView.register(DefaultInformationTableViewCell.self,
                                      forCellReuseIdentifier: DefaultInformationTableViewCell.reuseIdentifier)
        informationTableView.register(AgeInformationTableViewCell.self,
                                      forCellReuseIdentifier: AgeInformationTableViewCell.reuseIdentifier)
        informationTableView.register(DetailInformationTableViewCell.self,
                                      forCellReuseIdentifier: DetailInformationTableViewCell.reuseIdentifier)
        
//        informationTableView.rowHeight = UITableView.automaticDimension
        informationTableView.estimatedRowHeight = 40
        informationTableView.separatorInset = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 0)
        
        return informationTableView
    }()
    
    var disposeBag: DisposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(informationLabel)
        addSubview(informationContainerView)
        informationContainerView.addSubview(informationTableView)
        
        informationLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(SearchConstants.defaultLeading)
        }
        
        informationContainerView.snp.makeConstraints { make in
            make.top.equalTo(informationLabel.snp.bottom).offset(15)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        informationContainerView.setContentHuggingPriority(.defaultLow, for: .vertical)
        
        informationTableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(SearchConstants.defaultLeading)
            make.trailing.equalToSuperview().offset(-SearchConstants.defaultTrailing)
            
            make.height.greaterThanOrEqualTo(1)
            make.bottom.equalToSuperview()
        }
    }
    
    var didExpandTableView: Bool = false
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    func bind(reactor: InformationViewReactor) {
//        informationTableView.delegate = self
        informationTableView.dataSource = self
        
        reactor.state.map { $0.information }
            .map { $0.count }
            .distinctUntilChanged()
            .map { $0 == 0 }
            .bind(to: informationTableView.rx.isHidden)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.needReload }
            .filter { $0 }
            .distinctUntilChanged()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.informationTableView.reloadData()
            }).disposed(by: disposeBag)
        
        informationTableView.rx.itemSelected
            .compactMap { [weak self] in self?.informationTableView.cellForRow(at: $0) }
            .compactMap { $0 as? ExpandableCell }
            .subscribe(onNext: { [weak self] cell in
                
                cell.expand(completion: { success in
                    guard success else { return }
                    self?.informationTableView.performBatchUpdates(nil, completion: { _ in
                        self?.didLayoutSubviews()
                    })
                })
                
                
            }).disposed(by: disposeBag)
        
        
    }
}


extension InformationView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reactor?.currentState.information.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = reactor?.currentState.information[indexPath.row] else { fatalError() }
        
        switch item {
        case .default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DefaultInformationTableViewCell.reuseIdentifier,
                                                           for: indexPath) as? DefaultInformationTableViewCell else { fatalError() }
            
            cell.reactor = InformationTableViewCellReactor(appInformationItem: item)
            
            return cell
        case .age:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AgeInformationTableViewCell.reuseIdentifier,
                                                           for: indexPath) as? AgeInformationTableViewCell else { fatalError() }
            
            cell.reactor = InformationTableViewCellReactor(appInformationItem: item)
            return cell
        case .developerWebsite:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailInformationTableViewCell.reuseIdentifier,
                                                           for: indexPath) as? DetailInformationTableViewCell else { fatalError() }
            cell.reactor = InformationTableViewCellReactor(appInformationItem: item)
            return cell
        case .privacyPolicy:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailInformationTableViewCell.reuseIdentifier,
                                                           for: indexPath) as? DetailInformationTableViewCell else { fatalError() }
            
            cell.reactor = InformationTableViewCellReactor(appInformationItem: item)
            return cell
            
        }
    }
    
    
}

extension InformationView: SearchDetailViewDelegate {
    func didLayoutSubviews() {
        if (informationTableView.contentSize != .zero && !didExpandTableView) ||
            informationTableView.bounds.size != informationTableView.contentSize {
            didExpandTableView = true
            
            informationTableView.snp.updateConstraints { make in
                make.height.greaterThanOrEqualTo(informationTableView.contentSize.height)
            }
        }
    }
}
