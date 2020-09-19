//
//  RatingBar.swift
//  KakaoMinsoo
//
//  Created by ZES2017MBP on 2020/09/19.
//  Copyright © 2020 Minsoo. All rights reserved.
//

import UIKit

class RatingBar: UIView {
    private var ratingBarLayer: CAShapeLayer!
    
    var rating: CGFloat {
        didSet {
            if ratingBarLayer == nil {
                ratingBarLayer = createRatingBarLayer()
            }
            layer.backgroundColor = UIColor.searchGray(alpha: 0.2).cgColor
            layer.addSublayer(ratingBarLayer)
            ratingBarLayer.strokeEnd = rating
        }
    }
    
    
    override init(frame: CGRect) {
        rating = 0
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    func createRatingBarLayer() -> CAShapeLayer {
        let ratingBarLayer: CAShapeLayer = CAShapeLayer()
        let ratingPath: UIBezierPath = UIBezierPath()
        let lineWidth: CGFloat = 2

        ratingPath.move(to: CGPoint(x:0, y: frame.height - lineWidth / 2))
        ratingPath.addLine(to: CGPoint(x: frame.width, y: frame.height - lineWidth / 2))

        ratingBarLayer.path = ratingPath.cgPath
        ratingBarLayer.frame = bounds
        ratingBarLayer.lineWidth = lineWidth
        ratingBarLayer.lineCap = .square
        
        
        
        ratingBarLayer.strokeColor = UIColor.searchGray(alpha: 0.8).cgColor
        ratingBarLayer.strokeEnd = 0
//        ratingBarLayer.borderColor = UIColor.searchGray(alpha: 0.8).cgColor

        return ratingBarLayer
    }
    
}
