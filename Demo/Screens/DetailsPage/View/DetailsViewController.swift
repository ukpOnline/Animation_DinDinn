//
//  DetailsViewController.swift
//  Demo
//
//  Created by Unnikrishnan P on 27/06/20.
//  Copyright © 2020 UnniKrishnan. All rights reserved.
//

import UIKit
import SDWebImage

class DetailsViewController: UKBaseViewController {
    
    // MARK: - IBoutlets
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var authorName: UKLabel!

    
    // MARK: - Properties
    var viewModel: DetailsViewModel?
    
    // MARK: - Initializer Methods
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    // MARK: - Overrided Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadUI()
    }
    
    // MARK: - Public Methods
    

    // MARK: - Private Methods
    fileprivate func loadUI() {
        self.authorName.text = viewModel?.authorName()
        if let imageURL = viewModel?.imageURL() {
            itemImage.sd_setShowActivityIndicatorView(true)
            itemImage.sd_setShowActivityIndicatorView(true)
            if #available(iOS 13.0, *) {
                itemImage.sd_setIndicatorStyle(.large)
            } else {
                itemImage.sd_setIndicatorStyle(.gray)
            }
            itemImage.sd_setImage(with: imageURL, placeholderImage: #imageLiteral(resourceName: "noItemImage"), options: [.progressiveDownload])
        }
    }
    
    // MARK: - Navigation Methods

}

