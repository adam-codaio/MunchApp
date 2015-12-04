//
//  DataHelper.swift
//  Munch
//
//  Created by Adam Ginzberg on 11/25/15.
//  Copyright © 2015 Stanford University. All rights reserved.
//  Adapted from Andrew Bancroft's seeding a Core Data data store
//

import Foundation
import CoreData

public class DataHelper {
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    public func seedDataStore() {
        seedUsers()
        seedRestaurants()
        seedPromotions()
        seedUserClaims()
    }
    
    private func seedUsers() {
        let users = [
            (name: "Alexandero Tran", rating: 2.5)
        ]
        
        for user in users {
            let newUser = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: context) as! User
            newUser.name = user.name
            newUser.rating = user.rating
        }
        
        do {
            try context.save()
        } catch _ {
        }
    }
    
    private func seedRestaurants() {
        let restaurants = [
            (hours: "11:00 AM - 11:00 PM", phone_number: "(650)-752-6492", distance: 1.4, name: "Oren's Hummus Shop", address: "261 University Ave, Palo Alto, CA 94301"),
            (hours: "11:00 AM - 12:00 AM", phone_number: "(650)-327-9400", distance: 1.3, name: "Pizza My Heart", address: "220 University Ave, Palo Alto, CA 94301"),
            (hours: "12:00 PM - 11:00 PM", phone_number: "(650)-321-2390", distance: 1.6, name: "CREAM", address: "440 University Ave, Palo Alto, CA 94301"),
            (hours: "7:00 AM - 9:00 PM", phone_number: "(650)-325-5933", distance: 1.4, name: "Lyfe Kitchen", address: "167 Hamilton Ave, Palo Alto, CA 94301"),
            (hours: "11:30 AM - 10:00 PM", phone_number: "(650)-838-0500", distance: 1.4, name: "Tacolicious", address: "632 Emerson St, Palo Alto, CA 94301"),
            (hours: "11:00 AM - 4:00 PM", phone_number: "(650)-600-9696", distance: 1.6, name: "Sushirrito", address: "448 University Ave, Palo Alto, CA 94301")
        ]
        for restaurant in restaurants {
            let newRestaurant = NSEntityDescription.insertNewObjectForEntityForName("Restaurant", inManagedObjectContext: context) as! Restaurant
            newRestaurant.hours = restaurant.hours
            newRestaurant.phone_number = restaurant.phone_number
            newRestaurant.distance = restaurant.distance
            newRestaurant.name = restaurant.name
            newRestaurant.address = restaurant.address
        }
        do {
            try context.save()
        } catch _ {
        }
    }
    
    private func seedPromotions() {
        let request = NSFetchRequest(entityName: "Restaurant")
        let allRestaurants = (try! context.executeFetchRequest(request)) as! [Restaurant]
        
        let orens = allRestaurants.filter({(r: Restaurant) -> Bool in
            return r.name == "Oren's Hummus Shop"
        }).first
        
        let pmh = allRestaurants.filter({(r: Restaurant) -> Bool in
            return r.name == "Pizza My Heart"
        }).first
        
        let cream = allRestaurants.filter({(r: Restaurant) -> Bool in
            return r.name == "CREAM"
        }).first
        
        let lyfe = allRestaurants.filter({(r: Restaurant) -> Bool in
            return r.name == "Lyfe Kitchen"
        }).first
        
        let tacolicious = allRestaurants.filter({(r: Restaurant) -> Bool in
            return r.name == "Tacolicious"
        }).first
        
        let sushirrito = allRestaurants.filter({(r: Restaurant) -> Bool in
            return r.name == "Sushirrito"
        }).first
        
        let promotions = [
            (id: 1, promo: "Free Falafel Side with Entree", restaurant: orens, repetition: 10, expiry: NSDate(timeIntervalSinceNow: 3600), value: 2.99),
            (id: 2, promo: "$1 Pizza Slices", restaurant: pmh, repetition: 45, expiry: NSDate(timeIntervalSinceNow: 7200), value: 1.99),
            (id: 3, promo: "Buy One get One Free", restaurant: cream, repetition: 20, expiry: NSDate(timeIntervalSinceNow: 4800), value: 2.99),
            (id: 4, promo: "$15 Soup and Salad Deal", restaurant: lyfe, repetition: 10, expiry: NSDate(timeIntervalSinceNow: 7200), value: 2.00),
            (id: 5, promo: "Buy 2 Tacos get 1 Free", restaurant: tacolicious, repetition: 30, expiry: NSDate(timeIntervalSinceNow: 7200), value: 1.50),
            (id: 6, promo: "$3 Off Caballero Burrito", restaurant: sushirrito, repetition: 8, expiry: NSDate(timeIntervalSinceNow: 9600), value: 3.00),
            (id: 7, promo: "$3 Guacamole", restaurant: tacolicious, repetition: 15, expiry: NSDate(timeIntervalSinceNow: 0), value: 3.50),
            (id: 8, promo: "1/2 Off Sugar Cookies", restaurant: cream, repetition: 20, expiry: NSDate(timeIntervalSinceNow: 0), value: 1.50)
        ]
        
        for promotion in promotions {
            let newPromotion = NSEntityDescription.insertNewObjectForEntityForName("Promotion", inManagedObjectContext: context) as! Promotion
            newPromotion.id = promotion.id
            newPromotion.promo = promotion.promo
            newPromotion.restaurant = promotion.restaurant
            newPromotion.repetition = promotion.repetition
            newPromotion.expiry = promotion.expiry
            newPromotion.retail_value = promotion.value
        }
        do {
            try context.save()
        } catch _ {
        }
    }
    
    private func seedUserClaims() {
        let request = NSFetchRequest(entityName: "Promotion")
        let allPromotions = (try! context.executeFetchRequest(request)) as! [Promotion]
        
        let pmh = allPromotions.filter({(p: Promotion) -> Bool in
            return p.id == 2
        }).first
        
        let tacolicious = allPromotions.filter({(p: Promotion) -> Bool in
            return p.id == 7
        }).first
        
        let cream = allPromotions.filter({(p: Promotion) -> Bool in
            return p.id == 8
        }).first
        
        let user_request = NSFetchRequest(entityName: "User")
        let allUsers = (try! context.executeFetchRequest(user_request)) as! [User]
        let alex = allUsers.filter({(u: User) -> Bool in
            return u.name == "Alexandero Tran"
        }).first
        
        
        let claims = [
            (claim_time: NSDate(timeIntervalSinceNow: 0), is_redeemed: false, user: alex, promotion: pmh),
            (claim_time: NSDate(timeIntervalSinceNow: -10000), is_redeemed: false, user: alex, promotion: tacolicious),
            (claim_time: NSDate(timeIntervalSinceNow: -1000), is_redeemed: true, user: alex, promotion: cream)
        ]
        
        for claim in claims {
            let newClaim = NSEntityDescription.insertNewObjectForEntityForName("UserClaim", inManagedObjectContext: context) as! UserClaim
            newClaim.claim_time = claim.claim_time
            newClaim.is_redeemed = claim.is_redeemed
            newClaim.user = claim.user
            newClaim.promotion = claim.promotion
        }
        do {
            try context.save()
        } catch _ {
        }
    }
    
    func printAllRestaurants() {
        let restaurantFetchRequest = NSFetchRequest(entityName: "Restaurant")
        let primarySortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        
        restaurantFetchRequest.sortDescriptors = [primarySortDescriptor]
        
        let allRestaurants = (try! context.executeFetchRequest(restaurantFetchRequest)) as! [Restaurant]
        
        for restaurant in allRestaurants {
            print("Restaurant Name: \(restaurant.name)\ndistance: \(restaurant.distance)\nphone_number: \(restaurant.phone_number)\nhours: \(restaurant.hours) \n-------\n", terminator: "")
        }
    }
    
    func printAllUsers() {
        let userFetchRequest = NSFetchRequest(entityName: "User")
        let primarySortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        
        userFetchRequest.sortDescriptors = [primarySortDescriptor]
        
        let allUsers = (try! context.executeFetchRequest(userFetchRequest)) as! [User]
        
        for user in allUsers {
            print("User Name: \(user.name)\nrating: \(user.rating) \n-------\n", terminator: "")
        }
    }
    
    func printAllPromotions() {
        let promotionFetchRequest = NSFetchRequest(entityName: "Promotion")
        let primarySortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        
        promotionFetchRequest.sortDescriptors = [primarySortDescriptor]
        
        let allPromotions = (try! context.executeFetchRequest(promotionFetchRequest)) as! [Promotion]
        
        for promotion in allPromotions {
            print("Promotion id: \(promotion.id)\npromo: \(promotion.promo)\nexpiry: \(promotion.expiry)\nrestaurant: \(promotion.restaurant!.name) \n-------\n", terminator: "")
        }
    }

    func printAllUserClaims() {
        let fetchRequest = NSFetchRequest(entityName: "UserClaim")
        
        let allUserClaims = (try! context.executeFetchRequest(fetchRequest)) as! [UserClaim]
        
        for userClaim in allUserClaims {
            print("UserClaim Promotion ID: \(userClaim.promotion!.id)\nrestaurant: \(userClaim.promotion!.restaurant!.name)\nuser: \(userClaim.user?.name)\nis_redeemed: \(userClaim.is_redeemed)\ntime: \(userClaim.claim_time) \n-------\n", terminator: "")
        }
    }
}
