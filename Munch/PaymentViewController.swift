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
    var data: UserClaim?

    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    private var messageFrame = UIView()
    private var activityIndicator = UIActivityIndicatorView()
    private var strLabel = UILabel()
    private let f = NSNumberFormatter()

    
    override func viewDidLoad() {
        super.viewDidLoad();
        paymentTextField.frame = CGRectMake(15, 15, CGRectGetWidth(self.view.frame) - 30, 44)
        paymentTextField.delegate = self
        view.addSubview(paymentTextField)
        toggleButton(false)
        submitButton.layer.cornerRadius = 5
        view.addSubview(submitButton)
        
        self.navigationItem.title = "Order Summary"
        
        f.minimumFractionDigits = 2
        f.maximumFractionDigits = 2
        let discount = data!.promotion!.retail_value!
        subtotalLabel.text = "$" + f.stringFromNumber(Float(discount) * 4.0)!
        discountLabel.text = "$" + f.stringFromNumber(discount)!
        totalLabel.text = "$" + f.stringFromNumber(Float(discount) * 3.0)!
        
    }
    
    private func toggleButton(enable: Bool) {
        if enable {
            submitButton.backgroundColor = Util.Colors.SaveGreen
            submitButton.tintColor = UIColor.whiteColor()
        } else {
            submitButton.backgroundColor = Util.Colors.DarkGray
        }
        
        submitButton.enabled = enable
    }
    
    func paymentCardTextFieldDidChange(textField: STPPaymentCardTextField) {
        toggleButton(textField.valid)
    }
    
    private func progressBarDisplayer(msg:String, _ indicator:Bool ) {
        strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 200, height: 50))
        strLabel.text = msg
        strLabel.textColor = UIColor.whiteColor()
        messageFrame = UIView(frame: CGRect(x: view.frame.midX - 90, y: view.frame.midY - 100 , width: 180, height: 50))
        messageFrame.layer.cornerRadius = 15
        messageFrame.backgroundColor = UIColor(white: 0, alpha: 0.7)
        if indicator {
            activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .White)
            activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            activityIndicator.startAnimating()
            messageFrame.addSubview(activityIndicator)
        }
        messageFrame.addSubview(strLabel)
        view.addSubview(messageFrame)
    }
    
    @IBAction func submitCard(sender: AnyObject) {
        let card = paymentTextField.cardParams
        progressBarDisplayer("Redeeming...", true)
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
                    self.messageFrame.removeFromSuperview()
                    
                    let alert = UIAlertController(
                        title: "Redeemed!",
                        message: "You were charged $" + self.f.stringFromNumber(self.data!.promotion!.retail_value!)!,
                        preferredStyle: UIAlertControllerStyle.Alert
                    )
                    
                    alert.addAction(UIAlertAction(
                        title: "Continue",
                        style: .Default)
                        { [weak weakSelf = self] (action: UIAlertAction) -> Void in
                            weakSelf?.navigationController?.popToRootViewControllerAnimated(true)
                        }
                    )
                    
                    let subview = alert.view.subviews.first! as UIView
                    let one = subview.subviews.first!.subviews.first!
                    one.backgroundColor = UIColor.whiteColor()
                    let actions = one.subviews[2]
                    actions.backgroundColor = Util.Colors.LightGray
                    
                    self.presentViewController(alert, animated: true, completion: nil)
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
