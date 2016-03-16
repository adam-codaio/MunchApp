//
//  Restaurant+CoreDataProperties.swift
//  
//
//  Created by Adam Ginzberg on 3/16/16.
//
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
    @NSManaged var name: String?
    @NSManaged var phone_number: String?
    @NSManaged var id: NSNumber?
    @NSManaged var promotions: NSSet?

}
