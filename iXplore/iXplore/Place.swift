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
    var describe:String? = ""
    var date = NSDate()
    var favorite: Bool = false
    
    
    //var ratable: Bool = true
    
    class func placeList() -> [Place] {
        
        let spot1 = Place ()
        spot1.title = "Workshop 17"
        spot1.imageURL = "https://avatars1.githubusercontent.com/u/7220596?v=3&s=200"
        spot1.coordinate = CLLocationCoordinate2D(latitude: -33.906764,longitude: 18.4164983)
        spot1.favorite = true
        
        let spot2 = Place ()
        spot2.title = "Truth Coffee"
        spot2.imageURL = "https://robohash.org/123.png"
        spot2.coordinate = CLLocationCoordinate2D(latitude: -33.9281976,longitude: 18.4227045)
        
        let spot3 = Place ()
        spot3.title = "Chop Chop Coffee"
        spot3.imageURL = "http://cdn3.ixperience.co.za/assets/icons/interview-step-2-801f63110f89e85e38f27d39f5864a1399f256fe0684844caea2a18c4b6fbd33.svg"
        spot3.coordinate = CLLocationCoordinate2D(latitude: -33.9271879,longitude: 18.4327055)
        
        let spot4 = Place ()
        spot4.title = "Never@Home"
        spot4.imageURL = "http://neverathomeworld.com/wp-content/uploads/2014/12/Never@home-Logo-625x230.jpg"
        spot4.coordinate = CLLocationCoordinate2D(latitude: -33.907731,longitude: 18.409117)
        
        let spot5 = Place ()
        spot5.title = "Cape Town Stadium"
        spot5.imageURL = "https://upload.wikimedia.org/wikipedia/en/7/7c/Cape_Town_Stadium_Aerial_View.jpg"
        spot5.coordinate = CLLocationCoordinate2D(latitude: -33.904827,longitude: 18.410094)
        
        let spot6 = Place ()
        spot6.title = "Polk House"
        spot6.imageURL = "http://images.clipartpanda.com/happy-face-black-and-white-jRcARBjTL.jpeg"
        spot6.coordinate = CLLocationCoordinate2D(latitude: 39.417619,longitude: -76.651711)
        
        let spot7 = Place ()
        spot7.title = "Boulders Beach"
        spot7.imageURL = "http://images.clipartpanda.com/penguin-clip-art-yckB78ocE.png"
        spot7.coordinate = CLLocationCoordinate2D(latitude: -34.195900,longitude: 18.449530)
        
        
        
        return [spot1,spot2, spot3, spot4, spot5, spot6, spot7]
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
