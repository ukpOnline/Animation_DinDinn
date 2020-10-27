//
//  HeaderReusableView.swift
//  Demo
//
//  Created by Unnikrishnan P on 25/10/20.
//  Copyright © 2020 UnniKrishnan. All rights reserved.
//

import UIKit

class HeaderReusableView: UICollectionReusableView {
    
    // MARK: - IBOutlets
    @IBOutlet weak var labelFilter: UILabel?
    @IBOutlet weak var buttonVeg: UIButton?
    @IBOutlet weak var buttonSpicy: UIButton?

    // MARK: - Variables
    var isHideItem: Bool = true

    // MARK: - Initializations
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
 
    // MARK: - Public Methods
    func updateUI() {
        labelFilter?.isHidden = isHideItem
        buttonVeg?.isHidden = isHideItem
        buttonSpicy?.isHidden = isHideItem
        buttonSpicy?.makeRounded(with: 8.0, borederClr: UIColor.gray.cgColor)
        buttonVeg?.makeRounded(with: 8.0, borederClr: UIColor.gray.cgColor)
    }
}
