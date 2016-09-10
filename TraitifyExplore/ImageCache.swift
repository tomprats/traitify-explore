//
//  ImageCache.swift
//  TraitifyExplore
//
//  Created by Tom Prats on 9/10/16.
//  Copyright © 2016 Tomify. All rights reserved.
//

import UIKit

class ImageCache {
    static var images: Dictionary = [String: UIImage]()

    class func use(link: String, callback: (UIImage) -> Void) {
        if let image = ImageCache.images[link] {
            callback(image)
        } else {
            ImageCache.download(link, callback: callback)
        }
    }
    
    class func download(link: String, callback: (UIImage) -> Void) {
        guard let url = NSURL(string: link) else { return }
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            guard
                let httpURLResponse = response as? NSHTTPURLResponse where httpURLResponse.statusCode == 200,
                let mimeType = response?.MIMEType where mimeType.hasPrefix("image"),
                let data = data where error == nil,
                let image = UIImage(data: data)
                else { return }
            dispatch_async(dispatch_get_main_queue(), {
                ImageCache.images[link] = image
                callback(image)
            })
        }.resume()
    }
}
