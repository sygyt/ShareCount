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
        member.trip = CurrentTrip.sharedInstance
    
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
