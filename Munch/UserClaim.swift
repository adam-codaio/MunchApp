//
//  UserClaim.swift
//  Munch
//
//  Created by Adam Ginzberg on 11/25/15.
//  Copyright © 2015 Stanford University. All rights reserved.
//

import Foundation
import CoreData


class UserClaim: NSManagedObject {

    class func allClaims(inManagedObjectContext context: NSManagedObjectContext) -> [UserClaim] {
        let userRequest = NSFetchRequest(entityName: "User")
        //Because i'm lzy
        let user = (try? context.executeFetchRequest(userRequest))?.first as? User
        let claimRequest = NSFetchRequest(entityName: "UserClaim")
        claimRequest.predicate = NSPredicate(format: "user=%@", user!)
        if let userClaims = (try? context.executeFetchRequest(claimRequest)) as? [UserClaim] {
            return userClaims
        }
        return []
//        let request = NSFetchRequest(entityName: "Promotion")
//        let now = NSDate(timeIntervalSinceNow: 0)
//        request.predicate = NSPredicate(format: "expiry > %@ and restaurant.distance <=%f", now, distance)
//        if sort == "Nearby" {
//            let sortDescriptor = NSSortDescriptor(key: "restaurant.distance", ascending: true)
//            request.sortDescriptors = [sortDescriptor]
//        } else if sort == "Recommended" {
//            //We are just using retail_value as a proxy for recommended
//            let sortDescriptor = NSSortDescriptor(key: "retail_value", ascending: false)
//            request.sortDescriptors = [sortDescriptor]
//        }
//        
//        if let promotions = (try? context.executeFetchRequest(request)) as? [Promotion] {
//            return promotions
//        }
        return []
    }

}
