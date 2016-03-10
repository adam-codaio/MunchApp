//
//  LinedView.swift
//  Munch
//
//  Created by Adam Ginzberg on 12/1/15.
//  Copyright © 2015 Stanford University. All rights reserved.
//

import UIKit

class LinedView: UIView {
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        var width: CGFloat = 2.0
        if let _ = self.superview as? ActivityView {
            width = 1.0
        }
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: 0.0, y: self.bounds.maxY - width))
        path.addLineToPoint(CGPoint(x: self.bounds.maxX, y: self.bounds.maxY - width))
        path.lineWidth = width
        let strokeColor = Util.Colors.DarkGray
        strokeColor.setStroke()
        path.stroke()
    }
}
