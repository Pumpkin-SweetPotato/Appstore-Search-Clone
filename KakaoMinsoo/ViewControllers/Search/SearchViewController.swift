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
    @IBOutlet weak var searchLabelContainer: UIView!
    @IBOutlet weak var searchLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var searchBarContainer: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var latestSearchLabelContainer: UIView!
    @IBOutlet weak var latestSearchLabel: UILabel!
    @IBOutlet weak var latestSearchTableViewContainer: UIView!
    @IBOutlet weak var latestSearchTableView: UITableView!
    @IBOutlet weak var filteredLatestSearchTableView: UITableView!
    @IBOutlet weak var searchResultTableContainer: UIView!
    @IBOutlet weak var searchResultTableView: UITableView!
    
    let initialStackViewTopOffset: CGFloat = 60
    
    var disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        searchResultTableView.separatorStyle = .none
        setReactor()
    }
    
    func setReactor() {
        self.reactor = Reactor(apiClient: APIClient())
    }
    
    func setDelegates() {
//        searchBar.delegate = self
        latestSearchTableView.delegate = self
        latestSearchTableView.dataSource = self
        filteredLatestSearchTableView.delegate = self
        filteredLatestSearchTableView.dataSource = self
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
    }

    func bind(reactor: SearchViewReactor) {
        setDelegates()
        
        reactor.state.map { $0.searchViewMode }
            .distinctUntilChanged()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] mode in
                self?.setStatusBarPosition(mode)
            }).disposed(by: disposeBag)
        
        reactor.state.map { $0.searchDetailViewController }
            .compactMap { $0 }
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.pushViewController($0, animated: true)
            }).disposed(by: disposeBag)
        
        bindSearchBar(reactor: reactor)
        bindTableView(reactor: reactor)
        bindHiddenesses(reactor: reactor)
        bindViewConstraint(reactor: reactor)
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
            .bind(to: searchBar.rx.text)
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
        
        filteredLatestSearchTableView.rx.itemSelected
            .map { Reactor.Action.filteredLatestSearchKeywordSelected($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isNeedReloadFilteredKeywordTableView }
            .distinctUntilChanged()
            .filter { $0 }
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.filteredLatestSearchTableView.reloadData()
            }).disposed(by: disposeBag)
        
        searchResultTableView.rx.itemSelected
            .do(onNext: { [weak self] in self?.searchResultTableView.deselectRow(at: $0, animated: false) })
            .map { Reactor.Action.searchResultSelected($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        searchResultTableView.rx.contentOffset
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] contentOffset in
                guard let self = self else { return }
                if (self.searchResultTableView.contentOffset.y >= (self.searchResultTableView.contentSize.height - self.searchResultTableView.frame.size.height)) {
                    reactor.action.onNext(.loadMore)
                }
                
            }).disposed(by: disposeBag)
        
        reactor.state.map { $0.isNeedReload }
            .distinctUntilChanged()
            .filter { $0 }
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.searchResultTableView.contentOffset = .zero
                self?.searchResultTableView.reloadData()
                
            }).disposed(by: disposeBag)
        
        reactor.state.map { $0.addedIndexPaths }
            .distinctUntilChanged()
            .filter { !$0.isEmpty }
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] indexPaths in
                self?.searchResultTableView.performBatchUpdates({
                    self?.searchResultTableView.insertRows(at: indexPaths, with: .fade)
                }, completion: { _ in
                    self?.searchResultTableView.setNeedsLayout()
                    self?.searchResultTableView.layoutIfNeeded()
                })
            }).disposed(by: disposeBag)
        
    }
    
    func bindViewConstraint(reactor: SearchViewReactor) {
        reactor.state.map { $0.searchBarCustomSpacing }
            .distinctUntilChanged()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] offset in
                guard let searchBarContainer = self?.searchBarContainer else { return }
                self?.stackView.setCustomSpacing(offset, after: searchBarContainer)
            }).disposed(by: disposeBag)
    }
    
    func bindHiddenesses(reactor: SearchViewReactor) {
        reactor.state.map { $0.isHiddenLatestSearchLabelContainer }
            .distinctUntilChanged()
            .bind(to: latestSearchLabelContainer.rx.isHidden)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isHiddenSearchLabelContainer }
            .distinctUntilChanged()
            .bind(to: searchLabelContainer.rx.isHidden)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isHiddenLatestSearchTableView }
            .distinctUntilChanged()
            .bind(to: latestSearchTableView.rx.isHidden)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isHiddenFilteredLatestSearchTableView }
            .distinctUntilChanged()
            .bind(to: filteredLatestSearchTableView.rx.isHidden)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isHiddenLatestSearchLabelContainer }
            .distinctUntilChanged()
            .bind(to: latestSearchLabelContainer.rx.isHidden)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isHiddenSearchTableViewContainer }
            .distinctUntilChanged()
            .bind(to: searchResultTableContainer.rx.isHidden)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isShowCancelButtonOnSearchBar }
            .distinctUntilChanged()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] isShows in
                self?.searchBar.setShowsCancelButton(isShows, animated: true)
                
                if isShows, let cancelButton = self?.searchBar.value(forKey: "cancelButton") as? UIButton {
                    cancelButton.isEnabled = true
                }
            }).disposed(by: disposeBag)
        
        reactor.state.map { $0.isNeedsLayout }
            .distinctUntilChanged()
            .filter { $0 }
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
                    self?.stackView.layoutIfNeeded()
                })
            }).disposed(by: disposeBag)
    }
    
    func setStatusBarPosition(_ mode: SearchViewMode) {
        switch mode {
            case .initial:
                self.stackView.snp.updateConstraints { make in
                    make.top.equalToSuperview().offset(self.initialStackViewTopOffset)
                }
                
                self.searchBarContainer.backgroundColor = UIColor.white
                
                self.searchBar.snp.updateConstraints { make in
                    make.top.equalToSuperview().offset(0)
                }
            case .searchBarFocused, .inputContinuing, .showingResult:
                let statusbarHeight = SearchConstants.statusBarHeight(rootView: self.rootView) ?? 0
                self.stackView.snp.updateConstraints { make in
                    make.top.equalToSuperview().offset(statusbarHeight)
                }
                
                self.searchBarContainer.backgroundColor = UIColor.searchGray(alpha: 0.05)
            
                self.searchBar.snp.updateConstraints { make in
                    make.top.equalToSuperview().offset(statusbarHeight)
                }
        default:
            break;
        }
    }
}

