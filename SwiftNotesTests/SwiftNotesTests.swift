//
//  SwiftNotesTests.swift
//  SwiftNotesTests
//
//  Created by GinsMac on 2019/6/8.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import XCTest
@testable import SwiftNotes

class SwiftNotesTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let myHeight = kScreenHeight
        XCTAssert(myHeight == 896)
        
        let testPage = TestPage()
        let textInTestPage = testPage.mytext
        XCTAssert(textInTestPage == "heheda")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
