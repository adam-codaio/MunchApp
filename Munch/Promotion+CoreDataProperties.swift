//
//  Promotion+CoreDataProperties.swift
//  Munch
//
//  Created by Adam Ginzberg on 12/1/15.
//  Copyright © 2015 Stanford University. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Promotion {

    @NSManaged var expiry: NSDate?
    @NSManaged var id: NSNumber?
    @NSManaged var promo: String?
    @NSManaged var repetition: NSNumber?
    @NSManaged var retail_value: NSNumber?
    @NSManaged var restaurant: Restaurant?
    @NSManaged var userClaims: NSSet?

}
