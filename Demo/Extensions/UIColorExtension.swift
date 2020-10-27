//
//  UIColorExtension.swift
//  Demo
//
//  Created by Unnikrishnan P on 27/06/20.
//  Copyright © 2020 UnniKrishnan. All rights reserved.
//
import UIKit

extension UIColor {
    
    class func from(rgb hexValue: UInt, alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: CGFloat((hexValue & 0xFF0000) >> 16) / 255.0,
                       green: CGFloat((hexValue & 0x00FF00) >> 8) / 255.0,
                       blue: CGFloat((hexValue & 0x0000FF) >> 0) / 255.0,
                       alpha: alpha)
    }
}

struct UKColors {
    
    static let whiteAttributedColor = UIColor.from(rgb: 0xFFFFFF)
    static let indicatorBlue        = "#194792".hexStringToUIColor()
}
