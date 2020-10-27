//
//  CartInfoTableViewCell.swift
//  Demo
//
//  Created by Unnikrishnan P on 26/10/20.
//  Copyright © 2020 UnniKrishnan. All rights reserved.
//

import UIKit

class CartInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnRemove: UIButton!
    
    var model: AccountInfoItemModel?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    func updateUI(cellModel: AccountInfoItemModel?) {
        
        model = cellModel
        if let image = UIImage(named: model?.imageName ?? "noItemImage" ) {
            itemImageView.image = image
        }
        lblInfo.text = model?.title
        lblPrice.text = model?.priceString
    }
}

