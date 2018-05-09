//
//  NSRConnectionTest.swift
//  Family Tree iOSTests
//
//  Created by Nasir Ahmed Momin on 09/05/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import XCTest

class NSRConnectionTest: XCTestCase {
    
let jsonData = """
{
"name": "John Family",
"children": [
{"name": "Samuel"},
{"name": "Steve"},
{"name": "Rahul"}
]
}
""".data(using: .utf8)
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDataDownload() {
        let expt : XCTestExpectation = expectation(description: "getRequest")
        
        NSRDataFetcher.shared.getRequestData { (data, response, err) in
            
            
            let httpResponse = response as! HTTPURLResponse
            print("httpResponse.statusCode \(httpResponse.statusCode)")
            
            XCTAssertEqual(httpResponse.statusCode, 200)
            
            XCTAssertEqual(httpResponse.statusCode, 500)
            
            XCTAssert(httpResponse.statusCode != 200, "Testfailed")
            
            XCTAssertNil(data, "data is nil")
            
            XCTAssertNotNil(data, "data is not nil")
            
            XCTAssertNotNil(err, "Error is not nil")
            
            XCTAssertNil(err, "Error is nil")
            
            expt.fulfill()
        }
        
        
        wait(for: [expt], timeout: 10.0)
    }
    
    func testJSONParser() {
        let family = NSRDataConstructor.parseJSONfrom(data: jsonData!)
        
        XCTAssertNil(family)
        
        XCTAssertNotNil(family)
        
        XCTAssertNil(family?.name, "name object is nil")
        
        XCTAssertNil(family?.children, "children object is nil")
        
        XCTAssertEqual(family?.children?.count, 0, "Family has more 0 children")
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
