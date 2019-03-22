//
//  ViewController.swift
//  TPFiorio
//
//  Created by Quentin FRANCE on 15/03/2019.
//  Copyright © 2019 Quentin FRANCE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var tableViewController: TableViewController!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableViewController = TableViewController()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let destController = segue.destination as? PersonDetailsViewController {
            if let cell = sender as? UITableViewCell{
                guard let indexPath = self.tableView.indexPath(for: cell)
            else{
                    return
            }
            destController.person = self.tableViewController.PersonSetData.get(index: indexPath.row)
            }
        } }
    
}

