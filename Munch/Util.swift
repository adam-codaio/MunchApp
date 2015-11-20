//
//  Util.swift
//  Munch
//
//  Created by Alexander Tran on 11/20/15.
//  Copyright © 2015 Stanford University. All rights reserved.
//

import Foundation
import UIKit

class Util {
    static func getLogoTitle() -> UIImageView {
        let imageView = UIImageView(frame: CGRectMake(0.0, 0.0, 80, 30))
        imageView.contentMode = .ScaleAspectFit
        let image = UIImage(named: "munch_logo_white")
        imageView.image = image
        
        return imageView
    }
}