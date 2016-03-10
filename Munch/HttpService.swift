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
    private static var status = false
    
    private static func dataToJSON(data: NSData) -> AnyObject? {
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)
            return json
        } catch {
            print("error serializing JSON: \(error)")
        }
        return nil
    }
    
    //Data parameter should maybe be AnyObject -- will make changes when we start making those kinds of requests
    static func doRequest(url: String, method: String, data: AnyObject?, flag: Bool) -> (data: AnyObject?, status: Bool) {
        let fullURL = NSURL(string: "https://getstuft.herokuapp.com\(url)")
        //Fetch on login and store somewhere that we can access here
        let request = NSMutableURLRequest(URL: fullURL!)
        request.HTTPMethod = method
        if flag {
            let token = "y6r0v7oeNRpvMfQaJr5bdpPZMv3hVz"
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        if data != nil {
            request.HTTPBody = data!.dataUsingEncoding(NSUTF8StringEncoding)
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
        }
        dataTask = defaultSession.dataTaskWithRequest(request) { data, response, error in
            if self.dataTask != nil {
                self.dataTask?.cancel()
            }
            if let error = error {
                print(error)
            } else if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    responseData = self.dataToJSON(data!)
                    status = true
                }
            }
        }
        dataTask?.resume()
        return (responseData, status)
    }
}