//
//  ImageListViewModel.swift
//  Demo
//
//  Created by Unnikrishnan P on 27/06/20.
//  Copyright © 2020 UnniKrishnan. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol ImageListViewModelDelegate: class {
    func itemlistReceived()
    func dataErrorOccured(message: String)
}

struct ItemListModel {
    
    var itemList: [ItemModel] = []

    init() {
        
    }
    
    init(data: NSData) {
        print("parseResponse : \(itemList.count)")
        itemList = []
        if let itemsList: [ItemModel] = try! JSONDecoder().decode([ItemModel].self, from: data as Data) {
            itemList = itemsList
        }
    }
}
enum CategoryItems {
    case pizza
    case sushi
    case drinks
    
    func displayName() -> String {
        switch self {
        case .pizza:
            return "Pizza"
        case .sushi:
            return "Sushi"
        default:
            return "Drinks"
        }
    }
}
class ImageListViewModel: UKBaseViewModel {
    
    // MARK: - Variables

    var items: ItemListModel!
    var serviceManager: ImageListWebservice = ImageListWebservice()
    weak var delegate: ImageListViewModelDelegate?
    var categoryItems: [CategoryItems] = []
    var selectedCategory: CategoryItems = .pizza
    
    // MARK: - Overrided Methods
    override init() {
        super.init()
        self.items = ItemListModel()
        categoryItems = [.pizza, .sushi, .drinks]
    }
    
    init(itemsDetails: ItemListModel) {
        self.items = itemsDetails
    }

    // MARK: - Public Methods
    func getImageItems() {
        self.getServerItems(success: {
            print("Service success")
        },failure: { (error) in
            print("Service failed with error:\(error.localizedDescription)")
            self.delegate?.dataErrorOccured(message: error.localizedDescription)
        })
    }
    func updateDummyData(){
        let titleNames:[String] = ["Delight", "Hawaiian","The egoist", "CaliFornia", "Lorem ipsum", "Dolor sit amet"]
        let descriptions:[String] = ["Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt.", "Duis aute irure dolor in reprehenderit in voluptate velit.", "Excepteur sint occaecat cupidatat non proident", "Sunt in culpa qui officia deserunt mollit anim id est laborum."]
        let itemInfo:[String] = ["200 grams 35 cm", "450 grams, 38 pieces", "930 grams, 38 pieces"]
        let amoint:[String] = ["45 usd", "52 usd", "78 usd", "90 usd", "12 usd", "15 usd", "18 usd", "101 usd"]

        for index in 0...self.itemsCout() - 1 {
            self.items.itemList[index].titleName = titleNames[index%5]
            self.items.itemList[index].description = descriptions[index%3]
            self.items.itemList[index].info = itemInfo[index%2]
            self.items.itemList[index].amount = amoint[index%7]
        }
        
    }
    
    func itemsCout() -> Int {
        //Temporary used as top 50.
        return self.items.itemList.count > 50 ? 50 : 0
    }
    
    func itemModelForRow(indexPath: IndexPath) -> ItemModel?  {
        
        if indexPath.row < itemsCout() {
            return self.items.itemList[indexPath.row]
        }
        return nil
    }
    
    func getServerItems( success: @escaping() -> Void, failure: @escaping(NSError) -> Void) {
        
        self.serviceManager.sendItemsRequest(success: { (result) in
            self.items.itemList = []
            if let datInfo = (result as? NSData) {
                let itemListModel = ItemListModel(data:datInfo)
                self.items.itemList = itemListModel.itemList.sorted()
            }
            print("ILVM: \(self.items.itemList.count)")
            //Sort the items
            self.delegate?.itemlistReceived()
            success()
        }, failure: { (error) in
            failure(error)
        })
    }
    
    //For testing purpose
    func getImage(withId: Int, success: @escaping(String) -> Void, failure: @escaping(NSError) -> Void) {
        if withId < 0 {
            let error = NSError.init(domain: "Invalid image", code: 100, userInfo: nil)
            failure(error)
        } else {
            let imageData = "Image Data for testing"
            success(imageData)
        }
    }
    
    // MARK: - Private Methods
}
