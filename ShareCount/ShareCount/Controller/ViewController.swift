//
//  ViewController.swift
//  ShareCount
//
//  Created by Simon GAYET on 22/03/2019.
//  Copyright © 2019 Simon GAYET Quentin FRANCE. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var tableViewController: TripsTableViewController!
    @IBOutlet weak var TripsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.tableViewController = TripsTableViewController(tableView: self.tableView)
        // Do any additional setup after loading the view, typically from a nib.
    }


}

