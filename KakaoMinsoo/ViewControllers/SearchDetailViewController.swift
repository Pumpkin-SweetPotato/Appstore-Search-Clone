//
//  SearchDetailViewController.swift
//  KakaoMinsoo
//
//  Created by ZES2017MBP on 2020/09/17.
//  Copyright © 2020 Minsoo. All rights reserved.
//

import UIKit
import ReactorKit

class SearchDetailViewController: UIViewController, ReactorKit.StoryboardView {
    @IBOutlet var rootView: UIView!
    
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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
