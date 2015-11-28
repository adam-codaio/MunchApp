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
    
    private func updateUI() {
//        print(data)
        distance.text = String(data?.restaurant?.distance)
        restaurant.text = data?.restaurant?.name
        promotion.text = data?.promo
    }
}
