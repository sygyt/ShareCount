//
//  MemberViewModel.swift
//  ShareCount
//
//  Created by Simon GAYET on 03/04/2019.
//  Copyright © 2019 Simon GAYET Quentin FRANCE. All rights reserved.
//

import Foundation
import UIKit

//---------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------
// MARK:
class MemberViewModel{
    // MARK: -
    var member : Members
    var delegate : ParticipateSetViewModelDelegate? = nil
    
    
    init(data : Members){
        self.member = data
    }
    
//    convenience init(data : Members, delegate : MemberViewModelDelegate) {
//        self.init(data: data)
//        self.delegate = delegate
//    }
    
    
    public func getFirstName() -> String {
        return member.firstName ?? "error"
    }
    
    public func getLastName() -> String {
        return member.lastName ?? "error"
    }
    
    public func getArrivalDate() -> Date {
        return member.arrivalDate!
    }
    
    public func getLeavingDate() -> Date {
        return member.leavingDate!
    }
    
    public func getTotalParticipation() -> Double {
        var totalParticipation:Double = 0
        if let participations = member.participateMember?.allObjects {
            for participation in participations{
                
                totalParticipation += Double((participation as! Participate).amountParticipate )
                }
        }
        return totalParticipation
    }
    
    public func getTotalReceive() -> Double {
        var totalReceive:Double = 0
        if let participations = member.participateMember?.allObjects {
            for participation in participations{
                totalReceive += Double((participation as! Participate).amountReceive )
            }
        }
        return totalReceive
    }
    
    
    public func getBalance() -> Double{
        return (self.getTotalParticipation() - self.getTotalReceive())
    }
    
    
}
