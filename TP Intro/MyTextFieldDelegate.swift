//
//  MyTextFieldDelegate.swift
//  TP Intro
//
//  Created by Theo PONTHIEU on 12/03/2019.
//  Copyright © 2019 Theo PONTHIEU. All rights reserved.
//

import Foundation
import UIKit

class MyTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var btn: UIButton!
    
    func changeColor(){
        if let nom = self.nameTextField.text{
            if (nom != self.titleLabel.text){
                self.btn.backgroundColor = UIColor.purple
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        changeColor()
        return true
    }
}
