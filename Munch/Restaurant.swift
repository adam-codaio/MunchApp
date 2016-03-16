//
//  Restaurant.swift
//  Munch
//
//  Created by Adam Ginzberg on 11/25/15.
//  Copyright © 2015 Stanford University. All rights reserved.
//

import Foundation
import CoreData


class Restaurant: NSManagedObject {
    class func createRestaurant(inManagedObjectContext context: NSManagedObjectContext, hours: String, phone_number: String,
        name: String, address: String, id: Int) -> Restaurant? {
            
        let restaurantRequest = NSFetchRequest(entityName: "Restaurant")
        restaurantRequest.predicate = NSPredicate(format: "id==%d", id)
        let candidate = (try? context.executeFetchRequest(restaurantRequest)) as! [Restaurant]
        if candidate.count == 1 {
            return updateRestaurant(inManagedObjectContext: context, hours: hours, phone_number: phone_number, name: name, address: address, restaurant: candidate[0])
        }
        if let newRestaurant = NSEntityDescription.insertNewObjectForEntityForName("Restaurant", inManagedObjectContext: context) as? Restaurant {
            newRestaurant.hours = hours
            newRestaurant.phone_number = phone_number
            newRestaurant.distance = 1.0 //need to fix this lol
            newRestaurant.name = name
            newRestaurant.address = address
            return newRestaurant
        }
        return nil
    }
    
    class func updateRestaurant(inManagedObjectContext context: NSManagedObjectContext, hours: String, phone_number: String,
        name: String, address: String, restaurant: Restaurant) -> Restaurant? {
        restaurant.setValue(hours, forKey: "hours")
        restaurant.setValue(phone_number, forKey: "phone_number")
        restaurant.setValue(name, forKey: "name")
        restaurant.setValue(address, forKey: "address")
        return restaurant
    }

}
