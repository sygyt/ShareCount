//
//  ShowExpenseViewController.swift
//  ShareCount
//
//  Created by Simon Gayet on 02/04/2019.
//  Copyright © 2019 Simon GAYET Quentin FRANCE. All rights reserved.
//

import UIKit

class ShowExpenseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    

    @IBOutlet weak var nameExpense: UILabel!
    @IBOutlet weak var dateExpense: UILabel!
    @IBOutlet weak var participerTableView: UITableView!
    @IBOutlet weak var costLabel: UILabel!
    
    var participateViewModel : ParticipateSetViewModel!
    
    var expense : Expense? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let expense = self.expense{
            self.nameExpense.text = expense.nameExpense
            let dateFormatter  = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US")
            dateFormatter.timeStyle = .none
            dateFormatter.dateStyle = .medium
            let arrivalDate = expense.dateExpense!
            self.dateExpense.text = dateFormatter.string(from: arrivalDate)

            self.participateViewModel = ParticipateSetViewModel(data: expense.participates?.allObjects as! [Participate])
            self.participerTableView.delegate = self
            self.participerTableView.dataSource = self
            
            self.costLabel.text = String(participateViewModel.getCost()) + " $"
        }

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.participateViewModel.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "showExpenseCell", for: indexPath) as! MemberPaticipateTableViewCell
        print(cell)
        if let participate = self.participateViewModel.get(personAt: indexPath.row){
            print( participate.memberParticipate!)
            cell.configure(member: participate.memberParticipate!)
            print(participate.amountParticipate)
            cell.participationLabel.text = String(participate.amountParticipate)
            cell.participationLabel.textColor = UIColor.red
            print(participate.amountReceive)
            cell.receiveLabel.text = String(trunc(x:participate.amountReceive))
            cell.receiveLabel.textColor = UIColor.green
        }
        return cell
    }

    
    // MARK : - Helper methods -
    /// Truncate the double to 2 decimals
    ///
    /// - Parameter x: x double to truncate
    func trunc(x:Double) -> Double{
        return Double(round(100*x)/100)
    }
}
