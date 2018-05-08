//
//  NSRTypes.swift
//  FamilyTreemacOS
//
//  Created by Nasir Ahmed Momin on 07/05/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import Foundation

struct Associatekeys {
    static var toggleState : UInt8 = 0
}

protocol ToggleProtocol {
    func toggle()
}

enum ToggleState {
    case ON
    case OFF
}
