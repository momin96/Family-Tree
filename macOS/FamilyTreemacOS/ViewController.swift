//
//  ViewController.swift
//  FamilyTreemacOS
//
//  Created by Nasir Ahmed Momin on 04/05/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import Cocoa

/**
 This class responsible for asking data from model layer & then displaying Family member's data in View layer.
 
 Sets up table views data source & delegate
 
 Sets up default sort operation by family member's name
 */
class ViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {
    
    /// Model object which holds the information of family that needs to dispaly on UI
    var family : Family?
    
    /// Outlet connection to storyboard's NSTableView
    @IBOutlet weak var familyTableView: NSTableView!
    
    
    // MARK: View Life Cycle functions
    deinit {
        print("deinit of ViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableViewDataSourceAndDelegate()
        
        setDefaultSortOperationOnTableView()
        
        initiateFamilyDataConstruction()
        
    }
    
    //MARK: Initial setup functions
    
    /**
     Sets up data source & delegate functions for familyTableView
    */
    func setupTableViewDataSourceAndDelegate () {
        self.familyTableView.dataSource = self
        self.familyTableView.delegate = self
    }
    
    /**
     Sets up default sort operation on family's member's data by their names
     */
    func setDefaultSortOperationOnTableView () {
        
        let sortByName = NSSortDescriptor(key: "name", ascending: SortStatus.byName)
        let sortByAge = NSSortDescriptor(key: "age", ascending: SortStatus.byAge)
        familyTableView.tableColumns[0].sortDescriptorPrototype = sortByName
        familyTableView.tableColumns[1].sortDescriptorPrototype = sortByAge
        
        familyTableView.sortDescriptors = [sortByName, sortByAge]
    }
    
    /**
     Initiates construction of family model object
     */
    func initiateFamilyDataConstruction () {
        
        NSRDataConstructor.constructFamilyData { (family) in
            self.family = family
            OperationQueue.main.addOperation({
                self.familyTableView.reloadData()
            })
        }
    }
}

extension ViewController {
    
    // MARK: Table View's Data source & Delegate functions
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
            let sortedChildren = self.family?.sortFamilyMemberbyName(ascending: !(oldDescriptors.first?.ascending)!)
            reloadTableViewWith(children: (sortedChildren)!)
        }
        else if tableView.selectedColumn == 1 {
            let sortedChildren = self.family?.sortFamilyMemberByAge(ascending: (oldDescriptors.first?.ascending)!)
            reloadTableViewWith(children: (sortedChildren)!)
        }
    }
    
    
    // MARK: Helper functions
    
    /**
     Update family's children's order & reloads table view with latest children data
     
     - Parameter children: List of child whose position needs to be arranged after sorting
     */
    func reloadTableViewWith(children cd : [Member]) {
        self.family?.updateChildren(cd)
        self.familyTableView.reloadData()
    }
}
