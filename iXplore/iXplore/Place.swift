//
//  Place.swift
//  iXplore
//
//  Created by Serene Mirza on 6/13/16.
//  Copyright © 2016 Natalie Polk. All rights reserved.
//

import Foundation
import MapKit

class Place: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()
    var title: String? = ""
    var imageURL: String?
    //var ratable: Bool = true
    
    class func placeList() -> [Place] {
        
        let spot1 = Place ()
        spot1.title = "Workshop 17"
        spot1.imageURL = "https://avatars1.githubusercontent.com/u/7220596?v=3&s=200"
        spot1.coordinate = CLLocationCoordinate2D(latitude: -33.906764,longitude: 18.4164983)
        
        let spot2 = Place ()
        spot2.title = "Truth Coffee"
        //spot2.ratable = false
        spot2.imageURL = "https://robohash.org/123.png"
        spot2.coordinate = CLLocationCoordinate2D(latitude: -33.9281976,longitude: 18.4227045)
        
        let spot3 = Place ()
        spot3.title = "Chop Chop Coffee"
        //spot3.ratable = true
        spot3.imageURL = "http://cdn3.ixperience.co.za/assets/icons/interview-step-2-801f63110f89e85e38f27d39f5864a1399f256fe0684844caea2a18c4b6fbd33.svg"
        spot3.coordinate = CLLocationCoordinate2D(latitude: -33.9271879,longitude: 18.4327055)
        
        return [spot1,spot2, spot3]
    }
    
}


extension UIImageView   {
    
    
    public func imageFromUrl(urlString: String) {
        if let url = NSURL(string: urlString) {
            let request = NSURLRequest(URL: url)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
                (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                if let imageData = data as NSData? {
                    self.image = UIImage(data: imageData)
                }
            }
        }
    }
    
}
