//
//  CategoryViewCell.swift
//  Demo
//
//  Created by Unnikrishnan P on 25/10/20.
//  Copyright © 2020 UnniKrishnan. All rights reserved.
//

import UIKit

class CategoryViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var lblTitle: UILabel!
    
    // MARK: - Variables
    static let reUseIdentifier = "idCategoryCell"
    var isCategorySelected: Bool = false

    // MARK: - Overrided Methods
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: - Public Methods
    
    func updateCellInfo(title: String) {
        lblTitle.text = title
        lblTitle.textColor = isCategorySelected ? UIColor.black : UIColor.gray
    }
    
}
