//
//  RestaurantTableViewController.swift
//  Munch
//
//  Created by Alexander Tran on 11/20/15.
//  Copyright © 2015 Stanford University. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    
    private enum FontSizes: Int {
        case Primary = 18
        case Secondary = 14
        case Tertiary = 12
        case Quaternary = 10
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

    private let mainGreen = UIColor(hex: 0x40BA91)
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var restaurant: UILabel!
    @IBOutlet weak var splash: UIImageView!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var hours: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var currentPromotions: UILabel!
    
    var promotion: Promotion? {
        didSet {
            populateData()
        }
    }
    
    var allPromotions: [Promotion]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    private func populateData() {
        distance?.text = String(promotion!.restaurant!.distance!) + " mi"
        distance?.font = UIFont(name: FontStyles.Tertiary.rawValue, size: CGFloat(FontSizes.Secondary.rawValue))
        distance?.textColor = Colors.LightGray
        
        restaurant?.text = promotion?.restaurant?.name
        restaurant?.font = UIFont(name: FontStyles.Secondary.rawValue, size: CGFloat(FontSizes.Primary.rawValue))
        restaurant?.textColor = Colors.LightGray
        
        address?.text = promotion?.restaurant?.address
        address?.font = UIFont(name: FontStyles.Tertiary.rawValue, size: CGFloat(FontSizes.Secondary.rawValue))
        address?.textColor = Colors.LightGray
        
        hours?.text = "Open " + (promotion?.restaurant?.hours)!
        hours?.font = UIFont(name: FontStyles.Secondary.rawValue, size: CGFloat(FontSizes.Quaternary.rawValue))
        hours?.textColor = Colors.DarkGray
        
        phone?.text = promotion?.restaurant?.phone_number
        phone?.font = UIFont(name: FontStyles.Secondary.rawValue, size: CGFloat(FontSizes.Quaternary.rawValue))
        phone?.textColor = Colors.DarkGray

        
//        promotion.text = promotion?.promo!.uppercaseString
//        promotion.font = UIFont(name: FontStyles.Secondary.rawValue, size: CGFloat(FontSizes.Primary.rawValue))
        
        splash?.image = UIImage(named: promotion!.restaurant!.name!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentPromotions?.font = UIFont(name: FontStyles.Tertiary.rawValue, size: CGFloat(FontSizes.Primary.rawValue))
        currentPromotions?.textColor = Colors.DarkGray
        currentPromotions?.backgroundColor = Colors.LightGray
        currentPromotions?.layer.cornerRadius = 5.0
        populateData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func attemptClaim(sender: UIButton) {
        //TODO: Don't hard code
        let description = "$1 Pizza Slices"
        let alert = UIAlertController(
            title: "", //"Are you sure you want to claim:",
            message: "", //"\(description) (expires at 7:30pm)",
            preferredStyle: UIAlertControllerStyle.Alert
        )
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.Center
        
        let messageText = NSMutableAttributedString(
            string: "Are you sure you want to claim: \n\n \(description) \n Pizza My Heart \n\n Expires at 7:30 pm",
            attributes: [
                NSParagraphStyleAttributeName: paragraphStyle,
                NSFontAttributeName : UIFont.preferredFontForTextStyle(UIFontTextStyleBody),
                NSForegroundColorAttributeName : UIColor.blackColor()
            ]
        )
        let expireRange = (messageText.string as NSString).rangeOfString("Expires at 7:30 pm")
        messageText.addAttribute(NSForegroundColorAttributeName, value: mainGreen, range: expireRange)

        alert.setValue(messageText, forKey: "attributedMessage")
        
        alert.addAction(UIAlertAction(
            title: "Yes",
            style: .Default)
            { [weak weakSelf = self] (action: UIAlertAction) -> Void in
                weakSelf?.confirmClaim(description)
            }
        )
        
        alert.addAction(UIAlertAction(
            title: "No",
            style: .Destructive,
            handler: nil)
        )
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    // TODO: Temporary hack-a-round
    @IBAction func attemptClaim2(sender: UIButton) {
        attemptClaim(sender)
    }
    
    private func confirmClaim(description: String) {
        let alert = UIAlertController(
            title: "Claimed!",
            message: "\(description) from Pizza My Heart",
            preferredStyle: UIAlertControllerStyle.Alert
        )
        
        alert.addAction(UIAlertAction(
            title: "Continue",
            style: .Default,
            handler: nil)
        )
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (allPromotions?.count)!
    }
    
    private let cellIdentifier = "RestaurantClaimCell"

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        if let claimCell = cell as? RestaurantClaimsTableViewCell {
            claimCell.last = indexPath.row == (allPromotions?.count)! - 1
            claimCell.data = allPromotions?[indexPath.row]
        }
        
        return cell
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
