//
//  LoginViewController.swift
//  Munch
//
//  Created by Adam Ginzberg on 3/9/16.
//  Copyright © 2016 Stanford University. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let Keychain = KeychainWrapper()
    
    func register() {
        let email = "deez.nuts@gmail.com"
        let name = "deez nuts"
        let password = "dddddddd"
        let hasLoggedIn = NSUserDefaults.standardUserDefaults().boolForKey("hasLoggedIn")
        if !hasLoggedIn {
            NSUserDefaults.standardUserDefaults().setValue(email, forKey: "email")
        }
        
        let url = "/api/user/"
        let method = "POST"
        let data = ["email": email, "password": password, "name": name, "is_customer": "t"]
        let jsonResponse = HttpService.doRequest(url, method: method, data: data)
        
        Keychain.mySetObject(password, forKey:kSecValueData)
        Keychain.writeToKeychain()
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "hasLoggedIn")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func login() {
        
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
