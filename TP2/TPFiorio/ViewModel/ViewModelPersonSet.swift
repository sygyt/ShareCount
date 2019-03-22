//
//  TableViewDelegate.swift
//  TPFiorio
//
//  Created by Quentin FRANCE on 19/03/2019.
//  Copyright © 2019 Quentin FRANCE. All rights reserved.
//

import Foundation
import UIKit

class ViewModelPersonSet: NSObject, UITableViewDelegate {
    
    var personSet : PersonSet
    var personTab : [Person]
    
    override init() {
        self.personTab = []
        self.personSet = PersonSet.init()
        super.init()
        personSetLoad()
        loadData()
        
    }
    
    func loadData(){
        var it = self.personSet.makeIterator()
        let pers : Person? = it.current()
        if (pers != nil){
            self.personTab.append(pers!)
            while (it.next() != nil){
                self.personTab.append(it.current()!)
            }
        }
    
    }
    
    func personSetLoad(){
        var p1 = Person(fn: "Simon", ln: "Gayet", d: nil)
        var p2 = Person(fn: "Quentin", ln: "France", d: nil)
        var p3 = Person(fn: "Pontieu", ln: "Theo", d: nil)
        var p4 = Person(fn: "Nico", ln: "RendPasFou", d: nil)
        self.personSet.add(pers: p1)
        self.personSet.add(pers: p2)
        self.personSet.add(pers: p3)
        self.personSet.add(pers: p4)
    }
    
    func getPersonFullName(index : Int) -> String{
        return self.personTab[index].fullName
        //return self.personSet.personTab[index].fullName
    }
    
    func countNbPerson() -> Int {
        return self.personTab.count
    }
    
    func get(index :Int) -> Person{
        return self.personTab[index]
    }
    
        
    
}
