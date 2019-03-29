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

class ExpensesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var expenses : [Expense] = []
    var expenseFetchResultController : ExpenseFetchResultController!
    
    //TableView Controller that display the collection of Expenses
    @IBOutlet weak var expensesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.expenseFetchResultController = ExpenseFetchResultController(tableView: self.expensesTableView)
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
    
    
}

