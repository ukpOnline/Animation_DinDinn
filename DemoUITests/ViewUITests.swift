//
//  HomeViewUITests.swift
//  DemoUITests
//
//  Created by Unnikrishnan P on 28/06/20.
//  Copyright © 2020 UnniKrishnan. All rights reserved.
//

import Foundation

import XCTest

class ViewUITests: XCTestCase {
    
    var app: XCUIApplication!
    let btnShowImages    = "Show Images"
    let btnBack          = "Back"
    let lblHomeTitle     = "iOS Demonstration"
    let lblListingsTitle = "Image Listings"
    let lblNA            = "n.a."
    let defaultImageName = "noItemImage"
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
    }
    
    func testShowHomePage() {
        app.launch()
        let isDisplayingOnboarding = app.staticTexts[lblListingsTitle].exists
        XCTAssertTrue(isDisplayingOnboarding)
    }

    func testHomePageItemSelection() {
        testShowHomePage()
        app.collectionViews.cells.element(boundBy: 1).tap()
        var isDisplayingOnboarding = !app.staticTexts[lblNA].exists
        isDisplayingOnboarding = !app.images[defaultImageName].exists
        XCTAssertTrue(isDisplayingOnboarding)
    }
}
