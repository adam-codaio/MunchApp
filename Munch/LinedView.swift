//
//  LinedView.swift
//  Munch
//
//  Created by Adam Ginzberg on 12/1/15.
//  Copyright © 2015 Stanford University. All rights reserved.
//

import UIKit

class LinedView: UIView {
    
    private struct Colors {
        static let Green = UIColor(hex: 0x40BA91)
        static let Orange = UIColor(hex: 0xFF9900)
        static let LightGray = UIColor(hex: 0xF4F5F7)
        static let DarkGray = UIColor(hex: 0x8C868E)
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: 0.0, y: self.bounds.maxY - 2.0))
        path.addLineToPoint(CGPoint(x: self.bounds.maxX, y: self.bounds.maxY - 2.0))
        path.lineWidth = 2.0
        let strokeColor = Colors.DarkGray
        strokeColor.setStroke()
        path.stroke()
    }
}
