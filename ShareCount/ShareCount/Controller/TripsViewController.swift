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

class TripsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Collection of trips for self.tripsTableView
    var trips : [Trips] = []
    var tripsFetchResultController : TripsFetchResultController!
    
    //TableView Controller that display the collection of Trips
    @IBOutlet weak var tripsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tripsFetchResultController = TripsFetchResultController(tableView: self.tripsTableView)
    }
    
    
     //MARK: - TableView delegate
        ///add slidedeletefunction warning with delete cascade member
    
    
    
    //MARK: - TableView data source protocol -
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = self.tripsFetchResultController.tripsFetched.sections?[section] else {
            fatalError("unexpected section number")
        }
        return section.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = self.tripsTableView.dequeueReusableCell(withIdentifier: "tripCell", for: indexPath) as!TripTableViewCell
        let trip = self.tripsFetchResultController.tripsFetched.object(at: indexPath)
        
        cell.nameTripLabel.text = trip.name
        if let imgData = trip.image{
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
                CurrentTrip.sharedInstance = self.tripsFetchResultController.tripsFetched.object(at: indexPath)
                self.tripsTableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }
    
    
    @IBAction func unwindToShowTrip(sender: UIStoryboardSegue) {}
    

}

