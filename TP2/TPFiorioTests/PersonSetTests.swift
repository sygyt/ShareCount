//
//  PersonSet.swift
//  TPFiorioTests
//
//  Created by Simon GAYET on 18/03/2019.
//  Copyright © 2019 Quentin FRANCE. All rights reserved.
//

import XCTest

class PersonSetTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    private func getPerson() -> Person{
        var component = DateComponents()
        component.calendar = Calendar.current
        component.year = 1997
        component.month = 2
        component.day = 11
        
        return Person(fn :"John", ln: "Doe", d: component.date)
    }
    
    private func getPerson2() -> Person{
        var component = DateComponents()
        component.calendar = Calendar.current
        component.year = 1999
        component.month = 2
        component.day = 11
        
        return Person(fn :"Paul", ln: "demars", d: component.date)
    }
    
    private func getPerson3() -> Person{
        var component = DateComponents()
        component.calendar = Calendar.current
        component.year = 2001
        component.month = 4
        component.day = 11
        
        return Person(fn :"julian", ln: "delsur", d: component.date)
    }
    
    private func getPersonSet() -> PersonSet{
        let p1 = getPerson()
        let p2 = getPerson2()
        let p3 = getPerson3()
        
        return PersonSet(personTab: [p1,p2,p3])
    }
    
    
    func testEmptyInit(){
        let pset = PersonSet()
        XCTAssert(pset.personTab == [])
        
    }
    
    func testInit(){
        let p1 = getPerson()
        let p2 = getPerson2()
        let p3 = getPerson3()
        
        let pset = getPersonSet()
        XCTAssert(pset.personTab == [p1,p2,p3])
    }
    
    func testAdd(){
        let p1 = getPerson()
        let p2 = getPerson2()
        let p3 = getPerson3()
        let p4 = getPerson3()
        
        var pset = getPersonSet()
        pset = getPersonSet().add(pers: p4)
        XCTAssert(pset.personTab == [p1,p2,p3,p4])
    }
    
    func testRemove(){
        let p1 = getPerson()
        let p2 = getPerson2()
        let p3 = getPerson3()
        
        var pset = getPersonSet()
        pset = getPersonSet().remove(pers: p3)
        XCTAssert(pset.personTab == [p1,p2])
    }
    
    func testCount(){
         let pset = getPersonSet()
        XCTAssert(pset.count == pset.personTab.count)
    }
    
    func testContains(){
        let p1 = getPerson()
        let p2 = getPerson2()
        let p3 = getPerson3()
        
        let pset = PersonSet(personTab: [p1,p2])
        XCTAssert(pset.contains(pers: p1))
        XCTAssert(pset.contains(pers: p2))
        XCTAssert(!pset.contains(pers: p3))
    }
    
    func testContainsAttribut(){
        let p1 = getPerson()
        let pset = PersonSet(personTab: [p1])
        XCTAssert(pset.contains(firstname: p1.firstname, lastname: p1.lastname))
    }
    
    func testContainsAttributs(){
        let p1 = getPerson()
        let pset = PersonSet(personTab: [p1])
        XCTAssert(pset.contains(firstname: p1.firstname, lastname: p1.lastname, date: p1.birthdate!))
    }
    
    func testLook(){
        let p1 = getPerson()
        let pset = getPersonSet()
        XCTAssert(pset.look(firstname: p1.firstname) == [p1])
    }
    
    
}
