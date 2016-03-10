//
//  RedeemView.swift
//  Munch
//
//  Created by Adam Ginzberg on 12/2/15.
//  Copyright © 2015 Stanford University. All rights reserved.
//

import UIKit

class RedeemView: UIView {
    
    var data: UserClaim? {
        didSet {
            updateUI()
        }
    }
    
    
    @IBOutlet weak var splash: UIImageView!
    @IBOutlet weak var promotion: UILabel!
    @IBOutlet weak var restaurant: UILabel!
    @IBOutlet weak var present: UILabel!
    @IBOutlet weak var scan: UILabel!
    
    private var addedBackground = false
    
    private func updateUI() {
        
        restaurant.text = data?.promotion?.restaurant?.name
        restaurant.font = UIFont(name: Util.FontStyles.Tertiary, size: CGFloat(Util.FontSizes.Tertiary))
        restaurant.textColor = Util.Colors.LightGray

        promotion.text = data?.promotion?.promo!.uppercaseString
        promotion.font = UIFont(name: Util.FontStyles.Secondary, size: CGFloat(Util.FontSizes.Secondary))
        promotion.textColor = Util.Colors.LightGray
        
        present.font = UIFont(name:Util.FontStyles.Tertiary, size: CGFloat(Util.FontSizes.Primary))
        present.textColor = Util.Colors.DarkGray
        
        scan.font = UIFont(name: Util.FontStyles.Tertiary, size: CGFloat(Util.FontSizes.Primary))
        scan.textColor = Util.Colors.DarkGray

        splash.image = UIImage(named: (data?.promotion?.restaurant?.name)!)
        
        if (splash != nil) {
            splash.superview?.sendSubviewToBack(splash!)
        }
    
        if (splash != nil && !addedBackground) {
            let bg = UIView(frame: splash!.bounds)
            bg.backgroundColor = UIColor.blackColor()
            bg.alpha = 0.1
            splash.addSubview(bg)
            addedBackground = true
        }
    }
    

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }

}
