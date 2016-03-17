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
        updateView()
        let tapGesture = UITapGestureRecognizer(target: self, action: "redeem:")
        tapGesture.numberOfTapsRequired = 2
        qrcode.userInteractionEnabled = true
        qrcode.addGestureRecognizer(tapGesture)
    }
    
    func redeem(sender: UIImageView) {
        let postData = ["is_redeemed": String(true)]
        let (_, redeemStatus) = HttpService.doRequest("/api/claim/" + String(data!.id!) + "/", method: "PUT", data: postData, flag: true, synchronous: true)
        
        if redeemStatus {
            AppDelegate.managedObjectContext?.performBlockAndWait {
                UserClaim.redeemClaim(inManagedObjectContext: AppDelegate.managedObjectContext!, promotion: (self.data?.promotion)!)
                do {
                    try AppDelegate.managedObjectContext!.save()
                } catch _ {
                }
            }
        } else {
            //TODO: alert if could not redeem
            return
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
}
