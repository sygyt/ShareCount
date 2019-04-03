//
//  ExpensesViewController.swift
//  ShareCount
//
//  Created by Quentin FRANCE on 29/03/2019.
//  Copyright © 2019 Simon GAYET Quentin FRANCE. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ExpenseSetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var expenseFetchResultController : ExpenseFetchResultController!
    
    //TableView Controller that display the collection of Expenses
    @IBOutlet weak var expensesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.expenseFetchResultController = ExpenseFetchResultController(tableView: self.expensesTableView)
        self.expensesTableView.dataSource = self
        self.expensesTableView.delegate = self
    }
    
    //MARK: - TableView delegate
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction{
        let expense = self.expenseFetchResultController.expensesFetched.object(at: indexPath)
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            CoreDataManager.context.delete(expense)
            completion(true)
        }
        let logotrash = UIImage(named: "Trash")
        action.image = logotrash
        action.backgroundColor = UIColor.red
        return action
    }
    
    //MARK: - TableView data source protocol -
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = self.expenseFetchResultController.expensesFetched.sections?[section] else {
            fatalError("unexpected section number")
        }
        return section.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = self.expensesTableView.dequeueReusableCell(withIdentifier: "expenseCell", for: indexPath) as!ExpenseTableViewCell
        let expense = self.expenseFetchResultController.expensesFetched.object(at: indexPath)
        
        if let name = expense.nameExpense {
            cell.nameLabel.text = name
        }
        return cell
    }
    
    //MARK : - Navigation methods -
    
    let segueShowExpenseId = "showExpense"
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == self.segueShowExpenseId{
            if let indexPath = self.expensesTableView.indexPathForSelectedRow{
                let destController = segue.destination as! ShowExpenseViewController
                destController.expense = self.expenseFetchResultController.expensesFetched.object(at: indexPath)
                self.expensesTableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }
    
    @IBAction func unwindToShowExpenses(sender: UIStoryboardSegue) {}
    
    
}

