//
//  MemberPaticipateTableViewCell.swift
//  ShareCount
//
//  Created by Simon Gayet on 01/04/2019.
//  Copyright © 2019 Simon GAYET Quentin FRANCE. All rights reserved.
//

import UIKit

class MemberPaticipateTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var participationTextField: UITextField!
    @IBOutlet weak var receiveTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.participationTextField.delegate = self
        self.receiveTextField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(member: Members){
        self.nameLabel.text = member.firstName
        self.participationTextField.text = "0"
        self.receiveTextField.text = "0"
    }
    
    // TextField Delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func getParticipation() -> Int16 {
        return Int16(self.participationTextField.text ?? "0") ?? 0
    }
    
    func getReveive() -> Int16 {
        return Int16(self.receiveTextField.text ?? "0") ?? 0
    }
    
    
}
