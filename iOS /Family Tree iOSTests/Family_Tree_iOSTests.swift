//
//  Family_Tree_iOSTests.swift
//  Family Tree iOSTests
//
//  Created by Nasir Ahmed Momin on 07/05/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import XCTest
@testable import Family_Tree_iOS

class Family_Tree_iOSTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    
    func testDataDownload() {
        let expt : XCTestExpectation = expectation(description: "getRequest")
        
        NSRDataFetcher.shared.getRequestData { (data, response, err) in
            
            expt.fulfill()
            
            let httpResponse = response as! HTTPURLResponse
            print("httpResponse.statusCode \(httpResponse.statusCode)")
           
            XCTAssert(httpResponse.statusCode == 200, "Test passed")
            
            XCTAssertEqual(httpResponse.statusCode, 500)
            
            XCTAssert(httpResponse.statusCode != 200, "Testfailed")

        }
        
        
        wait(for: [expt], timeout: 2.0)
    }
    
    
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
}
