//
//  ExpenseFetchResultController.swift
//  ShareCount
//
//  Created by Quentin FRANCE on 29/03/2019.
//  Copyright © 2019 Simon GAYET Quentin FRANCE. All rights reserved.
//

import UIKit
import CoreData

class ExpenseFetchResultController: NSObject, NSFetchedResultsControllerDelegate  {
    
    let expensesTableView : UITableView

    
    init(tableView : UITableView){
        self.expensesTableView = tableView
        super.init()
        //load expenses from CoreData
        do{
            try self.expensesFetched.performFetch()
        }
        catch let error as NSError{
            self.alert(error: error)
        }
    }
    
    //----------------------------------------------------------------
    // MARK: - FetchResultController
    
    lazy var expensesFetched : NSFetchedResultsController<Expense> = {
        // prepare a request
        let request : NSFetchRequest<Expense> = Expense.fetchRequest(); request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Expense.nameExpense),ascending:true),NSSortDescriptor(key:#keyPath(Expense.nameExpense) ,ascending:true)]
        if let currentTrip = CurrentTrip.sharedInstance{
            request.predicate = NSPredicate(format: "ANY participates.memberParticipate.trip == %@", currentTrip)
        }
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil) //force unwrapp need to change
        fetchResultController.delegate = self
        return fetchResultController
        
    }()

//    func expenseParticipationFetched(expense: Expense) -> NSFetchedResultsController<Participate> {
//        let request : NSFetchRequest<Participate> = Participate.fetchRequest();
//        request.predicate = NSPredicate(format: "expenseParticipe == %@", expense)
//        return
//    }
    
    // MARK: - NSFetchResultController delegate protocol
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>){
        self.expensesTableView.beginUpdates()
    }
    
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>){
        self.expensesTableView.endUpdates()
        CoreDataManager.save()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?){
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath{
                self.expensesTableView.insertRows(at: [newIndexPath], with: .automatic) }
        case .delete:
            if let indexPath = indexPath{
                self.expensesTableView.deleteRows(at: [indexPath], with: .automatic) }
        case .update:
            if let indexPath = indexPath{
                self.expensesTableView.reloadRows(at: [indexPath], with: .automatic) }
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
