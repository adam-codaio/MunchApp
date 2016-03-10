//
//  HttpService.swift
//  Munch
//
//  Created by Adam Ginzberg on 3/8/16.
//  Copyright © 2016 Stanford University. All rights reserved.
//

import Foundation

class HttpService {
    

    private static let defaultSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    private static var dataTask: NSURLSessionDataTask?
    private static var responseData: AnyObject?
    
    private static func dataToJSON(data: NSData) -> AnyObject? {
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            return json
        } catch {
            print("error serializing JSON: \(error)")
        }
        return nil
    }
    
    //Data parameter should maybe be AnyObject -- will make changes when we start making those kinds of requests
    static func doRequest(url: String, method: String, data: String?) -> AnyObject? {
        let fullURL = NSURL(string: "https://getstuft.herokuapp.com\(url)")
        //Fetch on login and store somewhere that we can access here
        let token = "1vUBwAXSrfGvDqhVCxbMhH4dRy0YMl"
        let request = NSMutableURLRequest(URL: fullURL!)
        //Extend to allow user to add data, i.e. query params or post etse
        request.HTTPMethod = method
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        dataTask = defaultSession.dataTaskWithRequest(request) { data, response, error in
            if self.dataTask != nil {
                self.dataTask?.cancel()
            }
            if let error = error {
                print(error.localizedDescription)
            } else if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    responseData = self.dataToJSON(data!)
                }
            }
        }
        dataTask?.resume()
        return responseData
    }
}