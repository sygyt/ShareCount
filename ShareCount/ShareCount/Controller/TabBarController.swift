//
//  TabBarController.swift
//  ShareCount
//
//  Created by Simon Gayet on 23/03/2019.
//  Copyright © 2019 Simon GAYET Quentin FRANCE. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    var trip : Trips? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO : changer le fonctionnement !!
        let showTripVC = self.children[0] as! ShowTripViewController
        showTripVC.trip = trip
    }

}
