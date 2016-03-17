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
        let claimRequest = NSFetchRequest(entityName: "UserClaim")
        if let userClaims = (try? context.executeFetchRequest(claimRequest)) as? [UserClaim] {
            return userClaims
        }
        return []
    }
    
    class func redeemClaim(inManagedObjectContext context: NSManagedObjectContext, promotion: Promotion) {
        let claimRequest = NSFetchRequest(entityName: "UserClaim")
        claimRequest.predicate = NSPredicate(format: "promotion=%@", promotion)
        if let userClaim = (try? context.executeFetchRequest(claimRequest))?.first as? UserClaim {
            userClaim.setValue(true, forKey: "is_redeemed")
        }
    }
}
