//
//  Unit4Assignment1ProjTests.swift
//  Unit4Assignment1ProjTests
//
//  Created by Kevin Natera on 10/4/19.
//  Copyright © 2019 Kevin Natera. All rights reserved.
//

import XCTest
import Foundation
import UIKit



class Unit4Assignment1ProjTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testPersistence() {
        struct Photos {
            var title: String
            var caption: String
            var imageName: String
            var date: Date
        }
        
        let storePhoto = Photos(title: "test", caption: "test", imageName: "test", date: Date())
        UserDefaults.standard.set(storePhoto.imageName, forKey: "Photo")
        let retrievePhoto = UserDefaults.standard.value(forKey: "Photo") as! String
        XCTAssertTrue(storePhoto.imageName == retrievePhoto)
    }
}
