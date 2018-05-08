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
                
                let family = NSRDataConstructor.parseJSONfrom(data: data)
                onCompletion(family)
            }
        }
    }
    
    
    /**
     Parse JSON data using Decodable protocol in app's Family model object
     
     - Parameter data: Raw json data, an insance of Data
     
     - Returns: Family object or nil if parsing fails
    */
    class func parseJSONfrom(data d: Data) -> Family?{
        do {
            let decoder = JSONDecoder()
            let family = try decoder.decode(Family.self, from: d)
            let sortedFamly = NSRDataConstructor.defaultSortOn(family: family)
            print(sortedFamly as Any)
            return sortedFamly
        }
        catch let err {
            print("Error \(err)")
            return nil
        }
    }
    
    /**
     Performs default sorting of family's member by their name
     
     - Parameter family: Family object on whose member has to be sorted.
     
     - Returns: Family object consist of sorted member by their name
     */
    class func defaultSortOn(family : Family?) -> Family? {
        var mutableFamily = family
        let sortedChildren = family?.sortFamilyMemberbyName(ascending: SortStatus.byName)
        mutableFamily?.children = sortedChildren
        return mutableFamily
    }
}




