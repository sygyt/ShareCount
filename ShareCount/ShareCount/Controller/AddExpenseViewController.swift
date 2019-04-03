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

class AddExpenseViewController: UIViewController, UITextFieldDelegate{

    var memberTableViewController: MemberParticipateTableViewController!
    var total : Double = 0
    let datePicker = UIDatePicker()
    
    
    //MARK: - Outlets
    @IBOutlet weak var confirmButton: UIButton!
    
    @IBOutlet weak var nameExpenseTextField: UITextField! {
        didSet {
            self.nameExpenseTextField.addDoneCancelToolbar()
        }
    }
    @IBOutlet weak var expenseDatePickerLabel: UITextField!
    @IBOutlet weak var memberParticipateTableView: UITableView!
    @IBOutlet weak var totalLabel: UILabel!
    
    
    /// Called when view is Loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        self.disableConfirm()
        self.showDatePicker()
        self.memberTableViewController = MemberParticipateTableViewController(tableView: self.memberParticipateTableView)
        self.datePicker.minimumDate = CurrentTrip.sharedInstance?.beginDate
        self.datePicker.maximumDate = CurrentTrip.sharedInstance?.endDate
        self.totalLabel.text = String(total) + "$"
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Text Field Delegate Function
    
    
    
    @IBAction func participationTextFieldBeingEdit(_ sender: UITextField) {
        self.total += -(Double(sender.text ?? "0") ?? 0)
        
    }
    
    
    @IBAction func participationTextFieldEndEdit(_ sender: UITextField, forEvent event: UIEvent) {
        self.total += (Double(sender.text ?? "0") ?? 0)
        self.totalLabel.text = String(total) + "$"
        testForm()
        
    }
    
    @IBAction func dateTextFieldEndEdit(_ sender: Any) {
        testForm()
    }
    
    @IBAction func nameTextFieldEndEdit(_ sender: Any) {
        testForm()
    }
    
    @IBAction func receiveTextFieldEndEdit(_ sender: Any) {
        testForm()
    }
    
    @IBAction func divideButton(_ sender: Any) {
        memberTableViewController.doDivide(total: Double(self.total))
        testForm()
    }
    
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
       
        
        if self.memberTableViewController.isCorectTotal() && self.memberTableViewController.hasParticiper() {
            
            let name = nameExpenseTextField.text ?? ""
            let date = expenseDatePickerLabel.text ?? ""
            if ((name != "") && (date != ""))  {
                let expense = Expense(context: CoreDataManager.context)
                expense.nameExpense = name
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                expense.dateExpense = dateFormatter.date(from: date)
                print(expense.nameExpense)
                CoreDataManager.save()
                memberTableViewController.addParticipate(expense: expense)
            }
        }
    }
    
    //MARK : - Helpers Methods -
    
    func testForm(){
        if let nameExpense = nameExpenseTextField.text, let dateExpense = expenseDatePickerLabel.text{
            if(self.memberTableViewController.isCorectTotal() && self.memberTableViewController.hasParticiper() && !nameExpense.isEmpty && !dateExpense.isEmpty && self.total != 0.0){
                enableConfirm()
            } else {
                disableConfirm()
            }
        }
        else {
            disableConfirm()
        }
        
    }
    
    func enableConfirm(){
        self.confirmButton.isEnabled = true
        self.confirmButton.setTitleColor(UIColor(red: 63/255, green: 81/255, blue: 181/255, alpha: 1)
, for: UIControl.State.normal)
    }
    
    func disableConfirm(){
        self.confirmButton.isEnabled = false
        self.confirmButton.setTitleColor(UIColor.gray, for: UIControl.State.normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        memberParticipateTableView.reloadData()
        self.viewDidLoad()
    }

    
}
