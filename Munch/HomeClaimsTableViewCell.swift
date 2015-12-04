//
//  HomeClaimsTableViewCell.swift
//  Munch
//
//  Created by Adam Ginzberg on 11/20/15.
//  Copyright © 2015 Stanford University. All rights reserved.
//

import UIKit

class HomeClaimsTableViewCell: UITableViewCell {
    
    private enum FontSizes: Int {
        case Primary = 14
        case Secondary = 11
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
    
    var data: Promotion? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var restaurant: UILabel!
    @IBOutlet weak var promotion: UILabel!
    @IBOutlet weak var splash: UIImageView!
    
    private var addedBackground = false

    private func updateUI() {
        distance.text = String(data!.restaurant!.distance!) + " mi"
        distance.font = UIFont(name: FontStyles.Tertiary.rawValue, size: CGFloat(FontSizes.Secondary.rawValue))

        restaurant.text = data?.restaurant?.name
        restaurant.font = UIFont(name: FontStyles.Tertiary.rawValue, size: CGFloat(FontSizes.Secondary.rawValue))
        
        promotion.text = data?.promo!.uppercaseString
        promotion.font = UIFont(name: FontStyles.Secondary.rawValue, size: CGFloat(FontSizes.Primary.rawValue))
        
        splash.image = UIImage(named: data!.restaurant!.name!)
        
        if (!addedBackground) {
            let bg = UIView(frame: splash.bounds)
            bg.backgroundColor = UIColor.blackColor()
            bg.alpha = 0.1
            splash.addSubview(bg)
            addedBackground = true
        }
    }
}
