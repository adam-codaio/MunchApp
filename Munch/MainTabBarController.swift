//
//  MainTabBarController.swift
//  Munch
//
//  Created by Alexander Tran on 11/19/15.
//  Copyright © 2015 Stanford University. All rights reserved.
//

import UIKit

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

class MainTabBarController: UITabBarController {
    
    private let mainGreen = UIColor(hex: 0x40BA91)
    private let gray = UIColor(hex:0xA3A3A3)
    private let selectedGray = UIColor(hex:0xEAEAEA)
    private let unselectedGray = UIColor(hex: 0xF4F5F7)

    override func viewDidLoad() {
        super.viewDidLoad()

        var items = self.tabBar.items
        
        self.tabBar.tintColor = mainGreen
        self.tabBar.selectionIndicatorImage = UIImage.imageWithColorAndBorder(selectedGray, borderColor: gray, size: CGSizeMake(self.tabBar.frame.width/CGFloat(items?.count ?? 1), self.tabBar.frame.height))
        self.tabBar.backgroundImage = UIImage.imageWithColorAndBorder(unselectedGray, borderColor: gray, size: CGSizeMake(self.tabBar.frame.width/CGFloat(items?.count ?? 1), self.tabBar.frame.height))
        
        for (var i = 0; i < items?.count ?? 0; ++i) {
            switch i {
            case 0:
                items![i].title = "Home"
                items![i].image = UIImage(named: "home_icon.png")?.imageWithRenderingMode(.AlwaysOriginal)
                items![i].selectedImage = UIImage(named: "home_icon.png")?.imageWithRenderingMode(.AlwaysOriginal)
            case 1:
                items![i].title = "Claims"
                items![i].image = UIImage(named: "claims_icon.png")?.imageWithRenderingMode(.AlwaysOriginal)
                items![i].selectedImage = UIImage(named: "claims_icon.png")?.imageWithRenderingMode(.AlwaysOriginal)
            case 2:
                items![i].title = "Analytics"
                items![i].image = UIImage(named: "analytics_icon.png")?.imageWithRenderingMode(.AlwaysOriginal)
                items![i].selectedImage = UIImage(named: "analytics_icon.png")?.imageWithRenderingMode(.AlwaysOriginal)
            case 3:
                items![i].title = "More"
                items![i].image = UIImage(named: "more_icon.png")?.imageWithRenderingMode(.AlwaysOriginal)
                items![i].selectedImage = UIImage(named: "more_icon.png")?.imageWithRenderingMode(.AlwaysOriginal)
            default:
                break
            }
            items![i].setTitleTextAttributes([NSForegroundColorAttributeName: mainGreen], forState: UIControlState.Normal)
        }
        
        self.navigationItem.titleView = Util.getLogoTitle()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
