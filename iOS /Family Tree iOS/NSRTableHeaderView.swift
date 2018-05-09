//
//  NSRTableHeaderView.swift
//  Family Tree iOS
//
//  Created by Nasir Ahmed Momin on 08/05/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import UIKit

let BUTTON_HEIGHT = 45.0

/**
 This class is responsible for rendering Header view for table
 */
class NSRTableHeaderView: UITableViewHeaderFooterView {

    /// title for table view
    @IBOutlet weak var headerTitle: UILabel!
    
    /// Sort by Name button
    @IBOutlet weak var nameSort: UIButton!
    
    /// Sort by Age button
    @IBOutlet weak var ageSort: UIButton!
    
    /// An instance to perform sorting operation via delegate to class who confirms it.
    var delegate: SortFamilyMemberProtocol?

    
    // MARK: Target Action methods
    
    /**
     Perform sort operation Member's Name
     
     - Parameter sender: An instance to hold status like selected & any others
     */
    @IBAction func sortByName(_ sender: UIButton) {
        delegate?.sortByAge!(sender)
    }
    
    /**
     Perform sort operation Member's age

     - Parameter sender: An instance to hold status like selected & any others
     */
    @IBAction func sortByAge(_ sender: UIButton) {
        delegate?.sortByAge!(sender)
    }
}

