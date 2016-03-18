//
//  RedeemClaimViewController.swift
//  Munch
//
//  Created by Adam Ginzberg on 12/2/15.
//  Copyright © 2015 Stanford University. All rights reserved.
//

import UIKit

class RedeemClaimViewController: UIViewController {
    
    var data: UserClaim?
    
    @IBOutlet var redeemView: RedeemView!
    @IBOutlet weak var qrcode: UIImageView!
    
    private func updateView() {
        redeemView.data = data
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = Util.getLogoTitle()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        updateView()
        let tapGesture = UITapGestureRecognizer(target: self, action: "redeem:")
        tapGesture.numberOfTapsRequired = 2
        qrcode.userInteractionEnabled = true
        qrcode.addGestureRecognizer(tapGesture)
    }
    
    func redeem(sender: UIImageView) {
        let has_paid = NSUserDefaults.standardUserDefaults().boolForKey("hasPaid")
        if !has_paid {
            performSegueWithIdentifier("PaymentSegue", sender: nil)
        } else {
            let postData = ["is_redeemed": String(true)]
            let (_, redeemStatus) = HttpService.doRequest("/api/claim/" + String(self.data!.id!) + "/", method: "PUT", data: postData, flag: true, synchronous: true)
            if redeemStatus {
                let description = "Paying for promotion: " + (self.data?.promotion?.promo!)!
                //I must say I am a real dickless guy
                let amount = String(Int((self.data?.promotion?.retail_value)!) * 300)
                let postData = ["description": description, "amount": amount]
                let (_, paymentStatus) = HttpService.doRequest("/api/pay/", method: "POST", data: postData, flag: true, synchronous:true)
                if paymentStatus {
                    print("payment charged")
                    AppDelegate.managedObjectContext?.performBlockAndWait {
                        UserClaim.redeemClaim(inManagedObjectContext: AppDelegate.managedObjectContext!, promotion: (self.data?.promotion)!)
                        do {
                            try AppDelegate.managedObjectContext!.save()
                        } catch _ {
                        }
                    }
                    //I guess we need to alert here too...nice decomposition adam
                    self.navigationController?.popViewControllerAnimated(true)
                } else {
                    //credit card declined
                    return
                }
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationvc: UIViewController? = segue.destinationViewController
        if let paymentvc = destinationvc as? PaymentViewController {
            paymentvc.data = data
        }
    }
}
