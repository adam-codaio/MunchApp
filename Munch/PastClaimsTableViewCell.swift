//
//  PastClaimsTableViewCell.swift
//  Munch
//
//  Created by Adam Ginzberg on 12/2/15.
//  Copyright © 2015 Stanford University. All rights reserved.
//

import UIKit

class PastClaimsTableViewCell: UITableViewCell {
    @IBOutlet weak var splash: UIImageView!
    @IBOutlet weak var promotion: UILabel!
    @IBOutlet weak var restaurant: UILabel!
    @IBOutlet weak var status: UILabel!
    
    var data: UserClaim? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        restaurant.text = data?.promotion?.restaurant?.name
        restaurant.font = UIFont(name: Util.FontStyles.Tertiary, size: CGFloat(Util.FontSizes.Tertiary))
        restaurant.textColor = Util.Colors.LightGray
        
        promotion.text = data?.promotion?.promo!.uppercaseString
        promotion.font = UIFont(name: Util.FontStyles.Secondary, size: CGFloat(Util.FontSizes.Secondary))
        promotion.textColor = Util.Colors.LightGray
        promotion.layer.shadowColor = Util.Colors.DarkGray.CGColor
        
        status.backgroundColor = UIColor.whiteColor()
        status.textColor = Util.Colors.DarkGray
        status.font = UIFont(name: Util.FontStyles.Tertiary, size: CGFloat(Util.FontSizes.Tertiary))
        status.layer.borderColor = Util.Colors.DarkGray.CGColor
        status.layer.borderWidth = 1.0
        if data?.is_redeemed == 1 {
            status.text = " Redeemed! "
        } else {
            status.text = " Expired! "
        }
//        
//        redeem.titleLabel?.font = UIFont(name: FontStyles.Secondary.rawValue, size: CGFloat(FontSizes.Tertiary.rawValue))
//        redeem.tintColor = Colors.LightGray
//        redeem.backgroundColor = Colors.Green
//        redeem.layer.cornerRadius = 6.0
        
        splash.image = UIImage(named: (data?.promotion?.restaurant?.name)!)?.convertToGrayScale()
    }
}

/*
* Adapted from https://gist.github.com/ntnmrndn/045abc4875291a50018b
*/
extension UIImage {
    
    private func convertToGrayScaleNoAlpha() -> CGImageRef {
        let colorSpace = CGColorSpaceCreateDeviceGray();
        let bitmapInfo = UInt32(CGImageAlphaInfo.None.rawValue)
        let context = CGBitmapContextCreate(nil, Int(size.width), Int(size.height), 8, 0, colorSpace, bitmapInfo)
        CGContextDrawImage(context, CGRectMake(0, 0, size.width, size.height), self.CGImage)
        return CGBitmapContextCreateImage(context)!
    }
    
    
    /**
     Return a new image in shades of gray + alpha
     */
    func convertToGrayScale() -> UIImage {
        let bitmapInfo = UInt32(CGImageAlphaInfo.Only.rawValue)
        let context = CGBitmapContextCreate(nil, Int(size.width), Int(size.height), 8, 0, nil, bitmapInfo)
        CGContextDrawImage(context, CGRectMake(0, 0, size.width, size.height), self.CGImage);
        let mask = CGBitmapContextCreateImage(context)
        return UIImage(CGImage: CGImageCreateWithMask(convertToGrayScaleNoAlpha(), mask)!, scale: scale, orientation:imageOrientation)
    }
}
