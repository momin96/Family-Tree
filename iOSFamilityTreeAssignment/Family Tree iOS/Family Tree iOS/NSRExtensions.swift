//
//  NSRExtensions.swift
//  FamilyTreemacOS
//
//  Created by Nasir Ahmed Momin on 07/05/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import Foundation
import UIKit

// This swift file is going to keep most of commonly used extenstion on defined types

/**
 Extension on UIBarButtonItem to hold toggle state of button
 */
extension UIBarButtonItem: ToggleProtocol {
    
    func toggle() {
        toggleState = toggleState == .ON ? .OFF : .ON
    }
    
    var toggleState: ToggleState {
        get {
            guard let state = objc_getAssociatedObject(self, &Associatekeys.toggleState) as? ToggleState else {
                return .OFF
            }
            return state
        }
        set (newValue){
            objc_setAssociatedObject(self, &Associatekeys.toggleState, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    /// Performs invert operation on its intance's call
    func invert() {
        self.toggleState = toggleState == .ON ? .OFF : .ON
    }
    
}
