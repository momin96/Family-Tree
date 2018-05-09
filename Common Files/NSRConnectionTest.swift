//
//  NSRConnectionTest.swift
//  Family Tree iOSTests
//
//  Created by Nasir Ahmed Momin on 09/05/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import XCTest

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

class NSRConnectionTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDataFetchPassCases () {
        let expt : XCTestExpectation = expectation(description: "getRequest_PassCase")
        
        NSRDataFetcher.shared.getRequestData { (data, response, err) in
            
            
            let httpResponse = response as! HTTPURLResponse
            print("httpResponse.statusCode \(httpResponse.statusCode)")
            
            XCTAssertEqual(httpResponse.statusCode, 200, "Status code 200, Data received successfully")
            
            XCTAssertNotNil(data, "data is not nil")
            
            XCTAssertNil(err, "Error is nil")
            
            expt.fulfill()
        }
        
        
        wait(for: [expt], timeout: 10.0)
    }
    
    func testDataFetchFailCases (){
        
        let expt : XCTestExpectation = expectation(description: "getRequest_FailCase")
        
        NSRDataFetcher.shared.getRequestData { (data, response, err) in
        
        
        let httpResponse = response as! HTTPURLResponse
        print("httpResponse.statusCode \(httpResponse.statusCode)")
        
        
        XCTAssertEqual(httpResponse.statusCode, 500, "Status code 500, Dint received Data")
        
        XCTAssertNil(data, "data is nil")
        
        XCTAssertNotNil(err, "Error is not nil")
        
        expt.fulfill()
    }
    
    
    wait(for: [expt], timeout: 10.0)
    }
    
    func testJSONParserPassCases() {
        let family = getFamilyObject()
        
        XCTAssertNotNil(family)
        
        XCTAssertNotNil(family?.name, "name object is nil")

        XCTAssertNotNil(family?.children, "children object is nil")

        XCTAssertTrue((family?.children?.count)! >= 1, "1 or more children in family")

    }
    
    func testJSONParserFailCases() {
        let family = getFamilyObject()
        
        XCTAssertNil(family)

        XCTAssertNil(family?.name, "name object is nil")
        
        XCTAssertNil(family?.children, "children object is nil")
        
        XCTAssertEqual(family?.children?.count, 0, "No children family")

    }
    
    func getFamilyObject() -> Family? {
        return NSRDataConstructor.parseJSONfrom(data: jsonData!)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
