//
//  Promotion.swift
//  Munch
//
//  Created by Adam Ginzberg on 11/25/15.
//  Copyright © 2015 Stanford University. All rights reserved.
//

import Foundation
import CoreData


class Promotion: NSManagedObject {
    
    class func openPromotions(inManagedObjectContext context: NSManagedObjectContext, sort: String, distance: Double) -> [Promotion] {
        let request = NSFetchRequest(entityName: "Promotion")
        let now = NSDate(timeIntervalSinceNow: 0)
        request.predicate = NSPredicate(format: "expiry > %@ and restaurant.distance <=%f", now, distance)
        if sort == "Nearby" {
            let sortDescriptor = NSSortDescriptor(key: "restaurant.distance", ascending: true)
            request.sortDescriptors = [sortDescriptor]
        } else if sort == "Recommended" {
            //We are just using retail_value as a proxy for recommended
            let sortDescriptor = NSSortDescriptor(key: "retail_value", ascending: false)
            request.sortDescriptors = [sortDescriptor]
        }

        if let promotions = (try? context.executeFetchRequest(request)) as? [Promotion] {
            return promotions
        }
        return []
    }

}
