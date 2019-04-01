//
//  MemberSetViewModel.swift
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
protocol MemberSetViewModelDelegate {
// MARK: -

/// called when set globally changes
    func dataSetChanged()
/// called when a Person is deleted from set
///
/// - Parameter indexPath: (section,row) of deletion
    func memberDeleted(at indexPath: IndexPath)
/// called when a Person is updated in set
///
/// - Parameter indexPath: (section, row) of updating
    func memberUpdated(at indexPath: IndexPath)
/// called when a Person is added to set
///
/// - Parameter indexPath: (section,row) of add
    func memberAdded(at indexPath: IndexPath)

}

//---------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------
// MARK:
class MemberSetViewModel{
    // MARK: -
    var memberSet : [Members] = []
    var delegate : MemberSetViewModelDelegate? = nil

    
    init(data : [Members]){
        
        self.memberSet = data
        
    }
    
    convenience init(data : [Members], delegate : MemberSetViewModelDelegate) {
        self.init(data: data)
        self.delegate = delegate
    }

    /// numbers of persons
    ///
    /// - Returns: number of persons
    public var count : Int {
        return self.memberSet.count
        
    }
    
    /// return ith Person
    ///
    /// - Parameter index: index of person to be returned
    /// - Returns: Person at index if 0 <= index < self.count, else nil
    public func get(personAt index: Int) -> Members? {
    
        guard (index >= 0 ) && (index < self.count) else { return nil }
        return self.memberSet[index]
        
    }
    
    /// return ith Person
    ///
    /// - Parameter at: index of person to be returned
    public func delete(personAt index: Int) {
        
        guard (index >= 0 ) && (index < self.count) else { return }
        self.memberSet.remove(at: index)
        
    }
    
}
