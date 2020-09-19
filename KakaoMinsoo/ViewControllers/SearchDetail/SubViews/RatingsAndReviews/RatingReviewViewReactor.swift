//
//  RatingReviewViewReactor.swift
//  KakaoMinsoo
//
//  Created by ZES2017MBP on 2020/09/19.
//  Copyright © 2020 Minsoo. All rights reserved.
//

import Foundation
import ReactorKit

final class RatingReviewViewReactor: Reactor {
    enum Action {
        case seeAllButtonTapped
        case reviewCellTapped
    }
    
    enum Mutation {
        case setAllReviewDetailViewController(UIViewController)
        case setReviewDetailViewController(UIViewController)
    }
    
    var initialState: State
    
    struct State {
        var ratingFloatString: String
        var ratingNumberString: String?
        var allReviewDetailViewController: UIViewController?
        var reviewDetailViewController: UIViewController?
    }
    
    let searchResult: SearchResult
    
    init(searchResult: SearchResult) {
        self.searchResult = searchResult
        
        let ratingFloatString = String(format: "%.1f", searchResult.averageUserRating)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        let ratingNumberString = numberFormatter.string(from: NSNumber(value: searchResult.userRatingCount))
        
        initialState = .init(
            ratingFloatString: ratingFloatString,
            ratingNumberString: ratingNumberString
        )
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .seeAllButtonTapped:
            return .empty()
        case .reviewCellTapped:
            return .empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setAllReviewDetailViewController(let viewController):
            state.allReviewDetailViewController = viewController
        case .setReviewDetailViewController(let viewcontroller):
            state.reviewDetailViewController = viewcontroller
        }
        
        return state
    }
}
