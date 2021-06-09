//
//  TodoListTests.swift
//  TodoListTests
//
//  Created by Khalid Aqeeli on 08/06/2021.
//

import XCTest
@testable import TodoList

class TodoListTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testItemTableViewModel(){
        let itemViewModel = ItemTableViewModel()
        
        // Test Sheet Labels
        XCTAssertEqual(itemViewModel.sheetTitle, "Edit Note")
        XCTAssertEqual(itemViewModel.sheetCanelActionTitle, "Cancel")
        XCTAssertEqual(itemViewModel.sheetEditActionTitle, "Edit")
        
        // Test Alert Labels
        XCTAssertEqual(itemViewModel.alertTitle, "Update Note")
        XCTAssertEqual(itemViewModel.alertMessage, "Edit your Note")
        XCTAssertEqual(itemViewModel.actionTitle, "Save")
        
        
        // Test addAlert Labels
        XCTAssertEqual(itemViewModel.addAlertTitle, "New Note")
        XCTAssertEqual(itemViewModel.addAlertMessage, "Enter new Note")
        XCTAssertEqual(itemViewModel.addActionTitle, "Submit")
    }
    
    func testItemTableViewModelCoreDate(){
        
    }

}
