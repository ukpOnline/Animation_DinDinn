//
//  ImageListWebservice.swift
//  Demo
//
//  Created by Unnikrishnan P on 27/06/20.
//  Copyright © 2020 UnniKrishnan. All rights reserved.
//

import Foundation
import SwiftyJSON

class ImageListWebservice: UKWebserviceManger {
    
    let webServicePathItemsList     = "list"
    
    // MARK: - Variables
    
    // MARK: - Overrided Methods
    
    
    // MARK: - Public Methods
    //To get items list informations from the server.
    func sendItemsRequest(success: @escaping (Any) -> Void, failure: @escaping (NSError) -> Void) {
        
        super.sendWebServiceRequest(path: webServicePathItemsList, httpMethod: .get, params: nil, success: { (result) in
            //            let itemList: [ItemModel] = self.parseResponse(data: (result as? NSData)!) ?? []
            success(result)
        }, failure: { (error) in
            failure(error)
        })
    }
    
    // MARK: - Private Methods

}
