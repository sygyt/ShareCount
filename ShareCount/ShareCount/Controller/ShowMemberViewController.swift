//
//  ShowMemberViewController.swift
//  ShareCount
//
//  Created by Quentin FRANCE on 29/03/2019.
//  Copyright © 2019 Simon GAYET Quentin FRANCE. All rights reserved.
//

import UIKit

class ShowMemberViewController: UIViewController {
    
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var arrivalDateLabel: UILabel!
    @IBOutlet weak var leaveLabel: UILabel!
    @IBOutlet weak var leaveDateLabel: UILabel!
    
    var trip : Trips? = nil
    var member : Members? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let member = self.member{
            self.firstNameLabel.text = member.firstName
            self.lastNameLabel.text = member.lastName
            let dateFormatter  = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US")
            dateFormatter.timeStyle = .none
            dateFormatter.dateStyle = .medium
            let arrivalDate = member.arrivalDate!
            self.arrivalDateLabel.text = dateFormatter.string(from: arrivalDate)
            if let leavingDate = member.leavingDate {
                 self.leaveDateLabel.text = dateFormatter.string(from: leavingDate)
            }
            else{
                let endtripDate = trip?.endDate ?? Date.init()
                self.leaveDateLabel.text = dateFormatter.string(from: endtripDate)
            }
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

}
