//
//  TripTableViewCell.swift
//  ShareCount
//
//  Created by Simon Gayet on 23/03/2019.
//  Copyright © 2019 Simon GAYET Quentin FRANCE. All rights reserved.
//

import UIKit

class TripTableViewCell: UITableViewCell {

    @IBOutlet weak var nameTripLabel: UILabel!
    @IBOutlet weak var imageTrip: UIImageView!
    @IBOutlet weak var nbMemberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
