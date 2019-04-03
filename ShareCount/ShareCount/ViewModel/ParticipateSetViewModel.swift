//
//  ParticipateSetViewModel.swift
//  ShareCount
//
//  Created by Simon Gayet on 01/04/2019.
//  Copyright © 2019 Simon GAYET Quentin FRANCE. All rights reserved.
//

import Foundation
import UIKit

//---------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------
// MARK: -

/// Delegate to simulate reactive programming to change of person set
protocol ParticipateSetViewModelDelegate {
    // MARK: -
    
    /// called when set globally changes
    func dataSetChanged()
    /// called when a  is deleted from set
    ///
    /// - Parameter indexPath: (section,row) of deletion
    func participateDeleted(at indexPath: IndexPath)
    /// called when a  is updated in set
    ///
    /// - Parameter indexPath: (section, row) of updating
    func participateUpdated(at indexPath: IndexPath)
    /// called when a  is added to set
    ///
    /// - Parameter indexPath: (section,row) of add
    func participateAdded(at indexPath: IndexPath)
    
}

//---------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------
// MARK:
class ParticipateSetViewModel{
    // MARK: -
    var participateSet : [Participate] = []
    var delegate : ParticipateSetViewModelDelegate? = nil
    
    
    init(data : [Participate]){
        self.participateSet = data
    }
    
    convenience init(data : [Participate], delegate : ParticipateSetViewModelDelegate) {
        self.init(data: data)
        self.delegate = delegate
        
    }
    
    /// numbers of persons
    ///
    /// - Returns: number of persons
    public var count : Int {
        return self.participateSet.count
        
    }
    
    /// return ith Person
    ///
    /// - Parameter index: index of person to be returned
    /// - Returns: Person at index if 0 <= index < self.count, else nil
    public func get(personAt index: Int) -> Participate? {
        
        guard (index >= 0 ) && (index < self.count) else { return nil }
        return self.participateSet[index]
        
    }
    
    /// return ith Person
    ///
    /// - Parameter at: index of person to be returned
    public func delete(personAt index: Int) {
        
        guard (index >= 0 ) && (index < self.count) else { return }
        self.participateSet.remove(at: index)
        
    }
    
    /// Get Participate Cost 
    ///
    /// - Returns: <#return value description#>
    public func getCost() -> Int {
        var totalCost = 0
        for i in participateSet {
            totalCost += Int(i.amountParticipate)
        }
        return totalCost
    }
    
}
