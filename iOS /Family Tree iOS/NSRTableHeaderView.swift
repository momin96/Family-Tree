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

    
//    override func draw(_ rect: CGRect) {
      /*
        let nameRect: CGRect = CGRect(x: 0, y: headerTitle.bounds.height, width: self.bounds.width / 2, height: BUTTON_HEIGHT)
        let ageRect: CGRect = CGRect(x: self.bounds.width / 2, y: headerTitle.bounds.height,, width: self.bounds.width / 2, height: BUTTON_HEIGHT) as!
        
        let nameButtonView = NSRHeaderButton(frame: nameRect)
        self.addSubview(nameButtonView)
        
        
        let ageButtonView = NSRHeaderButton(frame: ageRect)
        self.addSubview(ageButtonView)
        */
//    }
}


class NSRHeaderButton: UIView {
    
    @IBOutlet weak var button:          UIButton!
    @IBOutlet weak var orderImageView:  UIImageView!
    
}
