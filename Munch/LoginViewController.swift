//
//  LoginViewController.swift
//  Munch
//
//  Created by Adam Ginzberg on 3/9/16.
//  Copyright © 2016 Stanford University. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginViewController: UIViewController {
    
    private var loginMode = true
    private var prevHeight: CGFloat = 0.0
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var toggleButton: UIButton!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordField2: UITextField!
    @IBOutlet weak var textView: UIView!
    
    @IBOutlet weak var nameHeight: NSLayoutConstraint!
    @IBOutlet weak var passwordHeight2: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        for field in [emailField, nameField, passwordField, passwordField2] {
            let padding = UIView(frame: CGRectMake(0,0,10,field.frame.height))
            field.leftView = padding
            field.leftViewMode = .Always
        }
        for field in [nameField, passwordField] {
            field.borderStyle = .None
            field.layer.borderColor = Util.Colors.LightGray.CGColor
            field.layer.borderWidth = 1
        }
        for field in [emailField, passwordField2] {
            field.borderStyle = .None
        }
        
        
        textView.layer.cornerRadius = 5
        textView.layer.masksToBounds = true
        textView.layer.borderColor = Util.Colors.LightGray.CGColor
        textView.layer.borderWidth = 1
        submitButton.layer.cornerRadius = 3
        prevHeight = nameField.frame.height
        nameField.hidden = true
        passwordField2.hidden = true
        if loginMode && NSUserDefaults.standardUserDefaults().boolForKey("rememberMe") {
            emailField.text = NSUserDefaults.standardUserDefaults().stringForKey("email")
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        //if NSUserDefaults.standardUserDefaults().boolForKey("stayLoggedIn")
        //transition to home view
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private let Keychain = KeychainWrapper()
    
    private func setupForMode() {
        if loginMode {
            submitButton.setTitle("Login", forState: .Normal)
            toggleButton.setTitle("Don't have an account?", forState: .Normal)
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut,
                animations: {
                    self.nameField.alpha = 0
                    self.passwordField2.alpha = 0
                    self.prevHeight = self.nameHeight.constant
                    self.nameHeight.constant = 0
                    self.passwordHeight2.constant = 0
                    self.view.layoutIfNeeded()
                },
                completion: { finished in
                    //self.nameField.hidden = true
                    //self.passwordField2.hidden = true
            })
        } else {
            nameField.hidden = false
            passwordField2.hidden = false
            submitButton.setTitle("Register", forState: .Normal)
            toggleButton.setTitle("Already have an account?", forState: .Normal)
            self.nameField.hidden = false
            self.passwordField2.hidden = false
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut,
                animations: {
                    self.nameField.alpha = 1
                    self.passwordField2.alpha = 1
                    self.nameHeight.constant = self.prevHeight
                    self.passwordHeight2.constant = self.prevHeight
                    self.view.layoutIfNeeded()
                },
                completion: { finished in
            })
        }
    }
    
    private func clearFields() {
        for field in [nameField, emailField, passwordField, passwordField2] {
            field.text = ""
        }
    }
    
    @IBAction func toggleMode(sender: AnyObject) {
        loginMode = !loginMode
        setupForMode()
        clearFields()
    }
    
    @IBAction func submit(sender: AnyObject) {
        if loginMode {
            login()
        } else {
            register()
        }
    }
    
    private func authenticate(email: String, password: String) -> (Bool, String?) {
        let data = ["email": email, "password": password]
        let (authResponse, authStatus) = HttpService.doRequest("/api/auth/", method: "POST", data: data, flag: false, synchronous: true)
        if authStatus {
            let client_id = authResponse!["client_id"].string!
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "stayLoggedIn")
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "rememberMe")
            let data = ["grant_type": "password", "username": email, "password": password, "client_id": client_id]
            let (tokenResponse, tokenStatus) = HttpService.doRequest("/o/token/", method: "POST", data: data, flag: false, synchronous: true)
            if tokenStatus {
                let access_token = tokenResponse!["access_token"].string!
                //only storing access token
                self.Keychain.mySetObject(access_token, forKey: kSecValueData)
                self.Keychain.writeToKeychain()
                return (true, nil)
            } else {
                return (false, tokenResponse!["detail"].string!)
            }
        } else {
            return (false, authResponse!["detail"].string!)
        }
    }
    
    private func login() {
        let email = (emailField?.text)!
        let password = (passwordField?.text)!
        //start spinner
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) {
            let (result, error) = self.authenticate(email, password: password)
            dispatch_async(dispatch_get_main_queue()) {
                ///End spinner
                if result {
                    print("log in success!")
                    //transition to home view
                } else {
                    //alert of some kind
                    print("log in failed! \(error)")
                }
            }
        }
    }
    
    private func register() {
        let email = (emailField?.text)!
        let password = (passwordField?.text)!
        let name = (nameField?.text)!
        let data = ["email": email, "password": password, "name": name, "is_customer": "t"]
        //Start spinner
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) {
            let (registerResponse, registerStatus) = HttpService.doRequest("/api/user/", method: "POST", data: data, flag: false, synchronous: true)
            if registerStatus {
                NSUserDefaults.standardUserDefaults().setValue(email, forKey: "email")
                let (result, error) = self.authenticate(email, password: password)
                dispatch_async(dispatch_get_main_queue()) {
                    //End spinner
                    if result {
                        print("registration success!")
                        //transition to next view
                    } else {
                        print("authentication failed! \(error)")
                    }
                }
            } else {
                dispatch_async(dispatch_get_main_queue()) {
                    ///End spinner
                    //alert of some kind -- because invalid email address or duplicate email address
                    print("registering account failed. \(registerResponse)")
                }
            }
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
