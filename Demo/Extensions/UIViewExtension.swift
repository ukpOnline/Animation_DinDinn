//
//  UIViewExtension.swift
//  Demo
//
//  Created by Unnikrishnan P on 25/10/20.
//  Copyright © 2020 UnniKrishnan. All rights reserved.
//

import UIKit
extension UIView {
    
    func makeRounded(with radius: CGFloat? = nil, borederClr: CGColor = UIColor.clear.cgColor) {
        layer.borderColor = borederClr
        layer.borderWidth = 1.0
        layer.masksToBounds = true
        layer.cornerRadius  = radius ?? (bounds.size.height / 2)
    }
    
    func topRoundCorners(corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
        
        let frameLayer = CAShapeLayer()
        frameLayer.frame = self.bounds
        frameLayer.path = maskPath.cgPath
        //frameLayer.strokeColor = UIColor.appText.cgColor
        frameLayer.fillColor = nil
        
        self.layer.addSublayer(frameLayer)
    }
}
