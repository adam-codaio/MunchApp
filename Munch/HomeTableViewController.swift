//
//  HomeTableViewController.swift
//  Munch
//
//  Created by Alexander Tran on 11/19/15.
//  Copyright © 2015 Stanford University. All rights reserved.
//

import UIKit
import CoreData

class HomeTableViewController: CoreDataTableViewController {
    
    private struct Colors {
        static let Green = UIColor(hex: 0x40BA91)
        static let Orange = UIColor(hex: 0xFF9900)
        static let LightGray = UIColor(hex: 0xF4F5F7)
        static let DarkGray = UIColor(hex: 0x8C868E)
    }
    
    @IBOutlet weak var sortMech: UISegmentedControl!
    @IBOutlet weak var distanceButton: UIButton!
    
    var managedObjectContext: NSManagedObjectContext? = AppDelegate.managedObjectContext
    
    var promotions = [Promotion]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private let defaultSort = "Nearby"
    
    override func viewWillAppear(animated: Bool) {
        managedObjectContext?.performBlockAndWait {
            self.promotions = Promotion.openPromotions(inManagedObjectContext: self.managedObjectContext!, sort: self.defaultSort)
        }
        tableView.reloadData()
    }
    
    //makes the spacing good on landscape devices
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sortMech.tintColor = Colors.Green

        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    @IBAction func setSort(sender: UISegmentedControl) {
        managedObjectContext?.performBlockAndWait {
            self.promotions = Promotion.openPromotions(inManagedObjectContext: self.managedObjectContext!, sort: sender.titleForSegmentAtIndex(sender.selectedSegmentIndex)!)
        }
    }

    @IBAction func setLocation(sender: AnyObject) {
//        let alert = UIAlertController(title: nil,
//            message: "Maximum distance:",
//            preferredStyle: .ActionSheet)
//        self.presentViewController(alert, animated: true, completion: nil)
    }


    // MARK: - Table view data source


    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return promotions.count
    }
    
    private let cellIdentifier = "PromotionCell"

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        if let promotionCell = cell as? HomeClaimsTableViewCell {
            promotionCell.data = promotions[indexPath.row]
        }

        // Configure the cell...

        return cell
    }
    
//    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }

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
