//
//  ImageListViewModelTests.swift
//  DemoTests
//
//  Created by Unnikrishnan P on 28/06/20.
//  Copyright © 2020 UnniKrishnan. All rights reserved.
//

import XCTest
@testable import Demo

import Foundation

class ImageListViewModelTests: XCTestCase {

    func createDummyItemModel() -> ItemListModel {
        var itemsDetails: ItemListModel = ItemListModel()
        for indx in 1...3 {
            var itemInfo = ItemModel()
            itemInfo.authorName = "Author_\(indx)"
            itemInfo.imgId = indx
            itemsDetails.itemList.append(itemInfo)
        }
        return itemsDetails
    }

 // Test that the ItemsRequests can be flagged as failure with responce items count 0, invalid path is given.
    func testListItemsRequestFailure() {
        let itemModel = ItemListModel()
        let listViewModel = ImageListViewModel(itemsDetails: itemModel)
        
        if listViewModel.items.itemList.count < 1 {
            XCTAssertTrue(true, "testListItemsRequestFailure() succeeded")
        } else {
            XCTFail("testListItemsRequestFailure() failed")
        }
    }
    
    // Test that the ItemsRequests can be flagged as success with responce items count  greater than 0.
    func testListItemsRequestSuccess() {
        let listViewModel = ImageListViewModel(itemsDetails: createDummyItemModel())
        if listViewModel.items.itemList.count > 0 {
            XCTAssertTrue(true, "testSendItemsRequestSuccess() succeeded")
        } else {
            XCTFail("testListItemsRequestSuccess() failed")
        }
        
    }
    
    // Test that the ItemsRequests can be flagged as success with responce items count  greater than 0.
    func testImageDownloadSuccess() {
        let listViewModel = ImageListViewModel()
        let imageId = 10
        listViewModel.getImage(withId: imageId, success: { (result) in
            XCTAssertTrue(!result.isEmpty, "testImageDownloadSuccess() succeeded")
        }, failure:  { (error) in
            XCTFail("testImageDownloadSuccess() failed")
        })
    }

    
    // Test that the ImageRequest can be flagged as failure with responce with error message, when an invalid id is given.
    func testImageRequestFailure() {
        let listViewModel = ImageListViewModel()
        let imageId = -1
        listViewModel.getImage(withId: imageId, success: { (result) in
            XCTFail("testImageRequestFailure() failed")
        }, failure: { (error) in
            
            XCTAssertTrue(true,"testImageRequestFailure() succeeded ")
        })
    }
       
    // Test that the ItemsRequests can be flagged as success with responce items count  greater than 0.
    func testListItemsRequest_1_Success() {
        let listViewModel = ImageListViewModel()
        listViewModel.getServerItems(success: {
            XCTAssertTrue(true, "testSendItemsRequestSuccess() succeeded")
        }, failure:  { (error) in
            XCTFail("testListItemsRequestSuccess() failed")
        })
    }
 
}

