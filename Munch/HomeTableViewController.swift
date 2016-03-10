//
//  HomeTableViewController.swift
//  Munch
//
//  Created by Alexander Tran on 11/19/15.
//  Copyright © 2015 Stanford University. All rights reserved.
//

import UIKit
import CoreData

class HomeTableViewController: CoreDataTableViewController {
    
    @IBOutlet weak var sortMech: UISegmentedControl!
    @IBOutlet weak var distanceButton: UIButton!
    
    var managedObjectContext: NSManagedObjectContext? = AppDelegate.managedObjectContext
    
    var promotions = [Promotion]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var currentSort = "Nearby"
    
    override func viewWillAppear(animated: Bool) {
        //self.navigationController?.navigationBarHidden = true
        refresh()
    }
    
    //makes the spacing good on landscape devices
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = Util.getLogoTitle()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        sortMech.tintColor = Util.Colors.Green
        distanceButton.layer.cornerRadius = 8.0;
        distanceButton.contentEdgeInsets = UIEdgeInsetsMake(0, 5.0, 0, 5.0)
        distanceButton.titleLabel!.font = UIFont(name: Util.FontStyles.Tertiary, size: CGFloat(Util.FontSizes.Tertiary))
        distanceButton.titleLabel!.tintColor = Util.Colors.LightGray

        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
    
    @IBAction func setSort(sender: UISegmentedControl) {
        currentSort = sender.titleForSegmentAtIndex(sender.selectedSegmentIndex)!
        refresh()
    }
    
    private func refresh() {
        managedObjectContext?.performBlockAndWait {
            self.promotions = Promotion.openPromotions(inManagedObjectContext: self.managedObjectContext!, sort: self.currentSort, distance: self.currentDistance)
        }
        let url = "/api/promotion/list_promotions/"
        let method = "GET"
        let jsonResponse = HttpService.doRequest(url, method: method, data: nil)
        //serializeJSON(jsonResponse) -- need to put the JSON into promotion objects here
        tableView.reloadData()
    }
    
    private func roundToOneDecimal(value: Double) -> Double {
        return round(value * 10.0) / 10.0
    }
    
    private func roundToPointFive(value: Double) -> Double {
        return round(value * 2.0) / 2.0
    }
    
    private func saveDistance() {
        currentDistance = roundToOneDecimal(Double(slider.value))
        refresh()
    }
    
    private var slider = UISlider()
    private var alert = UIAlertController()
    private var currentDistance = 2.5
    private let defaultMaxDistance = 5.0
    private var segmentIndex = 0

    @IBAction func setLocation(sender: AnyObject) {
        let control = UISegmentedControl()
        alert = UIAlertController(title: nil, message: nil, preferredStyle: .Alert)
        setMessage("Max Distance: " + String(format: "%.1f", currentDistance) + " mi\n")
        
        alert.addAction(UIAlertAction(
            title: "Save",
            style: .Default)
            { [weak weakSelf = self] (action: UIAlertAction) -> Void in
                weakSelf?.saveDistance()
            }
        )
        
        alert.addAction(UIAlertAction(
            title: "Cancel",
            style: .Cancel,
            handler: nil
        ))

        let view = UIViewController();
        
        //hard coded but im not sure how to work around, looks fine on 5s and 6s plus
        let frame = CGRectMake(35.0, 15.0, 200.0, 85.0)
        slider.frame = frame
        slider.minimumValue = 0
        slider.maximumValue = segmentIndex == 0 ? 5.0 : 25.0
        slider.value = Float(currentDistance)
        slider.minimumValueImage = UIImage(named: "tortoise")
        slider.maximumValueImage = UIImage(named: "hare")
        slider.addTarget(self, action: "sliderValueChanged:", forControlEvents: .ValueChanged)
        
        
        let controlFrame = CGRectMake(170, 15, 70, 25)
        control.frame = controlFrame
        control.addTarget(self, action: "toggleTransportation:", forControlEvents: .ValueChanged)
        control.insertSegmentWithImage(UIImage(named: "walk"), atIndex: 0, animated: false)
        control.insertSegmentWithImage(UIImage(named: "car"), atIndex: 1, animated: false)
        control.selectedSegmentIndex = segmentIndex
        
        
        
        let subview = alert.view.subviews.first! as UIView
        let one = subview.subviews.first!.subviews.first!
        one.backgroundColor = UIColor.whiteColor()
        let actions = one.subviews[2]
        actions.backgroundColor = UIColor(hex: 0xF4F5F7)
        
        view.view.addSubview(slider)
        view.view.addSubview(control)
        alert.view.addSubview(view.view)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func toggleTransportation(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            if slider.value > 5.0 {
                slider.value = 5.0
                setMessage("Max Distance: " + String(format: "%.1f", slider.value) + " mi\n")
            }
            slider.minimumValue = 0
            slider.maximumValue = Float(defaultMaxDistance)
            segmentIndex = 0
        } else {
            slider.minimumValue = 0
            slider.maximumValue = 25
            let value = roundToPointFive(Double(slider.value))
            slider.value = Float(value)
            setMessage("Max Distance: " + String(format: "%.1f", value) + " mi\n")
            segmentIndex = 1
        }
    }
    
    func sliderValueChanged(sender: UISlider) {
        if sender.maximumValue == 25 {
            let value = roundToPointFive(Double(slider.value))
            slider.value = Float(value)
            setMessage("Max Distance: " + String(format: "%.1f", value) + " mi\n")
        } else {
            setMessage("Max Distance: " + String(format: "%.1f", sender.value) + " mi\n")
        }
    }
    
    private func setMessage(message: String) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.Left
        
        let messageText = NSMutableAttributedString(
            string: message,
            attributes: [
                NSParagraphStyleAttributeName: paragraphStyle,
                NSFontAttributeName : UIFont.systemFontOfSize(14),
                NSForegroundColorAttributeName : Util.Colors.DarkGray            ]
        )
        alert.setValue(messageText, forKey: "attributedMessage")
    }


    // MARK: - Table view data source


    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return promotions.count
    }
    
    private let cellIdentifier = "PromotionCell"

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        if let promotionCell = cell as? HomeClaimsTableViewCell {
            promotionCell.data = promotions[indexPath.row]
        }

        // Configure the cell...

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationvc: UIViewController? = segue.destinationViewController
        if let restaurantvc = destinationvc as? RestaurantTableViewController {
            let promotion = promotions[(tableView?.indexPathForSelectedRow?.row)!]
            var allPromotions: [Promotion] = []
            if let promotions = promotion.restaurant?.promotions {
                for promotion in promotions {
                    allPromotions.append(promotion as! Promotion)
                }
            }
            restaurantvc.promotion = promotion
            restaurantvc.allPromotions = allPromotions
            restaurantvc.context = managedObjectContext
        }
    }

}
