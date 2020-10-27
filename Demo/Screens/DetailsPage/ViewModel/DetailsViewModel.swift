//
//  DetailsViewModel.swift
//  Demo
//
//  Created by Unnikrishnan P on 27/06/20.
//  Copyright © 2020 UnniKrishnan. All rights reserved.
//

import Foundation


class DetailsViewModel: UKBaseViewModel {
    
    // MARK: - Variables
    var itemInfo: DetailModel!

    // MARK: - Initializer Methods
    init(withItemInfo itemInfo: DetailModel) {
        self.itemInfo = itemInfo
    }
    
    // MARK: - Overrided Methods

    // MARK: - Public Methods
    func authorName() -> String {
        return itemInfo.author_Name()
    }
    
    func imageURL() -> URL? {
        if let imageId = self.itemInfo?.imgId , imageId > -1 {
            return URL.init(string: "\(ImageURL.baseURL)\(imageId)")
        }
        return nil
        
    }
    

    // MARK: - Private Methods
    
}
