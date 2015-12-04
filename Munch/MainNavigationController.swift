//
//  MainNavigationController.swift
//  Munch
//
//  Created by Alexander Tran on 11/20/15.
//  Copyright © 2015 Stanford University. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    private let mainGreen = UIColor(hex: 0x40BA91)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationBar.topItem?.title = ""
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationBar.topItem?.titleView = Util.getLogoTitle()
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
