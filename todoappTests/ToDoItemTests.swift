//
//  ToDoItemTests.swift
//  todoappTests
//
//  Created by Çağrı Portakalkökü on 10.03.2021.
//

import XCTest
@testable import todoapp

class ToDoItemTests: XCTestCase {
    
    
    /* ToDoItems must be belong to days in range 1...7
     if belongTo bigger than 7, task automatically added to Sunday
     if belongTo smaller than 1, task automatically added to Monday
     */
    func testToDoItemsOnSunday() {
        let todoItem = ToDoItem(detail: "detail", completed: false, uuid: UUID(), belongTo: 8)
        XCTAssertEqual(todoItem.belongTo,7)
    }
    func testToDoItemsOnMonday() {
        let todoItem = ToDoItem(detail: "detail", completed: false, uuid: UUID(), belongTo: -5)
        XCTAssertEqual(todoItem.belongTo,1)
    }
    
    
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
    
}
