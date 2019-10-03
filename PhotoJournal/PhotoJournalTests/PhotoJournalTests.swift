//
//  PhotoJournalTests.swift
//  PhotoJournalTests
//
//  Created by Sunni Tang on 10/2/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import XCTest
@testable import PhotoJournal

class PhotoJournalTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    private var testJournal = [PhotoJournal]()
    private let exampleOne = PhotoJournal(photoData: Data(), title: "Example One", date: "123")
    private let exampleTwo = PhotoJournal(photoData: Data(), title: "Example Two", date: "456")
    
    private func savePersistence() {
        
        do {
            try TestPersistenceHelper.manager.savePhotoEntry(photo: exampleOne)
            try TestPersistenceHelper.manager.savePhotoEntry(photo: exampleTwo)
        } catch {
            print(error)
        }
        
    }

    func testLoadPersistence() {
//        savePersistence()
        
        do {
            testJournal = try TestPersistenceHelper.manager.getPhotoJournal()
        } catch {
            print(error)
        }
        
        XCTAssertTrue(testJournal[0].title == exampleOne.title, "Expected: \(exampleOne.title), Got: \(testJournal[0].title)")
        XCTAssertTrue(testJournal[1].title == exampleTwo.title, "Expected: \(exampleTwo.title), Got: \(testJournal[1].title)")
     
    }

    func testDeletePersistedObject() {
        do {
            try TestPersistenceHelper.manager.deletePhotoJournal(withTitle: exampleOne.title)
            try TestPersistenceHelper.manager.deletePhotoJournal(withTitle: exampleTwo.title)
        } catch {
            print(error)
        }
        
        XCTAssertTrue(testJournal.count == 0, "Expected: 0, Got: \(testJournal.count)")
    }
}
