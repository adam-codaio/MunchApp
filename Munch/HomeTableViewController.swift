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
    
    private enum FontSizes: Int {
        case Primary = 14
        case Secondary = 11
    }
    
    private enum FontStyles: String {
        case Primary = "AvenirNext-Bold"
        case Secondary = "AvenirNext-DemiBold"
        case Tertiary = "AvenirNext-Regular"
    }
    
    @IBOutlet weak var sortMech: UISegmentedControl!
    @IBOutlet weak var distanceButton: UIButton!
    
    var managedObjectContext: NSManagedObjectContext? = AppDelegate.managedObjectContext
    
    var promotions = [Promotion]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var currentSort = "Nearby"
    
    override func viewWillAppear(animated: Bool) {
        refresh()
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
        currentSort = sender.titleForSegmentAtIndex(sender.selectedSegmentIndex)!
        refresh()
    }
    
    private func refresh() {
        managedObjectContext?.performBlockAndWait {
            self.promotions = Promotion.openPromotions(inManagedObjectContext: self.managedObjectContext!, sort: self.currentSort, distance: self.currentDistance)
        }
        tableView.reloadData()
    }
    
    private func roundToOneDecimal(value: Double) -> Double {
        return round(value * 10.0) / 10.0
    }
    
    private func saveDistance() {
        currentDistance = roundToOneDecimal(Double(slider.value))
        refresh()
    }
    
    private var slider = UISlider()
    private var alert = UIAlertController()
    private var currentDistance = 2.5
    private let defaultMaxDistance = 5.0

    @IBAction func setLocation(sender: AnyObject) {
        alert = UIAlertController(title: nil, message: nil, preferredStyle: .Alert)
        setMessage("Max Distance: " + String(format: "%.1f", currentDistance) + " mi")
        
        alert.addAction(UIAlertAction(
            title: "Save",
            style: .Default)
            { [weak weakSelf = self] (action: UIAlertAction) -> Void in
                weakSelf?.saveDistance()
            }
        )
        
        alert.addAction(UIAlertAction(
            title: "Cancel",
            style: .Destructive,
            handler: nil
        ))

        let view = UIViewController();
        
        //hard coded but im not sure how to work around, looks fine on 5s and 6s plus
        let frame = CGRectMake(35.0, 10.0, 200.0, 85.0)
        slider.frame = frame
        slider.minimumValue = 0
        slider.maximumValue = Float(defaultMaxDistance)
        slider.value = Float(currentDistance)
        slider.minimumValueImage = UIImage(named: "turtle")
        slider.maximumValueImage = UIImage(named: "hare")
        slider.addTarget(self, action: "sliderValueChanged:", forControlEvents: .ValueChanged)
        
        view.view.addSubview(slider)
        alert.view.addSubview(view.view)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func sliderValueChanged(sender: UISlider) {
        setMessage("Max Distance: " + String(format: "%.1f", sender.value) + " mi")
    }
    
    private func setMessage(message: String) {
        let messageText = NSMutableAttributedString(
            string: message,
            attributes: [
                NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleBody),
                NSForegroundColorAttributeName: Colors.DarkGray
            ]
        )
        alert.setValue(messageText, forKey: "attributedMessage")
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
