//
//  Place.swift
//  iXplore
//
//  Created by Serene Mirza on 6/13/16.
//  Copyright © 2016 Natalie Polk. All rights reserved.
//

import Foundation
import MapKit

class Place: NSObject, MKAnnotation, NSCoding {
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()
    var title: String? = ""
    var imageURL: String?
    var describe:String? = ""
    var date = NSDate()
    var favorite: Bool = false
    
    
    required init(title:String?, date:NSDate, coordinate:CLLocationCoordinate2D, describe:String?) {
        self.title = title
        self.date = date
        self.coordinate = coordinate
        self.describe = describe
        self.imageURL = nil
        self.favorite = false
        
    }
    
    // MARK: - NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.title, forKey: "title")
        aCoder.encodeObject(self.date, forKey: "date")
        aCoder.encodeObject(NSNumber(double: self.coordinate.latitude), forKey: "lat")
        aCoder.encodeObject(NSNumber(double: self.coordinate.longitude), forKey: "long")
        aCoder.encodeObject(self.describe, forKey: "describe")
        
        
    }
    
    //initialize values from harddrive
    required convenience init?(coder aDecoder: NSCoder) {
        
        let title = aDecoder.decodeObjectForKey("title") as? String
        let date = aDecoder.decodeObjectForKey("date") as? NSDate
        let lat = aDecoder.decodeObjectForKey("lat") as! Double
        let long = aDecoder.decodeObjectForKey("long") as! Double
        let describe = aDecoder.decodeObjectForKey("describe") as? String
        
        var decodeCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()
        decodeCoordinate.latitude = lat as CLLocationDegrees
        decodeCoordinate.longitude = long as CLLocationDegrees
        
        self.init(title:title, date:date!, coordinate:decodeCoordinate, describe:describe)
        
    }

    
    
    //var ratable: Bool = true
    
    class func placeList() -> [Place] {
        
        let spot1 = Place(title: "Workshop 17", date: NSDate(), coordinate: CLLocationCoordinate2D(latitude: -33.906764,longitude: 18.4164983), describe: "Classroom location")
        spot1.imageURL = "https://avatars1.githubusercontent.com/u/7220596?v=3&s=200"
        spot1.favorite = true
        
        let spot2 = Place(title: "Truth Coffee", date: NSDate(), coordinate: CLLocationCoordinate2D(latitude: -33.9281976,longitude: 18.4227045), describe: "")
        spot2.imageURL = "https://robohash.org/123.png"
        
        let spot3 = Place(title: "Chop Chop Coffee", date: NSDate(), coordinate: CLLocationCoordinate2D(latitude: -33.9271879,longitude: 18.4327055), describe: "")
        
        let spot4 = Place(title: "Never@Home", date: NSDate(), coordinate: CLLocationCoordinate2D(latitude: -33.907731,longitude: 18.409117), describe: "Lodging Area")
        spot4.imageURL = "http://neverathomeworld.com/wp-content/uploads/2014/12/Never@home-Logo-625x230.jpg"
        
        let spot5 = Place(title: "Cape Town Stadium", date: NSDate(), coordinate: CLLocationCoordinate2D(latitude: -33.904827,longitude: 18.410094), describe: "")
        spot5.imageURL = "https://upload.wikimedia.org/wikipedia/en/7/7c/Cape_Town_Stadium_Aerial_View.jpg"
        
        let spot6 = Place(title: "Boulders Beach", date: NSDate(), coordinate: CLLocationCoordinate2D(latitude: -34.195900,longitude: 18.449530), describe: "")
        
        
        PersistenceManager.saveNSArray([spot1,spot2, spot3, spot4, spot5, spot6], fileName: "array")
        return [spot1,spot2, spot3, spot4, spot5, spot6]
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
