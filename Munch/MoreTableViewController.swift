//
//  MoreTableViewController.swift
//  Munch
//
//  Created by Alexander Tran on 3/16/16.
//  Copyright © 2016 Stanford University. All rights reserved.
//

import UIKit

class MoreTableViewController: UITableViewController {

    
    override func tableView(tableView: UITableView,
        didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 && indexPath.section == 0 {
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "stayLoggedIn")
        }
            
        self.navigationController?.navigationController?.popToRootViewControllerAnimated(true)
    }
}
