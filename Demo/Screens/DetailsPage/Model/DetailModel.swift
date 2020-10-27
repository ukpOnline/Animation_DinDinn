//
//  DetailModel.swift
//  Demo
//
//  Created by Unnikrishnan P on 03/07/20.
//  Copyright © 2020 UnniKrishnan. All rights reserved.
//

import Foundation

struct DetailModel {
    
    var imgId: Int = -1
    var authorName: String?
    
    init(identifier: Int, authorName: String) {
        self.imgId = identifier
        self.authorName = authorName
    }
    
    func author_Name() -> String {
        if let _ = self.authorName {
            return self.authorName!
        }
        return "n.a"
    }
}
