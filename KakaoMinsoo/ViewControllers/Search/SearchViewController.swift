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
    @IBOutlet weak var rootView: UIView!
    
    let searchLabelContainer = UIView()
    
    let searchLabel: UILabel = {
        let searchLabel = UILabel()
        searchLabel.text = "검색"
        searchLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        return searchLabel
    }()
    
    let stackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.distribution = .fill
        
        return stackView
    }()
    
    let searchBarContainer = UIView()
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "App Store"
        searchBar.setImage(UIImage(systemName: "magnifyingglass"), for: .search, state: .normal)
        
        return searchBar
    }()
    
    let latestSearchLabelContainer = UIView()
    
    let latestSearchLabel: UILabel = {
        let latestSearchLabel = UILabel()
        latestSearchLabel.text = "최근 검색어"
        latestSearchLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        return latestSearchLabel
    }()
    
    let latestSearchTableView: UITableView = {
        let latestSearchTableView: UITableView = UITableView()
        latestSearchTableView.register(LatestSearchedKeywordCell.self,
                                       forCellReuseIdentifier: LatestSearchedKeywordCell.reuseIdentifier)
        
        return latestSearchTableView
    }()
    
    let searchResultTableContainer = UIView()
    
    let searchResultTableView: UITableView = {
        let searchResultTableView: UITableView = UITableView()
        searchResultTableView.register(SearchResultTableViewCell.self,
                                       forCellReuseIdentifier: SearchResultTableViewCell.reuseIdentifier)
        
        return searchResultTableView
    }()
    
    let initialStackViewTopOffset: CGFloat = 60
    
    var disposeBag: DisposeBag = DisposeBag()

    fileprivate func addViews() {
        rootView.addSubview(stackView)
        stackView.addArrangedSubview(searchLabelContainer)
        searchLabelContainer.addSubview(searchLabel)
        stackView.addArrangedSubview(searchBarContainer)
        searchBarContainer.addSubview(searchBar)
        stackView.addArrangedSubview(latestSearchLabelContainer)
        latestSearchLabelContainer.addSubview(latestSearchLabel)
        stackView.addArrangedSubview(latestSearchTableView)
        stackView.addArrangedSubview(searchResultTableContainer)
        searchResultTableContainer.addSubview(searchResultTableView)
    }
    
    fileprivate func setConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(initialStackViewTopOffset)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        searchLabelContainer.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
        }
        
        searchLabel.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
        }
        
        stackView.setCustomSpacing(5, after: searchLabel)
        
        searchBarContainer.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
        }
        
        searchBar.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        stackView.setCustomSpacing(50, after: searchBarContainer)
        
        latestSearchLabelContainer.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
        }
        
        latestSearchLabel.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
        }
        
        stackView.setCustomSpacing(3, after: latestSearchLabel)
        
        latestSearchTableView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
        }
        
        searchResultTableContainer.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.height.greaterThanOrEqualTo(1)
        }
        
        searchResultTableView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().offset(-15)
            make.leading.equalToSuperview().offset(15)
        }
        
        latestSearchTableView.setContentHuggingPriority(.defaultLow, for: .vertical)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        searchResultTableView.separatorStyle = .none
        
        addViews()
        setConstraints()
        setReactor()
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
        setDelegates()
        bindSearchBar(reactor: reactor)
        bindTableView(reactor: reactor)
        
        reactor.state.map { $0.searchViewMode }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] mode in
                self?.changeViewMode(mode)
            }).disposed(by: disposeBag)
        
        reactor.state.map { $0.searchDetailViewController }
            .compactMap { $0 }
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.pushViewController($0, animated: true)
            }).disposed(by: disposeBag)
    }
    
    func bindSearchBar(reactor: SearchViewReactor) {
        searchBar.rx.text.orEmpty
            .distinctUntilChanged()
            .map { Reactor.Action.searchBarTextDidChanged($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    
        searchBar.rx.textDidBeginEditing
            .map { Reactor.Action.searchBarSelected }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        searchBar.rx.cancelButtonClicked
            .do(onNext: { [weak self] in self?.searchBar.text = "" })
            .do(onNext: { [weak self] in self?.searchBar.endEditing(true) })
            .map { Reactor.Action.searchCancel }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        searchBar.rx.searchButtonClicked
            .map { Reactor.Action.searchBegin }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.selectedSearchKeyword }
            .distinctUntilChanged()
            .compactMap { $0 }
            .do(onNext: { [weak self] _ in self?.searchBar.endEditing(false) })
            .bind(to: searchBar.rx.text.orEmpty)
            .disposed(by: disposeBag)
    }
    
    func bindTableView(reactor: SearchViewReactor) {
        latestSearchTableView.rx.itemSelected
            .map { Reactor.Action.latestSearchKeywordSelected($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.latestSearchedKeywords }
            .distinctUntilChanged()
            .observeOn(MainScheduler.instance)
            .delay(.milliseconds(250), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.latestSearchTableView.reloadData()
            }).disposed(by: disposeBag)
        
        searchResultTableView.rx.itemSelected
            .do(onNext: { [weak self] in self?.searchResultTableView.deselectRow(at: $0, animated: false) })
            .map { Reactor.Action.searchResultSelected($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isNeedReload }
            .distinctUntilChanged()
            .filter { $0 }
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.searchResultTableView.reloadData()
            }).disposed(by: disposeBag)
    }
    
    func changeViewMode(_ mode: SearchViewMode) {
        DispatchQueue.main.async {
            self.setStatusBarPosition(mode)
            
            switch mode {
            case .watingInput:
                self.stackView.setCustomSpacing(50, after: self.searchBarContainer)
                
                self.searchLabelContainer.isHidden = false
                self.latestSearchLabelContainer.isHidden = false
                self.latestSearchTableView.isHidden = false
                self.searchResultTableContainer.isHidden = true
                
                
                self.searchBar.searchBarStyle = .minimal
                self.searchBar.showsCancelButton = false
            case .searchBarFocused:
                self.searchLabelContainer.isHidden = true
                self.latestSearchLabelContainer.isHidden = false
                self.searchBar.showsCancelButton = true
            case .beginEditing:
                self.latestSearchLabelContainer.isHidden = true
            case .inputContinuing:
                
                
                self.searchLabelContainer.isHidden = true
                self.searchBar.showsCancelButton = true
                self.latestSearchLabelContainer.isHidden = true
            case .showingResult:
                
                self.stackView.setCustomSpacing(0, after: self.searchBarContainer)
                self.searchBar.showsCancelButton = true
                
                
                self.searchLabelContainer.isHidden = true
                self.latestSearchLabelContainer.isHidden = true
                self.latestSearchTableView.isHidden = true
                self.searchResultTableContainer.isHidden = false
            }
        
        
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
                self.rootView.layoutIfNeeded()
            })
        }
    }
    
    func setStatusBarPosition(_ mode: SearchViewMode) {
        switch mode {
            case .watingInput:
                self.stackView.snp.updateConstraints { make in
                    make.top.equalToSuperview().offset(self.initialStackViewTopOffset)
                }
                
                self.searchBarContainer.backgroundColor = UIColor.white
                
                self.searchBar.snp.updateConstraints { make in
                    make.top.equalToSuperview().offset(0)
                }
            case .searchBarFocused, .beginEditing, .inputContinuing, .showingResult:
                let statusbarHeight = SearchConstants.statusBarHeight(rootView: self.rootView) ?? 0
                self.stackView.snp.updateConstraints { make in
                    make.top.equalToSuperview().offset(0)
                }
                
                self.searchBarContainer.backgroundColor = UIColor.searchGray(alpha: 0.05)
            
                self.searchBar.snp.updateConstraints { make in
                    make.top.equalToSuperview().offset(statusbarHeight)
                }
        }
    }
}

