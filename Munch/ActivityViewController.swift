//
//  ActivityViewController.swift
//  Munch
//
//  Created by Alexander Tran on 12/4/15.
//  Copyright © 2015 Stanford University. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController {

    @IBOutlet weak var moneyLabel: UILabel!
    
    @IBOutlet weak var inTheLastLabel: UILabel!
    
    @IBOutlet weak var couponsUsedLabel: UILabel!
    
    @IBOutlet weak var claimedLabel: UILabel!
    @IBOutlet weak var redeemedLabel: UILabel!
    @IBOutlet weak var expiredLabel: UILabel!
    
    @IBOutlet weak var ccLabel: UILabel!
    @IBOutlet weak var crLabel: UILabel!
    @IBOutlet weak var ceLabel: UILabel!
    
    @IBOutlet weak var graphView: ActivityGraphView!

    @IBAction func filterChanged(sender: UISegmentedControl) {
        filter = filters[sender.selectedSegmentIndex]
        reloadData()
    }
    
    private let formatter = NSNumberFormatter()
    
    private let filters = ["Week", "Month", "Year"]
    
    private var filter = "Week" {
        didSet {
            reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        claimedLabel.layer.cornerRadius = 9
        claimedLabel.clipsToBounds = true
        redeemedLabel.layer.cornerRadius = 9
        redeemedLabel.clipsToBounds = true
        expiredLabel.layer.cornerRadius = 9
        expiredLabel.clipsToBounds = true
        
        ccLabel.layer.cornerRadius = 4
        ccLabel.clipsToBounds = true
        crLabel.layer.cornerRadius = 4
        crLabel.clipsToBounds = true
        ceLabel.layer.cornerRadius = 4
        ceLabel.clipsToBounds = true
        
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.minimumIntegerDigits = 1
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private let managedObjectContext = AppDelegate.managedObjectContext
    
    private func reloadData() {
        managedObjectContext?.performBlockAndWait { [weak weakSelf = self] in
            let allClaims = UserClaim.allClaims(inManagedObjectContext: (weakSelf?.managedObjectContext!)!)
            let now = NSDate(timeIntervalSinceNow: 0)
            
            var moneySaved = 0.0
            var totalClaims = 0
            var redeemedClaims = 0
            var expiredClaims = 0

            let cutoff: NSDate
            if weakSelf?.filter == "Week" {
                cutoff = NSDate (timeIntervalSinceNow: -60*60*24*7)
            } else if weakSelf?.filter == "Month" {
                cutoff = NSDate (timeIntervalSinceNow: -60*60*24*28)
            } else {
                cutoff = NSDate (timeIntervalSinceNow: -60*60*24*365)
            }
            
            for claim in allClaims {
                if !(claim.is_redeemed! == 0 && claim.promotion!.expiry!.compare(now) == NSComparisonResult.OrderedDescending) {
                    if (claim.is_redeemed! == 1) {
                        if (claim.claim_time!.compare(cutoff) == NSComparisonResult.OrderedDescending) {
                            moneySaved += (claim.promotion?.retail_value!.doubleValue)!
                        }
                        redeemedClaims += 1
                    } else {
                        expiredClaims += 1
                    }
                }
                
                totalClaims += 1
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                weakSelf?.moneyLabel.text = "$ " + (weakSelf?.formatter.stringFromNumber(moneySaved)!)! + "  "
                weakSelf?.claimedLabel.text = String(totalClaims)
                weakSelf?.redeemedLabel.text = String(redeemedClaims)
                weakSelf?.expiredLabel.text = String(expiredClaims)
            }
        }
        
        
        inTheLastLabel.text = "in the last " + filter.lowercaseString
        couponsUsedLabel.text = "Coupons Claimed in the Last " + filter
        graphView.filter = filter
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
