//
//  SearchViewController.swift
//  KakaoMinsoo
//
//  Created by ZES2017MBP on 2020/09/16.
//  Copyright © 2020 Minsoo. All rights reserved.
//

import UIKit
import SnapKit
import ReactorKit
import RxCocoa

class SearchViewController: UIViewController, ReactorKit.StoryboardView {
    typealias SearchViewMode = SearchViewReactor.SearchViewMode
    @IBOutlet var rootView: UIView!
    
    let searchLabel: UILabel = {
        let searchLabel = UILabel()
        searchLabel.text = "검색"
        searchLabel.font = UIFont.systemFont(ofSize: 20)
        
        return searchLabel
    }()
    
    let stackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fill
        
        return stackView
    }()
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
//        searchBar.barTintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        searchBar.placeholder = "App Store"
        searchBar.setImage(UIImage(systemName: "magnifyingglass"), for: .search, state: .normal)
        
        
        return searchBar
    }()
    
    let latestSearchLabel: UILabel = {
        let latestSearchLabel = UILabel()
        latestSearchLabel.text = "최근 검색어"
        latestSearchLabel.font = UIFont.systemFont(ofSize: 20)
        
        return latestSearchLabel
    }()
    
    let latestSearchTableView: UITableView = {
        let latestSearchTableView: UITableView = UITableView()
        latestSearchTableView.separatorStyle = .none
        
        return latestSearchTableView
    }()
    
    let searchResultTableView: UITableView = {
        let searchResultTableView: UITableView = UITableView()
        searchResultTableView.separatorStyle = .none
        
        return searchResultTableView
    }()
    
    var disposeBag: DisposeBag = DisposeBag()

    fileprivate func addViews() {
        rootView.addSubview(stackView)
        stackView.addArrangedSubview(searchLabel)
        stackView.addArrangedSubview(searchBar)
        stackView.addArrangedSubview(latestSearchLabel)
        stackView.addArrangedSubview(latestSearchTableView)
        stackView.addArrangedSubview(searchResultTableView)
    }
    
    fileprivate func setConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-30)
        }
        
        searchLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
        }
        
        stackView.setCustomSpacing(5, after: searchLabel)
        
        searchBar.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
        }
        
        stackView.setCustomSpacing(30, after: searchBar)
        
        latestSearchLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
        }
        
        stackView.setCustomSpacing(3, after: latestSearchLabel)
        
        latestSearchTableView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
        }
        
        latestSearchTableView.setContentHuggingPriority(.defaultLow, for: .vertical)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true 
        
        addViews()
        
        setConstraints()
        setReactor()
        setDelegates()
    }
    
    func setReactor() {
        self.reactor = Reactor(apiClient: APIClient())
    }
    
    func setDelegates() {
//        searchBar.delegate = self
        latestSearchTableView.delegate = self
        latestSearchTableView.dataSource = self
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
    }

    func bind(reactor: SearchViewReactor) {
        searchBar.rx.text.orEmpty
            .distinctUntilChanged()
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .map { Reactor.Action.searchBarTextDidChanged($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        searchBar.rx.text
            .map { ($0 == nil || $0?.isEmpty == true) }
            .map { !$0 }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] isEmpty in
                self?.setIsHiddenCancelButton(isEmpty)
            }).disposed(by: disposeBag)
        
        searchBar.rx.cancelButtonClicked
            .do(onNext: { [weak self] in self?.searchBar.text = "" })
            .map { Reactor.Action.searchCancel }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.selectedSearchKeyword }
            .distinctUntilChanged()
            .bind(to: searchBar.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.searchViewMode }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] mode in
                print("searchViewMode", mode)
                self?.changeViewMode(mode)
            }).disposed(by: disposeBag)
        
    }
    
    func setIsHiddenCancelButton(_ isHidden: Bool) {
        UIView.animate(withDuration: 0.2) {
            self.searchBar.showsCancelButton = isHidden
        }
    }
    
    func changeViewMode(_ mode: SearchViewMode) {
        switch mode {
        case .watingInput:
            searchLabel.isHidden = false
            latestSearchLabel.isHidden = false
            latestSearchTableView.isHidden = false
            searchResultTableView.isHidden = true
        case .inputContinuing:
            searchLabel.isHidden = true
            latestSearchLabel.isHidden = true
        case .showingResult:
            searchLabel.isHidden = true
            latestSearchLabel.isHidden = true
            latestSearchTableView.isHidden = true
            searchResultTableView.isHidden = false
        }
        
        UIView.animate(withDuration: 0.5) {
            self.rootView.layoutIfNeeded()
        }
    }
}

