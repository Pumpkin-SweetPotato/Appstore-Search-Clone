//
//  ExpandableCell.swift
//  KakaoMinsoo
//
//  Created by ZES2017MBP on 2020/09/20.
//  Copyright © 2020 Minsoo. All rights reserved.
//

import UIKit

protocol ExpandableCell: UITableViewCell {
    var isExpanded: Bool { get set }
    func expand(completion: @escaping((Bool) -> Void)) 
}
