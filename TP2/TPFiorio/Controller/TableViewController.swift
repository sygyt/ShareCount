//
//  TableViewController.swift
//  TPFiorio
//
//  Created by Quentin FRANCE on 19/03/2019.
//  Copyright © 2019 Quentin FRANCE. All rights reserved.
//
import Foundation
import UIKit
import CoreData

class TableViewController: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var PersonSetData : ViewModelPersonSet
    override init() {

        self.PersonSetData = ViewModelPersonSet.init()
        super.init()
    }

    // MARK: - Table view data source
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PersonSetData.countNbPerson()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idCell", for: indexPath)
        if let rw : String =  PersonSetData.getPersonFullName(index: indexPath.row){
                cell.textLabel?.text = rw
        }
        else{
            cell.textLabel?.text = " "
        }
        return cell
    }
    
    

}
