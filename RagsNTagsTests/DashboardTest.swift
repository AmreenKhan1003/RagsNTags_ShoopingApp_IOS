//
//  DashboardTest.swift
//  RagsNTagsTests
//
//  Created by Capgemini-DA322 on 9/27/22.
//

import XCTest
@testable import RagsNTags

class DashboardTest: XCTestCase {
    var dashVC: DashboardViewController!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        dashVC = storyboard.instantiateViewController(withIdentifier: "dash") as? DashboardViewController
        dashVC.loadView()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testOutletGroceriesButton() throws{
        let grocbutton = try XCTUnwrap(dashVC.groceriesButton, "Button not connected")
        let checkaction = try XCTUnwrap(grocbutton.actions(forTarget: dashVC, forControlEvent: .touchUpInside), "Action not performed")
        XCTAssertEqual(checkaction.first, "groceriesClicked:", "Action is having same name?")
    }
    
    func testOutletFashionButton() throws{
        let button = try XCTUnwrap(dashVC.fashionButton, "Button not connected")
        let checkaction = try XCTUnwrap(button.actions(forTarget: dashVC, forControlEvent: .touchUpInside), "Action not performed")
        XCTAssertEqual(checkaction.first, "fashionClicked:", "Action is having same name?")
    }
    
    func testOutletElecButton() throws{
        let button = try XCTUnwrap(dashVC.elecButton, "Button not connected")
        let checkaction = try XCTUnwrap(button.actions(forTarget: dashVC, forControlEvent: .touchUpInside), "Action not performed")
        XCTAssertEqual(checkaction.first, "electronicClicked:", "Action is having same name?")
    }
    
    func testOutletBeautyButton() throws{
        let button = try XCTUnwrap(dashVC.beautyButton, "Button not connected")
        let checkaction = try XCTUnwrap(button.actions(forTarget: dashVC, forControlEvent: .touchUpInside), "Action not performed")
        XCTAssertEqual(checkaction.first, "beautyClicked:", "Action is having same name?")
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
