//
//  CurrentClaimsTableViewCell.swift
//  Munch
//
//  Created by Adam Ginzberg on 12/2/15.
//  Copyright © 2015 Stanford University. All rights reserved.
//

import UIKit

class CurrentClaimsTableViewCell: UITableViewCell {
    
    
    var data: UserClaim? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var splash: UIImageView!
    @IBOutlet weak var promotion: UILabel!
    @IBOutlet weak var restaurant: UILabel!
    @IBOutlet weak var expires: UILabel!
    @IBOutlet weak var redeem: UIButton!
    
    private var addedBackground = false
    
    private func updateUI() {
      
        restaurant.text = data?.promotion?.restaurant?.name
        restaurant.font = UIFont(name: Util.FontStyles.Tertiary, size: CGFloat(Util.FontSizes.Tertiary))
        restaurant.textColor = Util.Colors.LightGray

        promotion.text = data?.promotion?.promo!.uppercaseString
        promotion.font = UIFont(name: Util.FontStyles.Secondary, size: CGFloat(Util.FontSizes.Secondary))
        promotion.textColor = Util.Colors.LightGray
        
        let timeFormatter = NSDateFormatter()
        timeFormatter.dateFormat = "h:mm a"
        let expiryTime = timeFormatter.stringFromDate((data?.promotion?.expiry)!).lowercaseString
        expires.text = " Expires " + expiryTime
        expires.font = UIFont(name: Util.FontStyles.Secondary, size: CGFloat(Util.FontSizes.Quaternary))
        expires.textColor = Util.Colors.Green
        expires.backgroundColor = Util.Colors.LightGray
    
        redeem.titleLabel?.font = UIFont(name: Util.FontStyles.Secondary, size: CGFloat(Util.FontSizes.Quaternary))
        redeem.tintColor = Util.Colors.LightGray
        redeem.backgroundColor = Util.Colors.Green
        redeem.layer.cornerRadius = 5.0
        redeem.layer.borderColor = Util.Colors.LightGray.CGColor
        redeem.layer.borderWidth = 1
        
        
        
        if let image = UIImage(named: (data?.promotion?.restaurant?.name)!) {
            splash.image = image
            //image
        } else {
            splash.image = UIImage(named: "default")
        }
                
        if (splash != nil && !addedBackground) {
            let bg = UIView(frame: splash!.bounds)
            bg.backgroundColor = UIColor.blackColor()
            bg.alpha = 0.1
            splash.addSubview(bg)
            addedBackground = true
        }
    }

}
