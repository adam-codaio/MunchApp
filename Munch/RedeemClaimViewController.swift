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
        UserClaim.redeemClaim(inManagedObjectContext: AppDelegate.managedObjectContext!, promotion: (data?.promotion)!)
        self.navigationController?.popViewControllerAnimated(true)
    }
}
