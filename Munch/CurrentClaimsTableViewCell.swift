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
    
    private func updateUI() {
//        distance.text = String(data!.restaurant!.distance!) + " mi"
//        distance.font = UIFont(name: FontStyles.Tertiary.rawValue, size: CGFloat(FontSizes.Secondary.rawValue))
//        distance.tintColor = Colors.LightGray
//        
//        restaurant.text = data?.promotion?.restaurant?.name
//        restaurant.font = UIFont(name: FontStyles.Tertiary.rawValue, size: CGFloat(FontSizes.Secondary.rawValue))
//
//        promotion.text = data?.promotion?.promo!.uppercaseString
//        promotion.font = UIFont(name: FontStyles.Secondary.rawValue, size: CGFloat(FontSizes.Primary.rawValue))
        
//        splash.image = UIImage(named: (data?.promotion?.restaurant?.name)!)
    }

}
