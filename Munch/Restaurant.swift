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
        name: String, address: String, latitude: Double, longitude: Double, distance: Double, id: Int) -> Restaurant? {
            
        let restaurantRequest = NSFetchRequest(entityName: "Restaurant")
        restaurantRequest.predicate = NSPredicate(format: "id==%d", id)
        let candidate = (try? context.executeFetchRequest(restaurantRequest)) as! [Restaurant]
        if candidate.count == 1 {
            return updateRestaurant(inManagedObjectContext: context, hours: hours, phone_number: phone_number, name: name, address: address, latitude: latitude, longitude: longitude, distance: distance, restaurant: candidate[0])
        }
        if let newRestaurant = NSEntityDescription.insertNewObjectForEntityForName("Restaurant", inManagedObjectContext: context) as? Restaurant {
            newRestaurant.hours = hours
            newRestaurant.phone_number = phone_number
            newRestaurant.distance = distance
            newRestaurant.name = name
            newRestaurant.address = address
            newRestaurant.latitude = latitude
            newRestaurant.longitude = longitude
            return newRestaurant
        }
        return nil
    }
    
    class func updateRestaurant(inManagedObjectContext context: NSManagedObjectContext, hours: String, phone_number: String,
        name: String, address: String, latitude: Double, longitude: Double, distance: Double, restaurant: Restaurant) -> Restaurant? {
        restaurant.setValue(hours, forKey: "hours")
        restaurant.setValue(phone_number, forKey: "phone_number")
        restaurant.setValue(name, forKey: "name")
        restaurant.setValue(address, forKey: "address")
        restaurant.setValue(distance, forKey: "distance")
        restaurant.setValue(latitude, forKey: "latitude")
        restaurant.setValue(longitude, forKey: "longitude")
        return restaurant
    }

}
