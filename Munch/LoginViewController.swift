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
    
    private func createStringFromDictionary(dict: Dictionary<String, String>) -> String {
        var params = String()
        var first = true
        for (key, value) in dict {
            if !first {
                params += "&"
            }
            params += key + "=" + value
            first = false
        }
        return params
    }
    
    private func parseClient(jsonResponse: AnyObject?) -> String {
        return ""
    }
    
    private func parseAccessToken(jsonResponse: AnyObject?) -> String {
        return ""
    }
    
    private func validateUserInput() -> Bool {
        return true
    }
    
    func login() {
        
    }
    
    func register() {
        validateUserInput()
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
        let (_, registerStatus) = HttpService.doRequest(url, method: method, data: createStringFromDictionary(data), flag: false)
        if registerStatus {
            Keychain.mySetObject(password, forKey:kSecValueData)
            Keychain.writeToKeychain()
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "hasLoggedIn")
            NSUserDefaults.standardUserDefaults().synchronize()
            let url = "/api/auth/"
            let method = "POST"
            let data = ["email": email, "password": password]
            let (jsonResponse, authStatus) = HttpService.doRequest(url, method: method, data: createStringFromDictionary(data), flag: false)
            let client_id = parseClient(jsonResponse)
            if authStatus {
                //this probably isn't the right way to update the keychain
                Keychain.mySetObject(client_id, forKey: kSecValueData)
                Keychain.writeToKeychain()
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "hasAuthenticated")
                let url = "/o/token/"
                let method = "POST"
                let data = ["grant_type": "password", "username": email, "password": password, "client_id": client_id]
                let (jsonResponse, tokenStatus) = HttpService.doRequest(url, method: method, data: createStringFromDictionary(data), flag: false)
                let access_token = parseAccessToken(jsonResponse)
                if tokenStatus {
                    Keychain.mySetObject(access_token, forKey: kSecValueData)
                    Keychain.writeToKeychain()
                    //transition to next view -- maybe this should be like a welcome screen for new users?
                } else {
                    //do something like could not get access token from server for some reason
                }
            } else {
                //do something like could not authenticate account on server for some reason
            }
        } else {
            //do something like could not make account on server because duplicate email
        }
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
