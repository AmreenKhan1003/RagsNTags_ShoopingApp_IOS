//
//  CategoryTest.swift
//  RagsNTagsTests
//
//  Created by Capgemini-DA322 on 9/27/22.
//

import XCTest
@testable import RagsNTags

class CategoryTest: XCTestCase {
    
    var catVC: CategoriesViewController!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        catVC = storyboard.instantiateViewController(withIdentifier: "catVC") as? CategoriesViewController
        catVC.loadView()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
   
    func testIBoutletsTable(){
        XCTAssertNotNil(catVC.categoryTable, "Not connected")
    }
    
    func testIBoutlet(){
        XCTAssertNotNil(catVC.categories, "Not connected")
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
