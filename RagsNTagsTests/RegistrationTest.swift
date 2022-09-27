//
//  RegistrationTest.swift
//  RagsNTagsTests
//
//  Created by Capgemini-DA322 on 9/27/22.
//

import XCTest
@testable import RagsNTags

var registerVC: RegisterViewController!

class RegistrationTest: XCTestCase {

    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        registerVC = storyboard.instantiateViewController(withIdentifier: "registerVC") as? RegisterViewController
        registerVC.loadView()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //Test email and password validation
    func testisValidEmailPassword(){
        let textvalid = TextFieldValidation()
        XCTAssertTrue(textvalid.isValidEmailID(email: "safwan@gmail.com"))
        XCTAssertTrue(textvalid.isValidPassword(password: "Safwan786"))
    }
    
    //Test register on coredata
    func testRegisterOnCoreData(){
        let registercore = RegisterUserOnCoreData()
        XCTAssertTrue(registercore.registerOnCoreData(name: "Dummy", mobile: "1111111111", email: "dummy@gmail.com", password: "Dummy786"))
    }
    
    //Test register on Forebase
    func testRegisterOnFirebase(){
        let registerfirebase = RegisterUserOnFirebase()
        XCTAssertTrue(registerfirebase.registerOnFirebase(emailid: "Dummy", password: "Dummy786"))
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
