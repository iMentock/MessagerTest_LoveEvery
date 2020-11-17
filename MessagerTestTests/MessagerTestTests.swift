//
//  MessagerTestTests.swift
//  MessagerTestTests
//
//  Created by Virgil Martinez on 11/17/20.
//

import XCTest
@testable import MessagerTest

class MessagerTestTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetAllMessages() {
        let messageVM = MessageViewModel()
        
        messageVM.getAllMessagesData { (error) in
            XCTAssertNil(error)
        }
    }
    
    func testSendMessage() {
        let messageVM = MessageViewModel()
        let newMessage = Message(subject: "Test Message", message: "From unit tests", username: "UnitTester")
        
        messageVM.send(message: newMessage) { (error) in
            XCTAssertNil(error)
        }
    }
    
    func testMissingUserMessage() {
        let messageVM = MessageViewModel()
        let randomUsername = UUID().uuidString
        
        messageVM.getAllMessagesData(forUser: randomUsername) { (error) in
            XCTAssertNotNil(error)
        }
    }
    
    func testGoodUserMessage() {
        let messageVM = MessageViewModel()
        let newMessage = Message(subject: "Test Message", message: "From unit tests", username: "FindMe")
        
        messageVM.send(message: newMessage) { (error) in
            XCTAssertNil(error)
        }
        
        messageVM.getAllMessagesData(forUser: newMessage.username) { (error) in
            XCTAssertNotNil(error)
        }
    }

}
