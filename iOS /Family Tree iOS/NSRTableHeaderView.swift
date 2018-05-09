//
//  NSRTableHeaderView.swift
//  Family Tree iOS
//
//  Created by Nasir Ahmed Momin on 08/05/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import UIKit

let BUTTON_HEIGHT = 45.0

class NSRTableHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var nameSort: UIButton!
    @IBOutlet weak var ageSort: UIButton!
    
    var delegate: SortFamilyMemberProtocol?

    
    @IBAction func sortByName(_ sender: UIButton) {
        delegate?.sortByAge!(sender)
    }
    
    @IBAction func sortByAge(_ sender: UIButton) {
        delegate?.sortByAge!(sender)
    }
}


class NSRHeaderButton: UIView {
    
    @IBOutlet weak var button:          UIButton!
    @IBOutlet weak var orderImageView:  UIImageView!
    
}
