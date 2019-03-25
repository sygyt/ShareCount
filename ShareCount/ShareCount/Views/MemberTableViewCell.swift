//
//  MemberTableViewCell.swift
//  ShareCount
//
//  Created by Simon Gayet on 24/03/2019.
//  Copyright © 2019 Simon GAYET Quentin FRANCE. All rights reserved.
//

import UIKit

class MemberTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var nameMemberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
