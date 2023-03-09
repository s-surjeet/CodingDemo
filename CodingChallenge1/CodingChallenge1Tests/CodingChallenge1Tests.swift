//
//  CodingChallenge1Tests.swift
//  CodingChallenge1Tests
//
//  Created by Surjeet on 09/03/23.
//

import XCTest
import CodingChallenge1

class CodingChallenge1Tests: XCTestCase {

    private var dataManager: DataManagerProtocol? = DataManager.shared
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    
        checkIfDataManagerNotNil()
        
        checkPersonList()
    }

    func checkIfDataManagerNotNil() {
        if dataManager == nil {
            XCTAssert(false, "Data manager not initiated")
        }
        XCTAssert(true, "Data manager initiated")
    }
    
    func checkPersonList() {
        dataManager?.fetchPersonList(isLoadNewData: true, completion: { _ in
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            
        }
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
