//
//  NSRDataConstructor.swift
//  FamilyTreemacOS
//
//  Created by Nasir Ahmed Momin on 04/05/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import Foundation

/// A class reponsible for parsing & constructing data into model (Family) object
class NSRDataConstructor: NSObject {
    
    /**
     Constructs Family data by initiating get request call to http API
     
     - Parameter onCompletion : Family model object
     - Parameter family : Model layer consist of family data that need to be displayed on UI
     */
    class func constructFamilyData (_ onCompletion: @escaping (Family?) -> Void) {
        NSRDataFetcher.shared.getRequestData { (data, response, err) in
            print(data!)
            guard let data = data else {
                onCompletion(nil)
                return
            }
            
            guard let httpResponse = response else {
                onCompletion(nil)
                return
            }
            
            if (httpResponse as! HTTPURLResponse).statusCode == 200 {
                // Data is availalbe & status code is valid
                
                do {
                    let decoder = JSONDecoder()
                    let family = try decoder.decode(Family.self, from: data)
                    print(family as Any)
                    onCompletion(family)
                }
                catch let err {
                    print("Error \(err)")
                    onCompletion(nil)
                }
            }
        }
    }
    
}




