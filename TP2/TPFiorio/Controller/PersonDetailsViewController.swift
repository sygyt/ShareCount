//
//  PersonDetailsViewController.swift
//  TPFiorio
//
//  Created by Simon GAYET on 22/03/2019.
//  Copyright © 2019 Quentin FRANCE. All rights reserved.
//

import Foundation
import UIKit


class PersonDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var lastnameLabel: UILabel!
    @IBOutlet weak var firstnameLabel: UILabel!
    @IBOutlet weak var fullnameLabel: UILabel!
    
    var person : Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let aperson = self.person{
            self.lastnameLabel.text = aperson.lastname
            self.firstnameLabel.text = aperson.firstname
            self.fullnameLabel.text = aperson.fullName
        }
        else{
            self.lastnameLabel.text = ""
            self.firstnameLabel.text = ""
            self.fullnameLabel.text = ""
        } }
    
}
