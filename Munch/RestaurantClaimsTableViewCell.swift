//
//  RestaurantClaimsTableViewCell.swift
//  Munch
//
//  Created by Adam Ginzberg on 12/1/15.
//  Copyright © 2015 Stanford University. All rights reserved.
//

import UIKit

class RestaurantClaimsTableViewCell: UITableViewCell {
    
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
        promo.font = UIFont(name: Util.FontStyles.Tertiary, size: CGFloat(Util.FontSizes.Tertiary))
        promo.textColor = Util.Colors.DarkGray
        
        if claimed {
            claim.setTitle(" CLAIMED ", forState: .Normal)
            claim.enabled = false
            claim.tintColor = Util.Colors.DarkGray
            claim.backgroundColor = Util.Colors.LightGray
        } else {
            claim.tintColor = Util.Colors.LightGray
            claim.backgroundColor = Util.Colors.Green
        }
        claim.layer.cornerRadius = 8.0
        claim.titleLabel?.font = UIFont(name: Util.FontStyles.Tertiary, size: CGFloat(Util.FontSizes.Tertiary))
    }
    
    override func drawRect(rect: CGRect) {
        if !last {
            let path = UIBezierPath()
            path.moveToPoint(CGPoint(x: 20, y: self.bounds.maxY))
            path.addLineToPoint(CGPoint(x: self.bounds.maxX - 20, y: self.bounds.maxY))
            path.lineWidth = 1.0
            let strokeColor = Util.Colors.DarkGray
            strokeColor.setStroke()
            path.stroke()
            
        }
    }
}
