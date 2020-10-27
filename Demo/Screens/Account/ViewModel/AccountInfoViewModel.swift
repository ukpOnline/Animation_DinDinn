//
//  AccountInfoViewModel.swift
//  Demo
//
//  Created by Unnikrishnan P on 26/10/20.
//  Copyright © 2020 UnniKrishnan. All rights reserved.
//

import Foundation

class AccountInfoViewModel {
    
    var accountModel: AccountInfoModel!
    
    // MARK: - Initialization methods -
    init() {
        self.accountModel = AccountInfoModel()
        self.accountModel.createDummyModel()
    }
    
    required convenience init(infoModel: AccountInfoModel) {
        self.init()
        self.accountModel = infoModel
    }
    
    // MARK: - Public Methods -
    
    func sectionCount() -> Int {
        return 1
    }
    
    func itemCountForSection(num: Int? = 0) -> Int {
        return accountModel.itemList.count
    }
    
    func itemFor(indexPath: IndexPath) -> AccountInfoItemModel? {
        if indexPath.row < accountModel.itemList.count {
            return accountModel.itemList[indexPath.row]
        }
        return nil
    }
}
