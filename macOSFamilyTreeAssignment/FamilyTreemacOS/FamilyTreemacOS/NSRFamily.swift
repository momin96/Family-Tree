//
//  NSRFamily.swift
//  FamilyTreemacOS
//
//  Created by Nasir Ahmed Momin on 04/05/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import Foundation

/**
 Model object responsible for holding family member's information
 
 - Attention:
 Conforms to Decodable & Comparable protocol.
 
 - Remark:
 1. Decodable parses json data into app's model with Swift's new features,
 2. Comparable to sort family member by their name & age
 
 */
struct Member: Decodable, Comparable {
    
    let name: String? // Nasir
    let age: Int = {
        let n = Int(arc4random_uniform(100))
        return n
    }()
    //    let stature: FamilyStature?
    
    static func <(lhs: Member, rhs: Member) -> Bool {
        return lhs.name?.localizedCaseInsensitiveCompare(rhs.name!) == .orderedAscending
    }
    
    static func ==(lhs: Member, rhs: Member) -> Bool {
        return lhs == rhs
    }
    
}

/**
 Model object responsible for holding individual family's high level information.
 
 - Remark: Decodable parses json data into app's model with Swift's new features,
 
 */
struct Family: Decodable {

    /// Name of family
    let name: String?
    
    /// Children in family
    var children: [Member]?
    
    //    let elders: [Member]?
    //    let address: String?
    //    let familyHead: Member?
    
    /**
     Sort Family members by their names
     - Parameter isAscending: Boolean value indicating order of sort
     */
    func sortFamilyMemberbyName(ascending isAscending : Bool) -> [Member] {
        //        return (children?.sorted())!
        
        return (children?.sorted(by: { (m1, m2) -> Bool in
            return m1.name?.localizedCaseInsensitiveCompare(m2.name!) == (isAscending ? .orderedAscending : .orderedDescending)
        }))!
    }
    
    /**
     Sort Family members by their ages
     - Parameter isAscending: Boolean value indicating order of sort
     */
    func sortFamilyMemberByAge(ascending isAscending : Bool) -> [Member] {
        return (children?.sorted(by: { m1, m2 in
            return isAscending ? (m1.age < m2.age) : (m1.age > m2.age)
        }))!
    }
    
    /**
     Public method to update children in Family
     - Parameter children: Array of children that need to be update in Family
     */
    mutating func updateChildren(_ children: [Member]?) {
        self.children = children
    }
}










//enum FamilyStature: String, Decodable {
//    case GrandFather    = "Grand Father"
//    case GrandMother    = "Grand Mother"
//    case Father         = "Father"
//    case Mother         = "Mother"
//    case Son            = "Son"
//    case Dauther        = "Dauther"
//    case SonInLaw       = "Son In Law"
//    case DautherInLaw   = "Dauther In Law"
//    case Cousin         = "Cousin"
//    case Friend         = "Friend"
//    case Other          = "Other"
//}


// NSRFamily was intendent to use for Cocoa bindings

//@objc class NSRFamily: NSObject {
//
//    @objc dynamic var name: String?
//    @objc dynamic var address: String?
////    @objc dynamic var familyHead: NSRMember?
//    @objc dynamic var children: [NSRMember]?
////    @objc dynamic var elders: [NSRMember]?
//
//
//    init(name : String, children: [Member]) {
//        self.name = name
//
//        var members : [NSRMember] = []
//        for m in children {
//            let member = NSRMember(name: m.name, age: m.age)
//            members.append(member)
//        }
//
//        self.children = members
//    }
//
//
////    init(name: String, address: String, familyHead: Member, children: [Member], elders: [Member]) {
////        self.name = name
////        self.address = address
////        self.familyHead = familyHead
////        self.children = children
////        self.elders = elders
////    }
//
//}

//@objc class NSRMember: NSObject {
//    @objc dynamic var name: String?
//    @objc dynamic var age: Int = 0
////    @objc dynamic var stature: FamilyStature?
//
//
//    init(name: String?, age: Int) {
//        self.name = name
//        self.age = age
//    }
//}

