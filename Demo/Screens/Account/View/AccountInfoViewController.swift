//
//  AccountInfoViewController.swift
//  Demo
//
//  Created by Unnikrishnan P on 26/10/20.
//  Copyright © 2020 UnniKrishnan. All rights reserved.
//

import UIKit

class AccountInfoViewController: UKBaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var topSectionView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var lblDeliveryInfo: UILabel!
    @IBOutlet weak var lblValueInfo: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
     // MARK: - Variables
      var viewModel: AccountInfoViewModel!

    // MARK: - Initialization
      required init?(coder aDecoder: NSCoder) {
          super.init(coder: aDecoder)
          
          //self.navigationItems = []
          self.viewModel  = AccountInfoViewModel()
      }
      
      // MARK: - Overrided Methods
}

// MARK: - UITableViewDataSource
extension AccountInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.itemCountForSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartInfoCell", for: indexPath) as! CartInfoTableViewCell
        
        cell.updateUI(cellModel: self.viewModel.itemFor(indexPath: indexPath))
        return cell
    }
    
    
}
