//
//  ProductDetailTest.swift
//  RagsNTagsTests
//
//  Created by Capgemini-DA322 on 9/27/22.
//

import XCTest
@testable import RagsNTags

class ProductDetailTest: XCTestCase {

    var productVC: ProductDetailsViewController!
    
    override func setUpWithError() throws {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        productVC = storyboard.instantiateViewController(withIdentifier: "proDetails") as? ProductDetailsViewController
        productVC.loadView()
    }

    func testIBOutletConnection(){
        XCTAssertNotNil(productVC.titles, "not connected")
        XCTAssertNotNil(productVC.descDisplay, "not connected")
        XCTAssertNotNil(productVC.imgDisplay, "not connected")
        XCTAssertNotNil(productVC.priceDisplay, "not connected")
    }
    
    
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
