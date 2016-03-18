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
        request.predicate = NSPredicate(format: "expiry > %@ and restaurant.distance <=%f and removed=%@ and num_claims<repetition and userClaims.@count==0", now, distance, false)
        if sort == "Nearby" {
            let sortDescriptor = NSSortDescriptor(key: "restaurant.distance", ascending: true)
            request.sortDescriptors = [sortDescriptor]
        } else if sort == "Recommended" {
            let sortDescriptor = NSSortDescriptor(key: "rating", ascending: false)
            request.sortDescriptors = [sortDescriptor]
        }

        if let promotions = (try? context.executeFetchRequest(request)) as? [Promotion] {
            return promotions
        }
        return []
    }
    
    class func claimPromotion(inManagedObjectContext context: NSManagedObjectContext, promotion: Promotion, id: Int) {
        if let userClaim = NSEntityDescription.insertNewObjectForEntityForName("UserClaim", inManagedObjectContext: context) as? UserClaim {
            userClaim.id = id
            userClaim.claim_time = NSDate(timeIntervalSinceNow: 0)
            userClaim.is_redeemed = false
            userClaim.promotion = promotion
        }
    }

    class func createPromotion(inManagedObjectContext context: NSManagedObjectContext, id: Int, promo: String, repetition: Int, retail_value: Float, expiry: NSDate, rating: Float, num_claims: Int, deleted: Bool, restaurant: Restaurant) -> Promotion? {
        
        let promotionRequest = NSFetchRequest(entityName: "Promotion")
        promotionRequest.predicate = NSPredicate(format: "id==%d", id)
        let promotions = (try? context.executeFetchRequest(promotionRequest)) as! [Promotion]
        
        if promotions.count == 1 {
            return updatePromotion(inManagedObjectContext: context, promo: promo, repetition: repetition, retail_value: retail_value, expiry: expiry, rating: rating, num_claims: num_claims, deleted: deleted, restaurant: restaurant, promotion: promotions[0])
        }
            
        if let newPromotion = NSEntityDescription.insertNewObjectForEntityForName("Promotion", inManagedObjectContext: context) as? Promotion {
            newPromotion.id = id
            newPromotion.promo = promo
            newPromotion.repetition = repetition
            newPromotion.retail_value = retail_value
            newPromotion.expiry = expiry
            newPromotion.rating = rating
            newPromotion.num_claims = num_claims
            newPromotion.removed = deleted
            newPromotion.restaurant = restaurant
            return newPromotion
        }
        return nil
    }
    
    class func updatePromotion(inManagedObjectContext context: NSManagedObjectContext, promo: String, repetition: Int, retail_value: Float, expiry: NSDate, rating: Float, num_claims: Int, deleted: Bool, restaurant: Restaurant, promotion: Promotion) -> Promotion? {
        promotion.setValue(promo, forKey: "promo")
        promotion.setValue(repetition, forKey: "repetition")
        promotion.setValue(retail_value, forKey: "retail_value")
        promotion.setValue(expiry, forKey: "expiry")
        promotion.setValue(rating, forKey: "rating")
        promotion.setValue(num_claims, forKey: "num_claims")
        promotion.setValue(deleted, forKey: "removed")
        promotion.setValue(restaurant, forKey: "restaurant")
        return promotion
    }
}
