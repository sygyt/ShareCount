//
//  person.swift
//  TPFiorio
//
//  Created by Quentin FRANCE on 15/03/2019.
//  Copyright © 2019 Quentin FRANCE. All rights reserved.
//

import Foundation

class Person {
    var firstname : String
    var lastname : String
    var birthdate : Date?
    
    init(fn: String, ln: String, d : Date?){
        self.firstname = fn
        self.lastname = ln
        self.birthdate = d
    }
    
    func setBirthdate(bd : Date){
        self.birthdate = bd
    }
    
    var fullName : String {
        return (firstname + " " + lastname)
    }
    
    func age() -> Int? {
        var age: Int?
        if let bd = self.birthdate {
            let now = Date()
            let calendar = Calendar.current
            let ageComponents = calendar.dateComponents([.year], from: bd, to: now)
            age = ageComponents.year!
        }
        return age
    }
}

extension Person: Equatable{
    static func ==(lhs: Person, rhs: Person) -> Bool{
        return (lhs.firstname == rhs.firstname) && (lhs.lastname == rhs.lastname) && (lhs.birthdate == rhs.birthdate)
    }
    
    
    static func !=(lhs: Person, rhs: Person) -> Bool{
        return !(lhs.firstname == rhs.firstname) && (lhs.lastname == rhs.lastname) && (lhs.birthdate == rhs.birthdate)
    }
}
