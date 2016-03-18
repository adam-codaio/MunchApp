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
        performSegueWithIdentifier("PaymentSegue", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationvc: UIViewController? = segue.destinationViewController
        if let paymentvc = destinationvc as? PaymentViewController {
            paymentvc.data = data
        }
    }
}
