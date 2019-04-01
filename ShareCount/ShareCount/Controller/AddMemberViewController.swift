//
//  MemberViewController.swift
//  ShareCount
//
//  Created by Simon Gayet on 24/03/2019.
//  Copyright © 2019 Simon GAYET Quentin FRANCE. All rights reserved.
//

import UIKit
import CoreData

class AddMemberViewController: UIViewController {

    @IBOutlet weak var firstNameLabel: UITextField!
    @IBOutlet weak var lastNameLabel: UITextField!
    @IBOutlet weak var arrivalDatePicker: UIDatePicker!
    @IBOutlet weak var leavingDatePicker: UIDatePicker!
    
    var trip : Trips? = nil
    var member : Members? = nil
    var itsUpdate : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set date in function of end trip date
        if let endDate = trip?.endDate{
            self.leavingDatePicker.date = endDate
        }
        else {
            print("error trip doesn't have end date")
        }
        // set data from detail memberview
        if let member = self.member{
            self.firstNameLabel.text = member.firstName
            self.lastNameLabel.text = member.lastName
            self.arrivalDatePicker.date = member.arrivalDate!
            self.leavingDatePicker.date = member.leavingDate!
            self.itsUpdate = true
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
        let leavingDate = leavingDatePicker.date
        guard (firstName != "") && (lastName != "") else { return }
        if !itsUpdate {
            self.member = Members(context: CoreDataManager.context)
        }
        self.member!.firstName = firstName
        self.member!.lastName = lastName
        self.member!.arrivalDate = arrivalDate
        self.member!.leavingDate = leavingDate
        self.member!.trip = CurrentTrip.sharedInstance
        if itsUpdate {
            CoreDataManager.context.processPendingChanges()
        }
        else {
            CoreDataManager.save()
        }
    
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func actionForUnwindButton(sender: AnyObject) {}
    
    

}
