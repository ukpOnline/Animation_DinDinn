//
//  PromotionViewCell.swift
//  Demo
//
//  Created by Unnikrishnan P on 25/10/20.
//  Copyright © 2020 UnniKrishnan. All rights reserved.
//

import UIKit

// MARK: - PromotionViewCellDelegate

protocol PromotionViewCellDelegate {
//    func cellSelected(cellModel: PromotionShortItemModel?)
}
class PromotionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var lblOfferTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    // MARK: - Variables

    var model: PromotionItemModel?
    var delegate: PromotionViewCellDelegate?
    
    // MARK: - Overrided Methods

    override func prepareForReuse() {
        super.prepareForReuse()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
       roundedView.makeRounded(with: roundedView.frame.size.height/2, borederClr: UIColor.clear.cgColor)
    }
    // MARK: - Public Methods

    func updateCellInfo(cellModel: PromotionItemModel) {
       
        model = cellModel
        
        if let imageName = model?.imageName {
            imageView?.image = UIImage(named: imageName) ?? UIImage()
        } else {
            imageView?.image = UIImage()
        }
        lblOfferTitle.text = model?.titleHighLight
        lblDescription.text = model?.description
    }
    
    // MARK: - Private Methods
    
}
