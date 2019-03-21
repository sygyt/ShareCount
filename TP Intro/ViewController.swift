//
//  ViewController.swift
//  TP Intro
//
//  Created by Theo PONTHIEU on 12/03/2019.
//  Copyright © 2019 Theo PONTHIEU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak  var nameTextField: UITextField!
    @IBOutlet weak var button: UIButton!
    
    @IBAction func changeTitle(_ sender: Any) {
        if let nom = self.nameTextField.text{
            if (nom != ""){
                self.titleLabel.text = nom
            }
        }
        else{
            self.titleLabel.text = "Swift01 Application"
        }
        resetColor()
    }
    
    
    func resetColor(){
        self.button.backgroundColor = UIColor.black
        
    }
  
    

}

