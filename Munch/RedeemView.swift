//
//  RedeemView.swift
//  Munch
//
//  Created by Adam Ginzberg on 12/2/15.
//  Copyright © 2015 Stanford University. All rights reserved.
//

import UIKit

class RedeemView: UIView {
    
    private enum FontSizes: Int {
        case Top = 18
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
    @IBOutlet weak var present: UILabel!
    @IBOutlet weak var scan: UILabel!
    
    private func updateUI() {
        
        restaurant.text = data?.promotion?.restaurant?.name
        restaurant.font = UIFont(name: FontStyles.Tertiary.rawValue, size: CGFloat(FontSizes.Secondary.rawValue))
        restaurant.textColor = Colors.LightGray

        promotion.text = data?.promotion?.promo!.uppercaseString
        promotion.font = UIFont(name: FontStyles.Secondary.rawValue, size: CGFloat(FontSizes.Primary.rawValue))
        promotion.textColor = Colors.LightGray
        
        present.font = UIFont(name:FontStyles.Tertiary.rawValue, size: CGFloat(FontSizes.Top.rawValue))
        present.textColor = Colors.DarkGray
        
        scan.font = UIFont(name:FontStyles.Tertiary.rawValue, size: CGFloat(FontSizes.Top.rawValue))
        scan.textColor = Colors.DarkGray

        splash.image = UIImage(named: (data?.promotion?.restaurant?.name)!)
    }
    

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }

}
