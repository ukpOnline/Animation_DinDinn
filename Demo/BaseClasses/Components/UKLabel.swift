//
//  UKLabel.swift
//  Demo
//
//  Created by Unnikrishnan P on 28/06/20.
//  Copyright © 2020 UnniKrishnan. All rights reserved.
//

import UIKit

//Base UILable for the Project
class UKLabel : UILabel {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.textColor = UKColors.indicatorBlue
    }
}
