//
//  ActivityGraphView.swift
//  Munch
//
//  Created by Alexander Tran on 12/4/15.
//  Copyright © 2015 Stanford University. All rights reserved.
//

import UIKit

class ActivityGraphView: UIView {

    
    private struct Colors {
        static let Green = UIColor(hex: 0x40BA91)
        static let Orange = UIColor(hex: 0xFF9900)
        static let LightGray = UIColor(hex: 0xF4F5F7)
        static let DarkGray = UIColor(hex: 0x8C868E)
    }
    
    private let managedObjectContext = AppDelegate.managedObjectContext
    
    var filter = "Week" {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setNeedsDisplay()
    }
    
    private let graphWidth : CGFloat = 200
    private let graphHeight : CGFloat = 90
    private let widthOffset : CGFloat = 50
    private let heightOffset : CGFloat = 5
    private let labelOffset : CGFloat = 20
    
    private func drawGraphAxes() {
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: widthOffset + labelOffset, y: heightOffset))
        path.addLineToPoint(CGPoint(x: widthOffset + labelOffset, y: heightOffset + graphHeight - labelOffset))
        path.addLineToPoint(CGPoint(x: widthOffset + labelOffset, y: heightOffset + graphHeight - labelOffset))
        path.addLineToPoint(CGPoint(x: widthOffset + graphWidth, y: heightOffset + graphHeight - labelOffset))
        
        
        path.lineWidth = 2
        Colors.DarkGray.set()
        path.stroke()
    }
    
    private func graphData(labels: [String], data: [Int], usedFilter: String) {
        if usedFilter != filter {
            return
        }
        
//        print ("attempting to graph")
//        print(data)
//        print(labels)
        
        let upper = CGFloat((data.maxElement()!/4)+1)*4.0
        
        UIColor.darkGrayColor().set()
        drawYLabels(upper)
        drawXLabels(labels)
        
        Colors.Green.set()
        let path = UIBezierPath()
        path.lineWidth = 2
        let dim = labels.count
        for (var i = 0; i < dim; ++i) {
            let point = CGPoint(x: widthOffset + labelOffset + graphWidth*(CGFloat(i)/CGFloat(dim)), y: heightOffset + graphHeight - labelOffset
                - CGFloat(data[i]) * graphHeight/upper)
            if i == 0 {
                path.moveToPoint(point)
            } else {
                path.addLineToPoint(point)
            }
            
            // Draw the specific point
            //            let curr = UIBezierPath()
            //            curr.moveToPoint(point)
            //            curr.addLineToPoint(point)
            //            curr.lineWidth = 5
            //            curr.stroke()
        }
        
        path.stroke()
    }

    
    private func gatherData() {
        managedObjectContext?.performBlockAndWait { [weak weakSelf = self] in
            let allClaims = UserClaim.allClaims(inManagedObjectContext: (weakSelf?.managedObjectContext!)!)
            
            //Hack, i dont wanna do weakself
            let weekdays = ["FILLER", "Su", "M", "Tu", "W", "Th", "F", "Sa"]
            let months = ["FILLER", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
            let now = NSDate(timeIntervalSinceNow: 0)
            
            let calendar = NSCalendar.currentCalendar()

            let monthIndex = calendar.components(.Month, fromDate: now).month
            let weekIndex = calendar.components(.Weekday, fromDate: now).weekday


            var data = [Int]()
            var labels = [String]()
            let usedFilter = weakSelf!.filter
    
            if usedFilter == "Week" {
                for i in 0...6 {
                    var index = weekIndex - i
                    if index <= 0 {
                        index += 7
                    }
                    
                    labels.insert(weekdays[index], atIndex: 0)
                    data.insert(0, atIndex: 0)
                }
                
                let interval = 60*60*24.0
                let cutoff = NSDate(timeIntervalSinceNow: -7.0*interval)
                for claim in allClaims {
                    if let ct = claim.claim_time {
                        if ct.compare(cutoff) == NSComparisonResult.OrderedDescending {
                            data[labels.indexOf(weekdays[calendar.components(.Weekday, fromDate: ct).weekday])!] += 1
                        }
                    }
                }
            } else if usedFilter == "Year" {
                for i in 0...11 {
                    var index = monthIndex - i
                    if index <= 0 {
                        index += 12
                    }
                    
                    labels.insert(months[index], atIndex: 0)
                    data.insert(0, atIndex: 0)
                }
                
                let interval = 60*60*24.0*365
                let cutoff = NSDate(timeIntervalSinceNow: -interval)
                for claim in allClaims {
                    if let ct = claim.claim_time {
                        if ct.compare(cutoff) == NSComparisonResult.OrderedDescending {
                            data[labels.indexOf(months[calendar.components(.Month, fromDate: ct).month])!] += 1
                        }
                    }
                }
                
                print(data)
                print(labels)
            } else {
                //let cutoff1 = now
            }
            
            
            weakSelf?.graphData(labels, data: data, usedFilter: usedFilter)
        }
    }
    
    private let labelAttributes = [
        NSForegroundColorAttributeName: UIColor.darkGrayColor(),
        NSObliquenessAttributeName: 0.1,
        NSFontAttributeName: UIFont(name: "Helvetica Neue", size: 10)!
    ]
    
    private func drawYLabels(upper: CGFloat) {
        let increment = upper/4.0
        
        for (var i: CGFloat = 0.0; i <= upper; i += increment) {
            let path = UIBezierPath()
            path.lineWidth = 2
            let height = heightOffset + graphHeight - labelOffset - ((i/upper)*graphHeight)
            
            path.moveToPoint(CGPoint(x: widthOffset+labelOffset-5, y: height))
            path.addLineToPoint(CGPoint(x: widthOffset+labelOffset+5, y: height))
            path.stroke()
            
            let text = NSString(string: NSNumber(integer: Int(i)).stringValue)
            text.drawAtPoint(CGPoint(x: widthOffset, y: height-5), withAttributes: labelAttributes)
        }
    }
    
    private func drawXLabels(labels: [String]) {
        let dim: CGFloat = CGFloat(labels.count)
        for (var i: CGFloat = 0.0; i < dim; i += 1) {
            let path = UIBezierPath()
            path.lineWidth = 2
            let width = widthOffset + labelOffset + graphWidth * ((i)/dim)
            let height = heightOffset+graphHeight-labelOffset
            
            path.moveToPoint(CGPoint(x: width, y: height - 5))
            path.addLineToPoint(CGPoint(x: width, y: height + 5))
            path.stroke()
            
            let text = NSString(string: labels[Int(i)])
            text.drawAtPoint(CGPoint(x: width-5, y: height+5), withAttributes: labelAttributes)
        }
    }

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        drawGraphAxes()
        gatherData()
    }
}
