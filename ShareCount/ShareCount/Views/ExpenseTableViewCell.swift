//
//  ExpenseTableViewCell.swift
//  ShareCount
//
//  Created by Quentin FRANCE on 29/03/2019.
//  Copyright © 2019 Simon GAYET Quentin FRANCE. All rights reserved.
//

import UIKit

class ExpenseTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
