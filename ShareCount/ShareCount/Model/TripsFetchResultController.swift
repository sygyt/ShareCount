//
//  TripFetchResultController.swift
//  ShareCount
//
//  Created by Quentin FRANCE on 29/03/2019.
//  Copyright © 2019 Simon GAYET Quentin FRANCE. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class TripsFetchResultController: NSObject, NSFetchedResultsControllerDelegate {
    
    let tripsTableView : UITableView
    var trip : [Trips] = []
    
    init(tableView : UITableView){
        self.tripsTableView = tableView
        super.init()
        //load members from CoreData
        
        do{
            try self.tripsFetched.performFetch()
        }
        catch let error as NSError{
            self.alert(error: error)
        }
    }
    
    //----------------------------------------------------------------
    // MARK: - FetchResultController
    
    lazy var tripsFetched : NSFetchedResultsController<Trips> = {
        // prepare a request
        let request : NSFetchRequest<Trips> = Trips.fetchRequest(); request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Trips.name),ascending:true)]
        /* TEST DE FILTRE
         if let currentTripName = CurrentTrip.sharedInstance?.name{
         request.predicate = NSPredicate(format: "trip.name = %d", String(currentTripName))
         } */
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil) //force unwrapp need to change
        fetchResultController.delegate = self
        return fetchResultController
        
    }()
    
    // MARK: - NSFetchResultController delegate protocol
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>){
        self.tripsTableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>){
        self.tripsTableView.endUpdates()
        CoreDataManager.save()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?){
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath{
                self.tripsTableView.insertRows(at: [newIndexPath], with: .automatic) }
        case .delete:
            if let indexPath = indexPath{
                self.tripsTableView.deleteRows(at: [indexPath], with: .automatic) }
        case .update:
            if let indexPath = indexPath{
                self.tripsTableView.reloadRows(at: [indexPath], with: .automatic) }
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
