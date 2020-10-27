//
//  ItemListViewCell.swift
//  Demo
//
//  Created by Unnikrishnan P on 27/06/20.
//  Copyright © 2020 UnniKrishnan. All rights reserved.
//

import Foundation
import UIKit
protocol ItemListViewCellDelegate {
     func itemSelected(model: ItemModel?)
}

class ItemListViewCell: UICollectionViewCell {
     
     // MARK: - IBOutlets
     @IBOutlet weak var cellImage: UIImageView!
     @IBOutlet weak var buttonBackground: UIView!
     @IBOutlet weak var itemTitle: UILabel!
     @IBOutlet weak var itemInfo: UILabel!
     @IBOutlet weak var itemDetails: UILabel!
     
     @IBOutlet weak var btnAddItem: UIButton!
     @IBOutlet weak var titleIndicator: UIView!
     
     // MARK: - Variables
     
     static let reUseIdentifier = "imageColectionViewCell"
     var itemData: ItemModel?
     var delegate: ItemListViewCellDelegate?
     
     // MARK: - Overrided Methods
     override func awakeFromNib() {
          super.awakeFromNib()
          // Initialization code
          cellImage.topRoundCorners(corners: [.topLeft, .topRight], radius: 18.0)
     }
     
     override func prepareForReuse() {
          cellImage.image = UIImage(named: "noItemImage")
     }
     
     // MARK: - Public Methods
     
     func updateItem(imageName: String?) {
          if let imgName = imageName {
               cellImage.image = UIImage(named: imgName)
          }
          itemTitle.text = itemData?.titleName
          itemInfo.text  = itemData?.info
          itemDetails.text = itemData?.description
          if let amt = itemData?.amount {
               btnAddItem?.setTitle(amt, for: .normal)
          }
     }

     @IBAction func touchUpInside(_ sender: Any) {
     }
     @IBAction func buttonAddTapped(_ sender: Any) {
          delegate?.itemSelected(model: itemData)
          animateButtonTap()
     }
     // MARK: - Private Methods
     
     fileprivate func animateButtonTap(){
          UIView.animate(withDuration: 3, delay: 0.0, options: [.curveEaseOut],
                         animations: {
                              self.buttonBackground.backgroundColor = UIColor.green
                              self.btnAddItem.setTitle("added +1", for: .normal)
                              self.buttonBackground.layoutIfNeeded()
          },  completion: {(_ completed: Bool) -> Void in
               self.btnAddItem.setTitle("55 Usd", for: .normal)
               self.buttonBackground.backgroundColor = UIColor.black
               self.buttonBackground.layoutIfNeeded()
          })
     }

}
