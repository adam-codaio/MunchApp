//
//  PastClaimsTableViewCell.swift
//  Munch
//
//  Created by Adam Ginzberg on 12/2/15.
//  Copyright © 2015 Stanford University. All rights reserved.
//

import UIKit

class PastClaimsTableViewCell: UITableViewCell {
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
        restaurant.font = UIFont(name: FontStyles.Tertiary.rawValue, size: CGFloat(FontSizes.Secondary.rawValue))
        restaurant.textColor = Colors.LightGray
        
        promotion.text = data?.promotion?.promo!.uppercaseString
        promotion.font = UIFont(name: FontStyles.Secondary.rawValue, size: CGFloat(FontSizes.Primary.rawValue))
        promotion.textColor = Colors.LightGray
        promotion.layer.shadowColor = Colors.DarkGray.CGColor
        
        status.backgroundColor = UIColor.whiteColor()
        status.textColor = Colors.DarkGray
        status.font = UIFont(name: FontStyles.Tertiary.rawValue, size: CGFloat(FontSizes.Secondary.rawValue))
        status.layer.borderColor = Colors.DarkGray.CGColor
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
