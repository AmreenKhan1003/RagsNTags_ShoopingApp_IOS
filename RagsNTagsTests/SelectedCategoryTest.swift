//
//  SelectedCategoryTest.swift
//  RagsNTagsTests
//
//  Created by Capgemini-DA322 on 9/27/22.
//

import XCTest
@testable import RagsNTags

class SelectedCategoryTest: XCTestCase {

    var selectedVC: SelectedCategoryViewController!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        selectedVC = storyboard.instantiateViewController(withIdentifier: "SelecCatVC") as? SelectedCategoryViewController
        selectedVC.loadView()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testIBoutletConnectionCell(){
        let cell = HomeTableViewCell()
        XCTAssertNil(cell.productTitle, "Not connected")
        XCTAssertNil(cell.productDesc, "Not connected")
        XCTAssertNil(cell.productImage, "Not connected")
    }
    
    func testIBOutletConnetionTable(){
        XCTAssertNotNil(selectedVC.homeTableView, "Not connected")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
