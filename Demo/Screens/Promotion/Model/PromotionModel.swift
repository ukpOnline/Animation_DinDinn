//
//  PromotionModel.swift
//  Demo
//
//  Created by Unnikrishnan P on 25/10/20.
//  Copyright © 2020 UnniKrishnan. All rights reserved.
//

import Foundation

struct PromotionModel {
    // MARK: - Variales
    var itemList: [PromotionItemModel] = []
    var selectedIndex: Int = 0
    
    //Create a Dummy data
    mutating func createDummyModel() {
        
        for index in 0...2 {
            var item = PromotionItemModel()
            item.title       = """
            Kazarov
            delivery
            """

            switch index {
            case 0:
                item.titleHighLight = """
                Saturday
                discound
                """
                item.description = "Coca-cola as a gift to any order."
                item.imageName   = "offer_1"
            case 1:
               item.titleHighLight = """
               Tuesday
               discound
               """
               item.description = "Every Tuesday there is a free drink to order."
               item.imageName   = "offer_2"
            case 2:
                item.titleHighLight = """
                Monday
                discound
                """
                item.description = "Roll as a gift to any set of sushi"
                item.imageName   = "offer_3"
            default:
                item.titleHighLight = """
                Sunday
                discound
                """
                item.description = "Limited time offer exclusively for the app users."
                item.imageName   = "offer_1"
            }
           
            itemList.append(item)
        }
    }
}

struct PromotionItemModel {
    
    var title: String?
    var description: String?
    var otherOnfo: String?
    var imageName: String?
    var indexPath: IndexPath?
    var titleHighLight: String?
}
