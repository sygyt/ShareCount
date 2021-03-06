//
//  MemberPaticipateTableViewCell.swift
//  ShareCount
//
//  Created by Simon Gayet on 01/04/2019.
//  Copyright © 2019 Simon GAYET Quentin FRANCE. All rights reserved.
//

import UIKit

class MemberPaticipateTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var participationLabel: UILabel!
    @IBOutlet weak var receiveLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(member: Members){
        self.nameLabel.text = member.firstName
        self.participationLabel.text = "0"
        self.receiveLabel.text = "0"
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
    
    func getParticipation() -> Double {
        return Double(self.participationLabel.text ?? "0") ?? 0
    }
    
    func getReveive() -> Double {
        return Double(self.receiveLabel.text ?? "0") ?? 0
    }
    
    
}
