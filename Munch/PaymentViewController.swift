//
//  PaymentViewController.swift
//  Munch
//
//  Created by Adam Ginzberg on 3/18/16.
//  Copyright © 2016 Stanford University. All rights reserved.
//

import UIKit
import Stripe

class PaymentViewController: UIViewController, STPPaymentCardTextFieldDelegate {
    
    let paymentTextField = STPPaymentCardTextField()
    var submitButton = UIButton()
    var data: UserClaim?

    override func viewDidLoad() {
        super.viewDidLoad();
        paymentTextField.frame = CGRectMake(15, 15, CGRectGetWidth(self.view.frame) - 30, 44)
        paymentTextField.delegate = self
        view.addSubview(paymentTextField)
        submitButton = UIButton(type: UIButtonType.System)
        submitButton.frame = CGRectMake(15, 100, 100, 44)
        submitButton.enabled = false
        submitButton.setTitle("Submit", forState: UIControlState.Normal)
        submitButton.addTarget(self, action: "submitCard:", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(submitButton)
    }
    
    func paymentCardTextFieldDidChange(textField: STPPaymentCardTextField) {
        submitButton.enabled = textField.valid
    }
    

    
    @IBAction func submitCard(sender: AnyObject?) {
        let card = paymentTextField.cardParams
        
        STPAPIClient.sharedClient().createTokenWithCard(card) { token, error in
            guard let stripeToken = token else {
                NSLog("Error creating token: %@", error!.localizedDescription);
                return
            }
            let postData = ["is_redeemed": String(true)]
            let (_, redeemStatus) = HttpService.doRequest("/api/claim/" + String(self.data!.id!) + "/", method: "PUT", data: postData, flag: true, synchronous: true)
            if redeemStatus {
                let description = "Paying for promotion: " + (self.data?.promotion?.promo!)!
                //I must say I am a real dickless guy
                let amount = String(Int((self.data?.promotion?.retail_value)!) * 300)
                let postData = ["description": description, "amount": amount, "stripeToken": String(stripeToken)]
                let (_, paymentStatus) = HttpService.doRequest("/api/pay/", method: "POST", data: postData, flag: true, synchronous:true)
                if paymentStatus {
                    NSUserDefaults.standardUserDefaults().setBool(true, forKey: "hasPaid")
                    print("payment charged")
                    AppDelegate.managedObjectContext?.performBlockAndWait {
                        UserClaim.redeemClaim(inManagedObjectContext: AppDelegate.managedObjectContext!, promotion: (self.data?.promotion)!)
                        do {
                            try AppDelegate.managedObjectContext!.save()
                        } catch _ {
                        }
                    }
                    //alert here or back when you're at other view controller? sorry im too tired for this shit.
                    self.navigationController?.popViewControllerAnimated(true)
                } else {
                    //credit card declined
                    return
                }
            }
        }
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
