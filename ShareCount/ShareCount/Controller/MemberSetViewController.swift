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

class MemberSetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var membersTableView: UITableView!
    var fetchResultController : MembersFetchResultController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //affect setected trip to label
        if let atrip = CurrentTrip.sharedInstance{
            self.navigationItem.title = atrip.name
        }
        //controlerFetchTest
        self.fetchResultController = MembersFetchResultController(tableView: self.membersTableView)
        // change to a direct call of fetchresultcontroler
        //add function to acces data on fetchresultcontrole
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
    
    //MARK: - TableView delegate
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction{
        let member = self.fetchResultController.membersFetched.object(at: indexPath)
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            CoreDataManager.context.delete(member)
            completion(true)
        }
        let logotrash = UIImage(named: "Trash")
        action.image = logotrash
        action.backgroundColor = UIColor.red
        return action
    }
    
    //MARK: - TableView data source protocol -
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = self.fetchResultController.membersFetched.sections?[section] else {
            fatalError("unexpected section number")
        }
        return section.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.membersTableView.dequeueReusableCell(withIdentifier: "membersCell", for: indexPath) as! MemberTableViewCell
        let member = self.fetchResultController.membersFetched.object(at: indexPath)
        var memberViewModel : MemberViewModel!
        memberViewModel = MemberViewModel(data: member)
        if let firstname = member.firstName, let lastname = member.lastName{
            cell.nameMemberLabel.text = firstname + " " + lastname
        }
        let balance = memberViewModel.getBalance()
        cell.balanceMemberLabel.text = String(balance) + "$"
        if balance < 0 {
            cell.balanceMemberLabel.textColor = UIColor.red
        }
        else {
            if balance > 0 {
                cell.balanceMemberLabel.textColor = UIColor.green
            }
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
            let memberViewController = segue.destination as! AddMemberViewController
            memberViewController.trip = CurrentTrip.sharedInstance
        }
        else {
            if segue.identifier == self.segueShowMemberId{
                if let indexPath = self.membersTableView.indexPathForSelectedRow{
                    let destController = segue.destination as! ShowMemberViewController
                    destController.member = self.fetchResultController.membersFetched.object(at: indexPath)
                    self.membersTableView.deselectRow(at: indexPath, animated: true)
                }
            }
        }
    }
    
    @IBAction func unwindToShowMembers(sender: UIStoryboardSegue) {}
    
    
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
