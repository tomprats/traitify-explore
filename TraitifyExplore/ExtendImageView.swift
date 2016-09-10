//
//  ExtendImageView.swift
//  TraitifyExplore
//
//  Created by Tom Prats on 9/10/16.
//  Copyright © 2016 Tomify. All rights reserved.
//

import UIKit

extension UIImageView {
    public func imageFromUrl(urlString: String) {
        if let url = NSURL(string: urlString) {
            let request = NSMutableURLRequest(URL: url)
            NSURLSession.sharedSession().dataTaskWithRequest(request) {
                (data, response, error) in
                guard let data = data where error == nil else{
                    NSLog("Image download error: \(error)")
                    return
                }
                
                if let httpResponse = response as? NSHTTPURLResponse{
                    if httpResponse.statusCode > 400 {
                        let errorMsg = NSString(data: data, encoding: NSUTF8StringEncoding)
                        NSLog("Image download error, statusCode: \(httpResponse.statusCode), error: \(errorMsg!)")
                        return
                    }
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.image = UIImage(data: data)
                })
            }.resume()
        }
    }
}