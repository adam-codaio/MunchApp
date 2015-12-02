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
    
    class func claimPromotion(inManagedObjectContext context: NSManagedObjectContext, promotion: Promotion) -> String {
        let userRequest = NSFetchRequest(entityName: "User")
        //Because i'm lzy
        let user = (try? context.executeFetchRequest(userRequest))?.first as? User
        if let userClaim = NSEntityDescription.insertNewObjectForEntityForName("UserClaim", inManagedObjectContext: context) as? UserClaim {
            userClaim.claim_time = NSDate(timeIntervalSinceNow: 0)
            userClaim.is_redeemed = false
            userClaim.promotion = promotion
            userClaim.user = user
            return "Success"
        }
        return "Fail"
    }

}
