//
//  CurrentClaimsTableViewCell.swift
//  Munch
//
//  Created by Adam Ginzberg on 12/2/15.
//  Copyright © 2015 Stanford University. All rights reserved.
//

import UIKit

class CurrentClaimsTableViewCell: UITableViewCell {
    
    private enum FontSizes: Int {
        case Primary = 14
        case Secondary = 13
        case Tertiary = 10
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
    
    private func updateUI() {
      
        restaurant.text = data?.promotion?.restaurant?.name
        restaurant.font = UIFont(name: FontStyles.Tertiary.rawValue, size: CGFloat(FontSizes.Secondary.rawValue))
        restaurant.textColor = Colors.LightGray

        promotion.text = data?.promotion?.promo!.uppercaseString
        promotion.font = UIFont(name: FontStyles.Secondary.rawValue, size: CGFloat(FontSizes.Primary.rawValue))
        promotion.textColor = Colors.LightGray
        
        let timeFormatter = NSDateFormatter()
        timeFormatter.dateFormat = "h:mm a"
        let expiryTime = timeFormatter.stringFromDate((data?.promotion?.expiry)!).lowercaseString
        expires.text = " Expires " + expiryTime
        expires.font = UIFont(name: FontStyles.Secondary.rawValue, size: CGFloat(FontSizes.Tertiary.rawValue))
        expires.textColor = Colors.Green
        expires.backgroundColor = Colors.LightGray
    
        redeem.titleLabel?.font = UIFont(name: FontStyles.Secondary.rawValue, size: CGFloat(FontSizes.Tertiary.rawValue))
        redeem.tintColor = Colors.LightGray
        redeem.backgroundColor = Colors.Green
        redeem.layer.cornerRadius = 6.0
        
        splash.image = UIImage(named: (data?.promotion?.restaurant?.name)!)
    }

}
