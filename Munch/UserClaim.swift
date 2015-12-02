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
    }
}
