//
//  AddMemberParticipateTableViewCell.swift
//  ShareCount
//
//  Created by Simon GAYET on 03/04/2019.
//  Copyright © 2019 Simon GAYET Quentin FRANCE. All rights reserved.
//

import UIKit

class AddMemberParticipateTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var participationTF: UITextField! {
        didSet {
            self.participationTF.addDoneCancelToolbar()
        }
    }
    @IBOutlet weak var receiveTF: UITextField! {
        didSet {
            self.receiveTF.addDoneCancelToolbar()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(member: Members){
        self.nameLabel.text = member.firstName
        self.participationTF.text = "0"
        self.receiveTF.text = "0"
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
        return Double(self.participationTF.text ?? "0") ?? 0
    }
    
    func getReveive() -> Double {
        return Double(self.receiveTF.text ?? "0") ?? 0
    }
    
    
}
