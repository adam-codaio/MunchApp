//
//  HomeTableViewController.swift
//  Munch
//
//  Created by Alexander Tran on 11/19/15.
//  Copyright © 2015 Stanford University. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    @IBOutlet weak var coupon: UILabel!
    @IBOutlet weak var coupon2: UILabel!
    @IBOutlet weak var coupon3: UILabel!
    @IBOutlet weak var coupon4: UILabel!
    
    
    @IBOutlet weak var restaurant: UILabel!
    @IBOutlet weak var restaurant2: UILabel!
    @IBOutlet weak var restaurant3: UILabel!
    @IBOutlet weak var restaurant4: UILabel!
    
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var distance2: UILabel!
    @IBOutlet weak var distance3: UILabel!
    @IBOutlet weak var distance4: UILabel!
    
    @IBOutlet weak var sortMech: UISegmentedControl!
    @IBOutlet weak var distanceButton: UIButton!

    
    private enum FontSizes: Int {
        case Primary = 14
        case Secondary = 11
    }
    
    private enum FontStyles: String {
        case Primary = "AvenirNext-Bold"
        case Secondary = "AvenirNext-DemiBold"
        case Tertiary = "AvenirNext-Regular"
    }
    
    private struct Colors {
        static let Green = UIColor(hex: 0x40BA91)
        static let Orange = UIColor(hex: 0xFF9900)
        static let LightGray = UIColor(hex: 0xF4F5F7)
        static let DarkGray = UIColor(hex: 0x8C868E)
    }
    
    private let borderWidth = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coupon?.text = coupon?.text!.uppercaseString
        coupon.font = UIFont(name: FontStyles.Secondary.rawValue, size: CGFloat(FontSizes.Primary.rawValue))
        coupon2?.text = coupon2?.text!.uppercaseString
        coupon2.font = UIFont(name: FontStyles.Secondary.rawValue, size: CGFloat(FontSizes.Primary.rawValue))
        coupon3?.text = coupon3?.text!.uppercaseString
        coupon3.font = UIFont(name: FontStyles.Secondary.rawValue, size: CGFloat(FontSizes.Primary.rawValue))
        coupon4?.text = coupon4?.text!.uppercaseString
        coupon4.font = UIFont(name: FontStyles.Secondary.rawValue, size: CGFloat(FontSizes.Primary.rawValue))

        restaurant.font = UIFont(name: FontStyles.Tertiary.rawValue, size: CGFloat(FontSizes.Secondary.rawValue))
        restaurant2.font = UIFont(name: FontStyles.Tertiary.rawValue, size: CGFloat(FontSizes.Secondary.rawValue))
        restaurant3.font = UIFont(name: FontStyles.Tertiary.rawValue, size: CGFloat(FontSizes.Secondary.rawValue))
        restaurant4.font = UIFont(name: FontStyles.Tertiary.rawValue, size: CGFloat(FontSizes.Secondary.rawValue))



        distance.font = UIFont(name: FontStyles.Tertiary.rawValue, size: CGFloat(FontSizes.Secondary.rawValue))
        distance?.tintColor = Colors.LightGray
        distance2.font = UIFont(name: FontStyles.Tertiary.rawValue, size: CGFloat(FontSizes.Secondary.rawValue))
        distance2?.tintColor = Colors.LightGray
        distance3.font = UIFont(name: FontStyles.Tertiary.rawValue, size: CGFloat(FontSizes.Secondary.rawValue))
        distance3?.tintColor = Colors.LightGray
        distance4.font = UIFont(name: FontStyles.Tertiary.rawValue, size: CGFloat(FontSizes.Secondary.rawValue))
        distance4?.tintColor = Colors.LightGray
        sortMech?.tintColor = Colors.Green

        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    @IBAction func setLocation(sender: AnyObject) {
//        let alert = UIAlertController(title: nil,
//            message: "Maximum distance:",
//            preferredStyle: .ActionSheet)
//        self.presentViewController(alert, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


    /*override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }*/

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
