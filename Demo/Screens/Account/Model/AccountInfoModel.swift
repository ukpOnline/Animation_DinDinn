//
//  AccountInfoModel.swift
//  Demo
//
//  Created by Unnikrishnan P on 26/10/20.
//  Copyright © 2020 UnniKrishnan. All rights reserved.
//

import Foundation

struct AccountInfoModel {
    
    var itemList: [AccountInfoItemModel] = []
    var selectedIndex: Int = 0
    
    mutating func createDummyModel() {
        
        for index in 0...2 {
            var item = AccountInfoItemModel()
            switch index {
            case 0:
                item.title = "Hawailian"
                item.priceString = "46 usd "
                item.imageName   = "item_0"
            case 1:
               item.title = "Pepperoni"
               item.priceString = "55 usd "
               item.imageName   = "item_8"
           
            default:
                item.title = "California"
                item.priceString = "60 usd "
                item.imageName   = "multi_0"
            }
           
            itemList.append(item)
        }
    }
}

struct AccountInfoItemModel {
    
    var title: String?
    var priceString: String?
    var otherOnfo: String?
    var imageName: String?
}
