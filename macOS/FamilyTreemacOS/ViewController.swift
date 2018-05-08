//
//  ViewController.swift
//  FamilyTreemacOS
//
//  Created by Nasir Ahmed Momin on 04/05/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

let SORT_BY_NAME    = "Sort By Name"
let SORT_BY_AGE     = "Sort By Age"

import Cocoa

class ViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {
    
    var family : Family?
    
    @IBOutlet weak var familyTableView: NSTableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.familyTableView.dataSource = self
        self.familyTableView.delegate = self
        
        NSRDataConstructor.constructFamilyData { (family) in
            self.family = family
            OperationQueue.main.addOperation({
                self.familyTableView.reloadData()
            })
        }
        
        
        let sortByName = NSSortDescriptor(key: "name", ascending: SortStatus.byName)
        let sortByAge = NSSortDescriptor(key: "age", ascending: SortStatus.byAge)
        familyTableView.tableColumns[0].sortDescriptorPrototype = sortByName
        familyTableView.tableColumns[1].sortDescriptorPrototype = sortByAge
        
        familyTableView.sortDescriptors = [sortByName, sortByAge]
        
        
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        if let f = self.family, let c = f.children {
            return c.count
        }
        return 0
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        
        if let children = self.family?.children  {
            let child = children[row]
            let name = child.name
            let age = child.age
        
            if tableColumn == tableView.tableColumns[0] {
                return name
            }
            else if tableColumn == tableView.tableColumns[1] {
                return age
            }
        }
        
        return nil
    }
    
    func tableView(_ tableView: NSTableView, sortDescriptorsDidChange oldDescriptors: [NSSortDescriptor]) {
        
        if tableView.selectedColumn == 0 {
            let sortedChildren = self.family?.sortFamilyMemberbyName(ascending: (oldDescriptors.first?.ascending)!)
            reloadTableViewWith(children: (sortedChildren)!)
        }
        else if tableView.selectedColumn == 1 {
            let sortedChildren = self.family?.sortFamilyMemberByAge(ascending: (oldDescriptors.first?.ascending)!)
            reloadTableViewWith(children: (sortedChildren)!)
        }
    }
    
    func reloadTableViewWith(children cd : [Member]) {
        self.family?.updateChildren(cd)
        self.familyTableView.reloadData()
    }
    
    // MARK: Target Action Methods
    @IBAction func sortChildrenByName(_ sender : NSButton) {
      
        let ascending : Bool = sender.toggleState == ToggleState.OFF ? false : true
        
        let sortedChildren = self.family?.sortFamilyMemberbyName(ascending: ascending)
  
        self.family?.updateChildren(sortedChildren)
        
        self.familyTableView.reloadData()

        sender.invert()
    }
    
    @IBAction func sortChildrenByAge(_ sender : NSButton) {
        
        let ascending : Bool = sender.toggleState == ToggleState.OFF ? false : true
        
        let sortedChildren = self.family?.sortFamilyMemberByAge(ascending: ascending)
        
        self.family?.updateChildren(sortedChildren)
        
        self.familyTableView.reloadData()
        
        sender.invert()
    }
}

