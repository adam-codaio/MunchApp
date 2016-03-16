//
//  Restaurant+CoreDataProperties.swift
//  Munch
//
//  Created by Adam Ginzberg on 3/16/16.
//  Copyright © 2016 Stanford University. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Restaurant {

    @NSManaged var address: String?
    @NSManaged var distance: NSNumber?
    @NSManaged var hours: String?
    @NSManaged var id: NSNumber?
    @NSManaged var name: String?
    @NSManaged var phone_number: String?
    @NSManaged var promotions: NSSet?

}
