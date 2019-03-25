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
    var members : [Members] = []
    
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
    
    
    lazy var membersFetched : NSFetchedResultsController<Members> = {
        // prepare a request
        let request : NSFetchRequest<Members> = Members.fetchRequest(); request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Members.lastName),ascending:true),NSSortDescriptor(key:#keyPath(Members.firstName) ,ascending:true)] //change to arrival date
        do{
            try self.members = CoreDataManager.context.fetch(request)
        }
        catch let error as NSError{
            self.alert(error: error)
        }
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil) //force unwrapp need to change
        fetchResultController.delegate = self
        return fetchResultController }()
    
    
    
    
    
    
    
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
