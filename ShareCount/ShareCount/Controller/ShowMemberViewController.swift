//
//  ShowMemberViewController.swift
//  ShareCount
//
//  Created by Quentin FRANCE on 29/03/2019.
//  Copyright © 2019 Simon GAYET Quentin FRANCE. All rights reserved.
//

import UIKit

class ShowMemberViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var arrivalDateLabel: UILabel!
    @IBOutlet weak var leaveLabel: UILabel!
    @IBOutlet weak var leaveDateLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var expenseTableView: UITableView!
    
    var trip : Trips? = nil
    var member : Members? = nil
    var memberViewModel : MemberViewModel!
    var participateViewModel : ParticipateSetViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.memberViewModel = MemberViewModel(data: self.member!)
        self.firstNameLabel.text = memberViewModel.getFirstName()
        self.lastNameLabel.text = memberViewModel.getLastName()
        let dateFormatter  = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .medium
        let arrivalDate = memberViewModel.getArrivalDate()
        self.arrivalDateLabel.text = dateFormatter.string(from: arrivalDate)
        let leavingDate = memberViewModel.getLeavingDate()
        self.leaveDateLabel.text = dateFormatter.string(from: leavingDate)
        let balance = memberViewModel.getBalance()
        self.totalLabel.text = String(balance) + " $"
        
        if balance < 0 {
            self.totalLabel.textColor = UIColor.red
        }
        else {
            if balance > 0 {
                self.totalLabel.textColor = UIColor.green
            }
        }
        
        self.expenseTableView.dataSource = self
        self.expenseTableView.delegate = self
        
        self.participateViewModel = ParticipateSetViewModel(data: member?.participateMember?.allObjects as! [Participate] )
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    /// Prepare screen transitions
    ///
    /// - Parameters:
    ///   - segue: <#segue description#>
    ///   - sender: <#sender description#>
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let memberViewController = segue.destination as! AddMemberViewController
        memberViewController.trip = CurrentTrip.sharedInstance
        memberViewController.member = self.member!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewDidLoad()
    }
    
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.participateViewModel.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "showExpenseCell", for: indexPath) as! MemberPaticipateTableViewCell
        print(cell)
        if let participate = self.participateViewModel.get(personAt: indexPath.row){
            cell.configure(member: participate.memberParticipate!)
            cell.participationLabel.text = String(participate.amountParticipate)
            cell.participationLabel.textColor = UIColor.red
            cell.receiveLabel.text = String(participate.amountReceive)
            cell.receiveLabel.textColor = UIColor.green
        }
        return cell
    }

}
