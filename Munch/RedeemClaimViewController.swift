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
    
    private func updateView() {
        redeemView.data = data
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = Util.getLogoTitle()
        updateView()
    }
}
