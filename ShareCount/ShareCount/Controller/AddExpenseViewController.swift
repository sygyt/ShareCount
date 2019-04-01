//
//  AddExpenseViewController.swift
//  ShareCount
//
//  Created by Simon Gayet on 01/04/2019.
//  Copyright © 2019 Simon GAYET Quentin FRANCE. All rights reserved.
//
import Foundation
import UIKit
import CoreData

class AddExpenseViewController: UIViewController{

    var memberTableViewController: MemberParticipateTableViewController!
    
    @IBOutlet weak var nameExpenseTextField: UITextField!
    @IBOutlet weak var expenseDatePickerLabel: UITextField!
    @IBOutlet weak var memberParticipateTableView: UITableView!
    
    
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showDatePicker()
        self.memberTableViewController = MemberParticipateTableViewController(tableView: self.memberParticipateTableView)
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
    
    
    // MARK: - Date Picker
    
    func showDatePicker(){
        
        
        datePicker.datePickerMode = .date
        
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        expenseDatePickerLabel.inputAccessoryView = toolbar
        expenseDatePickerLabel.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        expenseDatePickerLabel.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    @IBAction func addExpense(_ sender: Any) {
        print("in add")
        if self.memberTableViewController.isCorectTotal() {
            print("in total")
            let name = nameExpenseTextField.text ?? ""
            let date = expenseDatePickerLabel.text ?? ""
            guard (name != "") && (date != "") else { return }
            let expense = Expense(context: CoreDataManager.context)
            expense.nameExpense = name
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            expense.dateExpense = dateFormatter.date(from: date)
            CoreDataManager.save()
            memberTableViewController.addParticipate(expense: expense)
        }
    }

}