//
//  ViewController.swift
//  ShareCount
//
//  Created by Simon GAYET on 22/03/2019.
//  Copyright © 2019 Simon GAYET Quentin FRANCE. All rights reserved.
//
import Foundation
import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Collection of trips for self.tripsTableView
    var trips : [Trips] = []
    
    //TableView Controller that display the collection of Trips
    @IBOutlet weak var tripsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let context = self.getContext(errorMsg: "Could not load data") else {return}
        let request : NSFetchRequest<Trips> = Trips.fetchRequest()
        do{
            try self.trips = context.fetch(request)
        }
        catch let error as NSError{
            self.alert(error: error)
        }
    }
    
    
    //MARK: - TableView data source protocol -
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.trips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = self.tripsTableView.dequeueReusableCell(withIdentifier: "tripCell", for: indexPath) as!TripTableViewCell
        cell.nameTripLabel.text = self.trips[indexPath.row].name
        if let imgData = self.trips[indexPath.row].image{
            cell.imageTrip.image = UIImage(data: imgData)
        }
        return cell
    }
    
    
    //MARK: - Helpers methods -
    
    let segueShowTripId = "showTabBar"
    
    /// Prepare screen transitions
    ///
    /// - Parameters:
    ///   - segue: <#segue description#>
    ///   - sender: <#sender description#>
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == self.segueShowTripId{
            if let indexPath = self.tripsTableView.indexPathForSelectedRow{
                CurrentTrip.sharedInstance = self.trips[indexPath.row]
                self.tripsTableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }
    
    
    @IBAction func unwindToShowTrip(sender: UIStoryboardSegue) {}
    
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

