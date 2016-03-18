//
//  HomeClaimsTableViewCell.swift
//  Munch
//
//  Created by Adam Ginzberg on 11/20/15.
//  Copyright © 2015 Stanford University. All rights reserved.
//

import UIKit

class HomeClaimsTableViewCell: UITableViewCell {
    
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
        distance.font = UIFont(name: Util.FontStyles.Tertiary, size: CGFloat(Util.FontSizes.Tertiary))

        restaurant.text = data?.restaurant?.name
        restaurant.font = UIFont(name: Util.FontStyles.Tertiary, size: CGFloat(Util.FontSizes.Tertiary))
        
        promotion.text = data?.promo!.uppercaseString
        promotion.font = UIFont(name: Util.FontStyles.Secondary, size: CGFloat(Util.FontSizes.Secondary))
        
        
        if let image = UIImage(named: data!.restaurant!.name!) {
            splash.image = image
            //image
        } else {
            splash.image = UIImage(named: "default")
        }
        
        if (!addedBackground) {
            let bg = UIView(frame: splash.bounds)
            bg.backgroundColor = UIColor.blackColor()
            bg.alpha = 0.1
            splash.addSubview(bg)
            addedBackground = true
        }
    }
}
