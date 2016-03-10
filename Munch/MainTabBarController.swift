//
//  MainTabBarController.swift
//  Munch
//
//  Created by Alexander Tran on 11/19/15.
//  Copyright © 2015 Stanford University. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var items = self.tabBar.items
        
        self.tabBar.tintColor = Util.Colors.Green
        self.tabBar.selectionIndicatorImage = UIImage.imageWithColorAndBorder(Util.Colors.SelectedTabGray, borderColor: Util.Colors.Gray, size: CGSizeMake(self.tabBar.frame.width/CGFloat(items?.count ?? 1), self.tabBar.frame.height))
        self.tabBar.backgroundImage = UIImage.imageWithColorAndBorder(Util.Colors.LightGray, borderColor: Util.Colors.Gray, size: CGSizeMake(self.tabBar.frame.width/CGFloat(items?.count ?? 1), self.tabBar.frame.height))
        
        for (var i = 0; i < items?.count ?? 0; ++i) {
            switch i {
            case 0:
                items![i].title = "Home"
                items![i].image = UIImage(named: "home.png")?.imageWithRenderingMode(.AlwaysOriginal)
                items![i].selectedImage = UIImage(named: "home.png")?.imageWithRenderingMode(.AlwaysOriginal)
            case 1:
                items![i].title = "Claims"
                items![i].image = UIImage(named: "claims.png")?.imageWithRenderingMode(.AlwaysOriginal)
                items![i].selectedImage = UIImage(named: "claims.png")?.imageWithRenderingMode(.AlwaysOriginal)
            case 2:
                items![i].title = "Analytics"
                items![i].image = UIImage(named: "analytics.png")?.imageWithRenderingMode(.AlwaysOriginal)
                items![i].selectedImage = UIImage(named: "analytics.png")?.imageWithRenderingMode(.AlwaysOriginal)
            case 3:
                items![i].title = "More"
                items![i].image = UIImage(named: "more.png")?.imageWithRenderingMode(.AlwaysOriginal)
                items![i].selectedImage = UIImage(named: "more.png")?.imageWithRenderingMode(.AlwaysOriginal)
            default:
                break
            }
            items![i].setTitleTextAttributes([NSForegroundColorAttributeName: Util.Colors.Green], forState: UIControlState.Normal)
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
