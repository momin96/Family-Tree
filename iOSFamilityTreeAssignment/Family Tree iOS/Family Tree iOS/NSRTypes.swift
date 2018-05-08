//
//  NSRTypes.swift
//  FamilyTreemacOS
//
//  Created by Nasir Ahmed Momin on 07/05/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import Foundation

// This swift file is going to keep globally used types through out app


/// Here it maintains most of keys for storage property to be used inside swift's extension.
struct Associatekeys {
    static var toggleState : UInt8 = 0
}

/// An insance who confirms this protocol will implemented On & Off state
protocol ToggleProtocol {
    func toggle()
}

/// enum to state On & Off state of an instance
enum ToggleState {
    case ON
    case OFF
}
