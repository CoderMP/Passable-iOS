//
//  AccountTableViewController.swift
//  Passable-iOS
//
//  Created by Mark Philips on 9/25/18.
//  Copyright © 2018 Mark Philips. All rights reserved.
//

import UIKit

class AccountTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var accountListData = ["Facebook", "Twitter", "Instagram", "YouTube", "Google", "Google+"]
    var accountImgData = [#imageLiteral(resourceName: "facebook"), #imageLiteral(resourceName: "twitter"), #imageLiteral(resourceName: "instagram"), #imageLiteral(resourceName: "youtube"), #imageLiteral(resourceName: "google"), #imageLiteral(resourceName: "google_plus")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountListData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell()
        
        let rowNum = indexPath.row
        
        tableCell.textLabel?.text = accountListData[rowNum]
        tableCell.textLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        tableCell.backgroundColor = .black
        tableCell.accessoryType = .disclosureIndicator
        
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let viewDetails = UITableViewRowAction(style: .normal, title: "View Details", handler: {action, index in print("View Details Tapped")})
        
        viewDetails.backgroundColor = UIColor.green
        
        return [viewDetails]
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit", handler: {ac, view, success in
            print("Edit Button Tapped")
            success(true)
        })
        
        editAction.backgroundColor = UIColor.blue
        
        return UISwipeActionsConfiguration(actions: [editAction])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
