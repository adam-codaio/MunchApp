//
//  ClaimsTableViewController.swift
//  Munch
//
//  Created by Alexander Tran on 11/19/15.
//  Copyright © 2015 Stanford University. All rights reserved.
//

import UIKit
import CoreData

class ClaimsTableViewController: UITableViewController {
    
    private struct Colors {
        static let Green = UIColor(hex: 0x40BA91)
        static let Orange = UIColor(hex: 0xFF9900)
        static let LightGray = UIColor(hex: 0xF4F5F7)
        static let DarkGray = UIColor(hex: 0x8C868E)
    }
    
    private enum FontSizes: Int {
        case Primary = 14
        case Secondary = 11
    }
    
    private enum FontStyles: String {
        case Primary = "AvenirNext-Bold"
        case Secondary = "AvenirNext-DemiBold"
        case Tertiary = "AvenirNext-Regular"
    }
    
    var managedObjectContext: NSManagedObjectContext? = AppDelegate.managedObjectContext
    
    var currentClaims = [UserClaim]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var pastClaims = [UserClaim]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private func refresh() {
        managedObjectContext?.performBlockAndWait {
            let allClaims = UserClaim.allClaims(inManagedObjectContext: self.managedObjectContext!)
            let now = NSDate(timeIntervalSinceNow: 0)
            for claim in allClaims {
                if claim.is_redeemed! == 0 && claim.promotion!.expiry!.compare(now) == NSComparisonResult.OrderedAscending {
                    self.currentClaims.append(claim)
                } else {
                    self.pastClaims.append(claim)
                }
            }
        }
        tableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        refresh()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return headerTitles.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return currentClaims.count
        } else if section == 1 {
            return pastClaims.count
        }
        return 0
    }
    
    private let headerTitles = ["Current Claims", "Past Claims"]
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headerTitles[section]
    }
    
    //TODO: Fix these headers
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let title = UILabel()
        let view = UIView()
        title.frame = CGRectMake(20, 8, 320, 20)
        title.font = UIFont(name: FontStyles.Secondary.rawValue, size: CGFloat(FontSizes.Primary.rawValue))
        title.text = self.tableView(tableView, titleForHeaderInSection: section)
        title.textColor = Colors.DarkGray
        view.addSubview(title)
        view.backgroundColor = Colors.LightGray
        return view
    }
    
    private let currentClaim = "CurrentClaimCell"
    private let pastClaim = "PastClaimCell"
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(currentClaim, forIndexPath: indexPath)
            
            if let currentCell = cell as? CurrentClaimsTableViewCell {
                currentCell.data = currentClaims[indexPath.row]
            }
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier(pastClaim, forIndexPath: indexPath)
            
            if let pastCell = cell as? PastClaimsTableViewCell {
                pastCell.data = pastClaims[indexPath.row]
            }
            return cell
        }
        // Configure the cell...
        return UITableViewCell()
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
