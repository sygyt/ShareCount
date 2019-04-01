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
    
    
    
    var tableView : UITableView
    var memberViewModel : MemberSetViewModel!
    let fetchResultController : MembersFetchResultController
    
    init(tableView: UITableView) {
        
        self.tableView = tableView
        self.fetchResultController = MembersFetchResultController(tableView : tableView)
        super.init()
        self.memberViewModel = MemberSetViewModel(data: self.fetchResultController.membersFetched.fetchedObjects!, delegate : self)
        self.tableView.dataSource = self
        self.memberViewModel.delegate = self
        self.tableView.delegate = self
        
    }
    

    //MARK: - TableView delegate
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction{
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            //on supprime la personne de la table
            self.memberDeleted(at: indexPath)
            self.memberViewModel.delete(personAt: indexPath.row)
            completion(true)
        }
        let logotrash = UIImage(named: "Trash")
        action.image = logotrash
        action.backgroundColor = UIColor.red
        return action
    }
    
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.memberViewModel.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memberParticipateCell", for: indexPath) as! MemberPaticipateTableViewCell
        if let member = self.memberViewModel.get(personAt: indexPath.row){
            cell.configure(member: member)
        }
        return cell
    }
    
    
    
    
    // add function
    
    func isCorectTotal() -> Bool {
        var totalParticipation : Int16 = 0
        var totalReceive : Int16 = 0
        
        let lenth = self.tableView.numberOfRows(inSection: 1)
        let cells = tableView.visibleCells
        for i in 0..<lenth {
            let cell = cells[i] as! MemberPaticipateTableViewCell
            totalParticipation += cell.getParticipation()
            totalReceive += cell.getReveive()
        }
        return (totalParticipation == totalReceive)
    }
    

    func addParticipate(expense: Expense) {
        let lenth = self.tableView.numberOfRows(inSection: 1)
        let cells = tableView.visibleCells
        for i in 0..<lenth {
            let cell = cells[i] as! MemberPaticipateTableViewCell
            let participate = Participate(context: CoreDataManager.context)
            participate.amountParticipate = cell.getParticipation()
            participate.amountReceive = cell.getReveive()
            participate.memberParticipate = self.memberViewModel.get(personAt: i)
            participate.expenseParticipe = expense
            
        }
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
