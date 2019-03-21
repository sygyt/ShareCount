//
//  PersonTests.swift
//  TPFiorioTests
//
//  Created by Quentin FRANCE on 15/03/2019.
//  Copyright © 2019 Quentin FRANCE. All rights reserved.
//

import XCTest

class PersonTests: XCTestCase {

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
    
    func testInit(){
        var component = DateComponents()
        component.calendar = Calendar.current
        component.year = 1997
        component.month = 2
        component.day = 11
        let p1 : Person
        p1 = getPerson()
        XCTAssert(p1.firstname == "John")
        XCTAssertTrue(p1.lastname == "Doe")
        XCTAssertTrue(p1.birthdate == component.date)
    }
    
    func testEquals(){
        var component = DateComponents()
        component.calendar = Calendar.current
        component.year = 1997
        component.month = 2
        component.day = 11
        XCTAssertTrue(Person(fn :"John", ln: "Doe", d: component.date) == getPerson())
    }
    
    func testFullname(){
        let fullname = "John Doe"
        let nameToTest = getPerson().fullName
        XCTAssertTrue(fullname==nameToTest)
    }

}
