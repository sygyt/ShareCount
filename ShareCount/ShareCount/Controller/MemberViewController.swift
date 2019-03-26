//
//  MemberViewController.swift
//  ShareCount
//
//  Created by Simon Gayet on 24/03/2019.
//  Copyright © 2019 Simon GAYET Quentin FRANCE. All rights reserved.
//

import UIKit
import CoreData

class MemberViewController: UIViewController {

    @IBOutlet weak var firstNameLabel: UITextField!
    @IBOutlet weak var lastNameLabel: UITextField!
    @IBOutlet weak var arrivalDatePicker: UIDatePicker!
    var trip : Trips? = nil
    var member : Members? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let member = self.member{
            self.firstNameLabel.text = member.firstName
            self.lastNameLabel.text = member.lastName
            //ajouter la date
        }
    }
    
    /// Add button controller
    ///
    /// - Parameter sender: <#sender description#>
    @IBAction func addMemberButton(_ sender: Any) {
        let firstName = firstNameLabel.text ?? ""
        let lastName = lastNameLabel.text ?? ""
        let arrivalDate = arrivalDatePicker.date
        guard (firstName != "") && (lastName != "") else { return }
        let member = Members(context: CoreDataManager.context)
        member.firstName = firstName
        member.lastName = lastName
        member.arrivalDate = arrivalDate
        
        //self.saveNewMember(firstName: firstName, lastName: lastName, arrivalDate: arrivalDate)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func actionForUnwindButton(sender: AnyObject) {
        print("actionForUnwindButton");
    }
    
    
    //MARK: - Trips management -
    /// Saves the trip in the CoreData
    ///
    /// - Parameter name: The name of the trip
    func saveNewMember(firstName: String?,lastName: String?,arrivalDate: Date) {
        guard let context = self.getContext(errorMsg: "Could not load data") else {return}
        // création ogjet trip
        let member = Members(context: context)
        //modifier le nom
        member.firstName = firstName
        member.lastName = lastName
        member.arrivalDate = arrivalDate
        member.trip = self.trip
        do{
            try context.save()
            //affect new value to label?
            //ask tableView controller to reload data?
        }
        catch let error as NSError{
            self.alert(error: error)
            return
        }
    }
    
    
    /// Get the context
    ///
    /// - Parameters:
    ///   - errorMsg: <#errorMsg description#>
    ///   - userInfoMsg: <#userInfoMsg description#>
    /// - Returns: <#return value description#>
    func getContext(errorMsg : String, userInfoMsg: String = "Could not retrieve data context") -> NSManagedObjectContext?{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            self.alert(withTitle: errorMsg, andMessage: userInfoMsg)
            return nil
        }
        return appDelegate.persistentContainer.viewContext
    }
    
    /// Show an alert with two messages
    ///
    /// - Parameters:
    ///   - title: <#title description#>
    ///   - msg: <#msg description#>
    func alert(withTitle title : String, andMessage msg : String = ""){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title:"Ok",
                                         style: .default)
        alert.addAction(cancelAction)
        present(alert, animated:true)
    }
    
    /// Show an alert of the error in parameter
    ///
    /// - Parameter error: <#error description#>
    func alert(error: NSError){
        self.alert(withTitle: "\(error)", andMessage:"\(error.userInfo)")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        if let text = textField.text{
            if text != ""{
                textField.resignFirstResponder()
                return true
            }
        }
        return false
        
    }
    
    

}
