//
//  UserClaim+CoreDataProperties.swift
//  Munch
//
//  Created by Adam Ginzberg on 11/25/15.
//  Copyright © 2015 Stanford University. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension UserClaim {

    @NSManaged var is_redeemed: NSNumber?
    @NSManaged var claim_time: NSDate?
    @NSManaged var user: User?
    @NSManaged var promotion: Promotion?

}
