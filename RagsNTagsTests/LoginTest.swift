//
//  LoginTest.swift
//  RagsNTagsTests
//
//  Created by Capgemini-DA322 on 9/27/22.
//

import XCTest
@testable import RagsNTags

class LoginTest: XCTestCase {
    
    var loginVC: ViewController!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        loginVC = storyboard.instantiateViewController(withIdentifier: "loginVC") as? ViewController
        loginVC.loadView()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testClassCoreDataFetchFunc(){
        let core = CoreDataFetch()
        let result = core.fetchname(email: "safwan@gmail.com")
        XCTAssertEqual(result, "Safwan modak")
    }
    
    //test func logninUserFromFirebase()
    func testlogninUserFromFirebase(){
        XCTAssertTrue(loginVC.logninUserFromFirebase(emailId: "safwan@gmail.com", password: "Safwan786"))
    }

    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
