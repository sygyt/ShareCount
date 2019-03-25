//
//  ShowTripViewController.swift
//  ShareCount
//
//  Created by Simon Gayet on 23/03/2019.
//  Copyright © 2019 Simon GAYET Quentin FRANCE. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ShowTripViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var membersTableView: UITableView!
    @IBOutlet weak var nameTripLabel: UILabel!
    var fetchResultController : MembersFetchResultController!
    
    var trip : Trips? = nil
    var members : [Members] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //affect setected trip to label
        if let atrip = self.trip{
            self.nameTripLabel.text = atrip.name
        }
        
//        //load members from CoreData
//        guard let context = self.getContext(errorMsg: "Could not load data") else {return}
//        let request : NSFetchRequest<Members> = Members.fetchRequest()
//        do{
//            try self.members = context.fetch(request)
//        }
//        catch let error as NSError{
//            self.alert(error: error)
//        }
        
        //controlerFetchTest
        self.fetchResultController = MembersFetchResultController(tableView : self.membersTableView)
        // change to a direct call of fetchresultcontroler
        //add function to acces data on fetchresultcontroler
        self.members = self.fetchResultController.members
        
        self.membersTableView.reloadData()
        self.membersTableView.dataSource = self
        self.membersTableView.delegate = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: - TableView data source protocol -
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.membersTableView.dequeueReusableCell(withIdentifier: "membersCell", for: indexPath) as! MemberTableViewCell
        if let fn :String = (self.members[indexPath.row].firstName), let ln :String = (self.members[indexPath.row].lastName) {
            cell.nameMemberLabel.text = fn + " " + ln
        }
        return cell
    }
    
    //MARK: - Helpers methods -
    
    let segueAddMemberId = "addMember"
    let segueShowMemberId = "showMember"
    /// change trip to global variable set in AppDlegate or
    /// in singleton because trip not real global variable
    
    /// Prepare screen transitions
    ///
    /// - Parameters:
    ///   - segue: <#segue description#>
    ///   - sender: <#sender description#>
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == self.segueAddMemberId{
            let memberViewController = segue.destination as! MemberViewController
            memberViewController.trip = self.trip
        }
        else {
            if segue.identifier == self.segueShowMemberId{
                if let indexPath = self.membersTableView.indexPathForSelectedRow{
                    let destController = segue.destination as! MemberViewController
                    let memberViewController = segue.destination as! MemberViewController
                    memberViewController.trip = self.trip
                    destController.member = self.members[indexPath.row]
                    self.membersTableView.deselectRow(at: indexPath, animated: true)
                }
            }
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
    

}
