//
//  Util.swift
//  Munch
//
//  Created by Alexander Tran on 11/20/15.
//  Copyright © 2015 Stanford University. All rights reserved.
//

extension UIImage {
    class func imageWithColorAndBorder(color: UIColor, borderColor: UIColor, size: CGSize) -> UIImage {
        //TODO: Borders are off. fix it
        let rect = CGRectMake(0.0, 0.0, size.width, size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, CGRectMake(0.5, 0.0, size.width-1.5, size.height))
        
        //let leftBorder = CGRectMake(0.0, 0.0, 0.5, size.height)
        let rightBorder = CGRectMake(size.width-0.5, 0.0, 0.5, size.height)
        
        CGContextSetFillColorWithColor(context, borderColor.CGColor)
        //CGContextFillRect(context, leftBorder)
        CGContextFillRect(context, rightBorder)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    class func imageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRectMake(0.0, 0.0, size.width, size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, CGRectMake(1.0, 0.0, size.width-1.0, size.height))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}

extension UIColor
{
    convenience init(red: Int, green: Int, blue: Int)
    {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
    
    convenience init(hex: Int) {
        self.init(red: (hex & 0xFF0000) >> 16,
            green: (hex & 0x00FF00) >> 8,
            blue: (hex & 0x0000FF) >> 0)
    }
}

import Foundation
import UIKit

class Util {
    static func getLogoTitle() -> UIImageView {
        let imageView = UIImageView(frame: CGRectMake(0.0, 0.0, 80, 30))
        imageView.contentMode = .ScaleAspectFit
        let image = UIImage(named: "munch_logo_white")
        imageView.image = image
        
        return imageView
    }
    
    struct Colors {
        static let Green = UIColor(hex: 0x40BA91)
        static let Orange = UIColor(hex: 0xFF9900)
        static let LightGray = UIColor(hex: 0xF4F5F7)
        static let DarkGray = UIColor(hex: 0x8C868E)
        static let Gray = UIColor(hex:0xA3A3A3)
        static let SelectedTabGray = UIColor(hex:0xEAEAEA)
        static let ErrorRed = UIColor(hex: 0xF83500)
        static let SaveGreen = UIColor(hex: 0x7ED452)
    }
    
    struct FontSizes {
        static let Primary = 18
        static let Secondary = 14
        static let Tertiary = 12
        static let Quaternary = 10
    }
    
    struct FontStyles {
        static let Primary = "AvenirNext-Bold"
        static let Secondary = "AvenirNext-DemiBold"
        static let Tertiary = "AvenirNext-Regular"
    }
    
    

}