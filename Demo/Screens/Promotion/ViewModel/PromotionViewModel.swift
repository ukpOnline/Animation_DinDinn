//
//  PromotionViewModel.swift
//  Demo
//
//  Created by Unnikrishnan P on 25/10/20.
//  Copyright © 2020 UnniKrishnan. All rights reserved.
//

import Foundation

class PromotionViewModel {
    
    var promotionModel: PromotionModel!
    
    // MARK: - Initialization methods -
    init() {
        //        self.serviceManager  = STLoginWebserviceManager()
        self.promotionModel = PromotionModel()
        self.promotionModel.createDummyModel()
    }
    
    required convenience init(infoModel: PromotionModel) {
        self.init()
        self.promotionModel = infoModel
    }
    
    // MARK: - Public Methods -
     
     func sectionCount() -> Int {
         return 1
     }
     
     func itemCountForSection(num: Int? = 0) -> Int {
         return promotionModel.itemList.count
     }
     
     func itemFor(indexPath: IndexPath) -> PromotionItemModel? {
         
         if indexPath.row < promotionModel.itemList.count {
             return promotionModel.itemList[indexPath.row]
         }
         
         return nil
     }
     
     // MARK: - Webservice Method
     func sendItemListRequest(success: @escaping() -> Void, failure: @escaping(NSError) -> Void) {
         
         //Code for sending webservice request for login.
         //           self.serviceManager.sendItemListRequest(userInfo: self.getUserInfo(), success: { () in
         //               self.itemListRequestPerformed()
         //               success()
         //           }, failure: { (error) in
         //               self.itemListRequestErrorOccured(error: error)
         //               failure(error)
         //           })
     }
     
}
