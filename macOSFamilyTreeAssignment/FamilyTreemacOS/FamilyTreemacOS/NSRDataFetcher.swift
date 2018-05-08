//
//  NSRDataFetcher.swift
//  FamilyTreemacOS
//
//  Created by Nasir Ahmed Momin on 04/05/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import Foundation

let API_ENDPOINT = "http://www.mocky.io/v2/5aa703fe2f000098008ea42b"

/**
 NSRDataFetcher is responsible for setting up session, initilizing session & performing request call, (GET, POST, PUT, DELETE).
 
 - important: This is call is not meant for parsing, it just download or upload Data/Files for app
 */
class NSRDataFetcher: NSObject {

    /// Singleton object entire app use only one object to maintain network session
    static let shared = NSRDataFetcher()
    
    /// global session object to used by multiple functions to initiate network session
    let session : URLSession
    
    override private init() {
        print("Init")
        session = URLSession.shared
    }
    
    /**
     Initiates get request & fetches the raw data,
     
     - Parameter completionHandler: Perform call backs on consumption of API call
     - Parameter data: Raw data, instance of optional Data
     - Parameter urlResponse: instance of URLResponse consist of status code, cache policy, content-type etc after conversion into instance of URLHTTPResponse
     - Parameter error: Error codes & reason for error occured
     
     */
    func getRequestData(_ completionHandler : @escaping (Data?, URLResponse?, Error?) -> Void) {
        let url = URL(string : API_ENDPOINT)!
        print("Get data \(session), \(url)")
        
        session.dataTask(with: url) { (data, response, err) in
            print("response \(String(describing: response))")
            completionHandler(data, response, err)
            }.resume()
    }
    
}
