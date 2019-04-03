//
//  MemberParticipateTableViewController.swift
//  ShareCount
//
//  Created by Simon Gayet on 01/04/2019.
//  Copyright © 2019 Simon GAYET Quentin FRANCE. All rights reserved.
//

import UIKit
import CoreData

class MemberParticipateTableViewController: NSObject, UITableViewDataSource, UITableViewDelegate, MemberSetViewModelDelegate {
    
    
    
    /// The table view
    var tableView : UITableView
    
    
    /// The member view model
    var memberViewModel : MemberSetViewModel!
    
    /// The fetch result controller
    let fetchResultController : MembersFetchResultController
    
  
    /// Method called at initialization of the class
    ///
    /// - Parameter tableView: <#tableView description#>
    init(tableView: UITableView) {
        self.tableView = tableView
        self.fetchResultController = MembersFetchResultController(tableView : tableView)
        super.init()
        self.memberViewModel = MemberSetViewModel(data: self.fetchResultController.membersFetched.fetchedObjects!, delegate : self)
        self.tableView.dataSource = self
        self.memberViewModel.delegate = self
        self.tableView.delegate = self
        
        
    }
    

    //MARK: - TableView delegate -
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction{
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            //on supprime la personne de la table
            
            self.memberDeleted(at: indexPath)
            self.memberViewModel.delete(personAt: indexPath.row)
            self.tableView.reloadData()
            completion(true)
        }
        let logotrash = UIImage(named: "Trash")
        action.image = logotrash
        action.backgroundColor = UIColor.red
        return action
    }
    
    // MARK: - Table view data source -

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.memberViewModel.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memberParticipateCell", for: indexPath) as! AddMemberParticipateTableViewCell
        if let member = self.memberViewModel.get(personAt: indexPath.row){
            cell.configure(member: member)
        }
        return cell
    }
    
    // MARK: - Operators -
    
    // divide func nb: not correct form
    // shame on this func
    func doDivide( total: Double){
        let cells = tableView.visibleCells
        let size = cells.count
        let sharedValue = total/Double(size)
        for i in 0..<size {
            let cell = cells[i] as! AddMemberParticipateTableViewCell
            cell.receiveTF.text = String(sharedValue)
        }

    }
    
    // add function
    
    func isCorectTotal() -> Bool {
        var totalParticipation : Double = 0
        var totalReceive : Double = 0
        
        let cells = tableView.visibleCells
        let size = cells.count
        for i in 0..<size {
            let cell = cells[i] as! AddMemberParticipateTableViewCell
            totalParticipation += cell.getParticipation()
            totalReceive += cell.getReveive()
        }
        return (totalParticipation == totalReceive)
    }
    
    func hasParticiper() -> Bool {
        let size = tableView.visibleCells.count
        return (size != 0)
    }
    

    func addParticipate(expense: Expense) {
        
        let cells = tableView.visibleCells
        let size = cells.count
        for i in 0..<size {
            let cell = cells[i] as! AddMemberParticipateTableViewCell
            print(cell.nameLabel)
            if (cell.getParticipation() != 0 || cell.getReveive() != 0) {
                let participate = Participate(context: CoreDataManager.context)
                participate.amountParticipate = cell.getParticipation()
                participate.amountReceive = cell.getReveive()
                participate.memberParticipate = self.memberViewModel.get(personAt: i)
                participate.expenseParticipe = expense
            }
        }
        CoreDataManager.save()
    }
    
    
    func dataSetChanged() {
        
    }
    
    func memberDeleted(at indexPath: IndexPath) {
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
    
    func memberUpdated(at indexPath: IndexPath) {
        
    }
    
    func memberAdded(at indexPath: IndexPath) {
        
    }
   
}
