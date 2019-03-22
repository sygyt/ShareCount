//
//  TripsTableViewController.swift
//  ShareCount
//
//  Created by Simon GAYET on 22/03/2019.
//  Copyright © 2019 Simon GAYET Quentin FRANCE. All rights reserved.
//

import Foundation
import UIKit

class TripsTableViewController: NSObject, UITableViewDataSource, UITableViewDelegate{
    
    var trips : [Trips] = []
    var tripsTableView   : UITableView
    init(tableView: UITableView) {
        self.tripsTableView = tableView
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.trips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = self.tripsTableView.dequeueReusableCell(withIdentifier: "tripCellId", for: indexPath) as! TripsTableViewCell
        cell.textLabel?.text = self.trips[indexPath.row].name
        return cell
    }
    
    
    
}
