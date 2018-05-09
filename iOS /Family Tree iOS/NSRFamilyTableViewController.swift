//
//  NSRFamilyTableViewController.swift
//  Family Tree iOS
//
//  Created by Nasir Ahmed Momin on 07/05/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import UIKit

let HEADER_NIB = "headerNib"

enum SortByItem: String {
    case byName = "SortByName"
    case byAge = "SortByAge"
}

/**
 TableViewController responsible for asking data from model layer & then displaying Family member's data in View layer.
 
 Top right navigation item stack consist of two instance of UIBarButtonItem for sorting by name & age of family member
 
 - Warning: This class cannot have custom User interface as it is derived from UITableViewController
 */
class NSRFamilyTableViewController: UITableViewController {
    
    /// Storyboard's connection to UITableView
    @IBOutlet weak var familyTableView: UITableView!
    
    /// Model object, Consist of family's data
    private var family: Family?
    
    // TableCell's unique identifier
    private let cellId = "childCell"
    
    private var headerView: NSRTableHeaderView?
    
    // MARK: View life Cycle
    deinit {
        print("deinit of NSRFamilyTableViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerHeaderNib()
        
        initiateFamilyDataConstruction()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("didReceiveMemoryWarning in NSRFamilyTableViewController")
    }
    
    //MARK: Initial setup functions
    
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
    
    
    /**
     Register the table view header
     */
    func registerHeaderNib() {
        headerView = Bundle.main.loadNibNamed("NSRTableHeaderView", owner: self, options: nil)?.first as? NSRTableHeaderView
    }
    
}

/// Extension to seperate User interface implementation with contoller's logic
extension NSRFamilyTableViewController {
    
    // MARK: TableView DataSource Methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let c = family?.children {
            return c.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)!
        
        if let children = family?.children {
            let child = children[indexPath.row]
            if let n = child.name {
                cell.textLabel?.text = (String(describing: n))
            }
            else {
                cell.textLabel?.text = " "
            }
            cell.detailTextLabel?.text = String(describing: child.age)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let f = family, let n = f.name {
            headerView?.headerTitle.text = n
        }
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if headerView != nil {
            return 60.0
        }
        return 0;
    }
}

extension NSRFamilyTableViewController: SortFamilyMemberProtocol {
    
    /**
     Performs sorting of instance of Member by their names
     
     - Parameter sender: Instance of UIBarButtonItem which keeps state of order of sorting, eg: Ascending or Descending
     */
    func sortByName(_ sender: Any) {
        
        showArrowForButton(.byName)
        
        let nameButton : UIButton = sender as! UIButton
        
        let ascending : Bool = nameButton.isSelected
        
        let sortedChildren = self.family?.sortFamilyMemberbyName(ascending: ascending)
        
        reloadTableViewWithMember(sortedChildren)
        
        updateSortIconFor(button: nameButton, ascending: ascending)
        
        nameButton.isSelected = !nameButton.isSelected
    }
    
    /**
     Performs sorting of instance of Member by their ages
     
     - Parameter sender: Instance of UIBarButtonItem which keeps state of order of sorting, eg: Ascending or Descending
     */
    func sortByAge(_ sender: Any) {
        
        showArrowForButton(.byAge)
        
        let ageButton : UIButton = sender as! UIButton
        
        let ascending : Bool = ageButton.isSelected
        
        let sortedChildren = self.family?.sortFamilyMemberByAge(ascending: ascending)
        
        reloadTableViewWithMember(sortedChildren)
        
        updateSortIconFor(button: ageButton, ascending: ascending)
        
        ageButton.isSelected = !ageButton.isSelected
        
    }
    
    // MARK: Helper functions
    
    /**
     Update family's member's order & reloads table view with latest member's data
     
     - Parameter members: List of member whose position needs to be arranged after sorting
     */
    func reloadTableViewWithMember(_ sortedMember: [Member]?) {
        self.family?.updateChildren(sortedMember)
        self.familyTableView.reloadData()
    }
    
    /**
     Updates the arrow_up or arrow_down icon on currently selected button, by ascending or descending order
     
     - Parameter sender: Currently selected button whose icons will be updated
     - Parameter ascending: Flag to indicate order is ascending or desending
     */
    func updateSortIconFor(button sender: UIButton, ascending: Bool) {
        let image = UIImage(named: ascending ? "arrow_up" : "arrow_down")
        let status : UIControlState = ascending ? .normal : .selected
        sender.setImage(image, for: status)
    }
    
    /**
     Remove the arrow icon from other button other than current selected
     
     - Parameter item: Tell currently which button is selected
     */
    func showArrowForButton(_ item: SortByItem) {
        
        switch item {
        case .byAge:
            let nameSortButton = headerView?.nameSort
            nameSortButton?.setImage(nil, for: .normal)
            nameSortButton?.setImage(nil, for: .selected)
            break
        case .byName:
            let ageSortButton = headerView?.ageSort
            ageSortButton?.setImage(nil, for: .normal)
            ageSortButton?.setImage(nil, for: .selected)
            break
        }
    }
}
