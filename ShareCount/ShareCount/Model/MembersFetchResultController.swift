//
//  MembersFetchResultController.swift
//  ShareCount
//
//  Created by Simon Gayet on 24/03/2019.
//  Copyright © 2019 Simon GAYET Quentin FRANCE. All rights reserved.
//

import UIKit
import CoreData

class MembersFetchResultController: NSObject, NSFetchedResultsControllerDelegate {
    
    let membersTableView : UITableView
    
    init(tableView : UITableView){
        self.membersTableView = tableView
        super.init()
        //load members from CoreData
    
        do{
            try self.membersFetched.performFetch()
        }
        catch let error as NSError{
            self.alert(error: error)
        }
    }
    
    //----------------------------------------------------------------
    // MARK: - FetchResultController
    
    lazy var membersFetched : NSFetchedResultsController<Members> = {
        // prepare a request
        let request : NSFetchRequest<Members> = Members.fetchRequest(); request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Members.lastName),ascending:true),NSSortDescriptor(key:#keyPath(Members.firstName) ,ascending:true)] //change to arrival date
        if let currentTrip = CurrentTrip.sharedInstance{
            request.predicate = NSPredicate(format: "trip == %@", currentTrip)
        }
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil) //force unwrapp need to change
        fetchResultController.delegate = self
        return fetchResultController
        
    }()
    
    // MARK: - NSFetchResultController delegate protocol
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>){
        self.membersTableView.beginUpdates()
    }
    
   
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>){
        self.membersTableView.endUpdates()
        CoreDataManager.save()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?){
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath{
                self.membersTableView.insertRows(at: [newIndexPath], with: .automatic) }
        case .delete:
            if let indexPath = indexPath{
                self.membersTableView.deleteRows(at: [indexPath], with: .automatic) }
        case .update:
            if let indexPath = indexPath{
                self.membersTableView.reloadRows(at: [indexPath], with: .automatic) }
        default:
            break
        }
        
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
    }
    
    /// Show an alert of the error in parameter
    ///
    /// - Parameter error: <#error description#>
    func alert(error: NSError){
        self.alert(withTitle: "\(error)", andMessage:"\(error.userInfo)")
    }

}
