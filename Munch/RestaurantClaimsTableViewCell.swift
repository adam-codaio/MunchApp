//
//  RestaurantClaimsTableViewCell.swift
//  Munch
//
//  Created by Adam Ginzberg on 12/1/15.
//  Copyright © 2015 Stanford University. All rights reserved.
//

import UIKit

class RestaurantClaimsTableViewCell: UITableViewCell {
    
    private enum FontSizes: Int {
        case Primary = 12
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
    
    var last = false
    
    var claimed: Bool = false
    
    @IBOutlet weak var promo: UILabel!
    @IBOutlet weak var claim: UIButton!
    
    private func updateUI() {
        promo.text = data?.promo?.uppercaseString
        promo.font = UIFont(name: FontStyles.Tertiary.rawValue, size: CGFloat(FontSizes.Primary.rawValue))
        promo.textColor = Colors.DarkGray
        
        if claimed {
            claim.setTitle(" CLAIMED ", forState: .Normal)
            claim.enabled = false
            claim.tintColor = Colors.DarkGray
            claim.backgroundColor = Colors.LightGray
        } else {
            claim.tintColor = Colors.LightGray
            claim.backgroundColor = Colors.Green
        }
        claim.layer.cornerRadius = 8.0
        claim.titleLabel?.font = UIFont(name: FontStyles.Tertiary.rawValue, size: CGFloat(FontSizes.Primary.rawValue))
    }
    
    override func drawRect(rect: CGRect) {
        if !last {
            let path = UIBezierPath()
            path.moveToPoint(CGPoint(x: 0.15 * self.bounds.maxX, y: self.bounds.maxY * 0.85))
            path.addLineToPoint(CGPoint(x: 0.85 * self.bounds.maxX, y: self.bounds.maxY * 0.85))
            path.lineWidth = 2.0
            let strokeColor = Colors.DarkGray
            strokeColor.setStroke()
            path.stroke()
            
        }
    }
}
