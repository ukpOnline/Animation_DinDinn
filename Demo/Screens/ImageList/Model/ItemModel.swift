//
//  ItemModel.swift
//  Demo
//
//  Created by Unnikrishnan P on 27/06/20.
//  Copyright © 2020 UnniKrishnan. All rights reserved.
//

import Foundation

struct ItemModel: Decodable, Comparable {

    var imgId: Int = -1
    var filename: String?
    var authorName: String?
    var format: String?
    var width: Int64?
    var height: Int64?
    var postURL: URL?
    var authorURL: URL?
    
    var titleName: String?
    var description: String?
    var info: String?
    var amount: String?

    enum CodingKeys : String, CodingKey {
        case postURL       = "post_url"
        case authorURL     = "author_url"
        case filename      = "filename"
        case format        = "format"
        case imgId         = "id"
        case authorName    = "author"
        case width         = "width"
        case height        = "height"
    }

    static func <(lhs: ItemModel, rhs: ItemModel) -> Bool {
        return lhs.imgId < rhs.imgId
    }
    
    func author_Name() -> String {
        if let _ = self.authorName {
            return self.authorName!
        }
        return "n.a"
    }
}
