//
//  PersonSet.swift
//  TPFiorio
//
//  Created by Quentin FRANCE on 15/03/2019.
//  Copyright © 2019 Quentin FRANCE. All rights reserved.
//

import Foundation

class PersonSet  {
    var personTab : [Person]
    
    init(){
        self.personTab = []
    }
    
    init(personTab : [Person]){
        self.personTab = personTab
    }
    
    var isEmpty: Bool{
        return (self.count == 0)
    }
    
    func add(pers: Person) -> PersonSet{
        self.personTab.append(pers)
        return self
    }
    
    func remove(pers: Person) -> PersonSet{
        var i = 1
        var trouve = false
        while i < self.count && trouve == false{
            if(self.personTab[i] == pers){
                self.personTab.remove(at: i)
                trouve = true
            }
            i = i + 1
        }
        return self
    }
    
    var count : Int {
        return self.personTab.count
    }
    
    func contains(pers: Person) -> Bool{
        var i = 0
        var trouve = false
        while i < self.count && trouve == false{
            if(self.personTab[i] == pers){
                trouve = true
            }
            i = i + 1
        }
        return trouve
    }
    
    func contains(firstname : String, lastname: String)->Bool{
        var i = 0
        var trouve = false
        while i < self.count && trouve == false{
            if(self.personTab[i].firstname == firstname && self.personTab[i].lastname == lastname ){
                trouve = true
            }
            i = i + 1
        }
        return trouve
    }
    
    func contains(firstname : String, lastname: String, date : Date)->Bool{
        var i = 0
        var trouve = false
        while i < self.count && trouve == false{
            if(self.personTab[i].firstname == firstname && self.personTab[i].lastname == lastname && self.personTab[i].birthdate == date ){
                trouve = true
            }
            i = i + 1
        }
        return trouve
    }
    
    
    func look(firstname: String) -> [Person]{
        var tabRes: [Person] = []
        for i in 0..<self.count{
            if(firstname == self.personTab[i].firstname){
                tabRes.append(self.personTab[i])
            }
        }
        return tabRes
    }
    
    func look(lastname: String) -> [Person]{
        var tabRes: [Person] = []
        for i in 0..<self.count{
            if(lastname == self.personTab[i].firstname){
                tabRes.append(self.personTab[i])
            }
        }
        return tabRes
    }
    
    func look(firstname: String, lastname: String) -> [Person]{
        var tabRes: [Person] = []
        for i in 0..<self.count{
            if(lastname == self.personTab[i].lastname && firstname == self.personTab[i].firstname){
                tabRes.append(self.personTab[i])
            }
        }
        return tabRes
    }
    
    func look(firstname: String, lastname: String, date: Date?) -> Person?{
        var res: Person?
        var i = 1
        var trouve = false
        while i < self.count && trouve == false{
            if(self.personTab[i].firstname == firstname && self.personTab[i].lastname == lastname && self.personTab[i].birthdate == date ){
                res = self.personTab[i]
                trouve = true
            }
            i = i + 1
        }
        return res
    }
    
    func indexOf(pers:Person) -> Int?{
        var res : Int?
        var i = 0
        var trouve = false
        while i < self.count && trouve == false{
            if(pers == self.personTab[i]){
                trouve = true
                res = i
            }
            i = i + 1
        }
        return res
    }
    
    public func makeIterator() -> ItPersonSet{
        return ItPersonSet(s: self)
    }
    
    
    
}

struct ItPersonSet : IteratorProtocol{
    private var cur : Int = 0
    private let set : PersonSet
    fileprivate init(s: PersonSet){
        self.set = s
    }
    
    public mutating func reset() -> ItPersonSet{
        self.cur = 0
        return self
    }
    
    public mutating func next() -> Person? {
        if ((self.set.personTab.count-1) == self.cur ){
            return nil
        }
        else{
            self.cur = self.cur + 1
            return self.set.personTab[self.cur]
        }
    }
    
    public mutating func current() -> Person? {
        if (self.end){
            return nil
        }
        else {
            return self.set.personTab[self.cur]
        }
    }
    
    public var end : Bool {
        return self.cur>=self.set.personTab.count
    }
    
}
