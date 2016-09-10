//
//  Traitify.swift
//  TraitifyExplore
//
//  Created by Tom Prats on 9/9/16.
//  Copyright © 2016 Tomify. All rights reserved.
//

import Foundation

struct Traitify {
    static let Version = "v1"
    static let PublicKey = "afvikuccq11fqoh9et9c4qqqvm"
    static let DevelopmentBaseURL = "https://api-sandbox.traitify.com"
    static let ProductionBaseURL = "https://api.traitify.com"
    
    static func setupRequest(path: String, params: AnyObject?, method: String) -> NSMutableURLRequest {
        var baseURL = ""
        if NSProcessInfo.processInfo().environment["development"] != nil {
            baseURL = DevelopmentBaseURL
        } else {
            baseURL = ProductionBaseURL
        }
        
        // Setup
        let url = NSURL(string: baseURL + "/" + Traitify.Version + path)
        let username = Traitify.PublicKey
        let password = "x"
        let loginString = NSString(format: "%@:%@", username, password)
        let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!
        let base64LoginString = loginData.base64EncodedStringWithOptions([])
        
        // Request
        let request = NSMutableURLRequest(URL: url!)
        if params != nil {
            request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params!, options: .PrettyPrinted)
        }
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        request.HTTPMethod = method
        
        return request
    }
    
    static func get(path: String, params: AnyObject?, callback: (NSData?, NSURLResponse?, NSError?) -> Void) {
        let request = Traitify.setupRequest(path, params: params, method: "GET")
        let session = NSURLSession.sharedSession()
        
        session.dataTaskWithRequest(request, completionHandler: callback).resume()
    }
    
    static func getDecks(callback: (NSData?, NSURLResponse?, NSError?) -> Void) {
        get("/decks?image_pack=linear&data=personality_types", params: nil, callback: callback)
    }
}
