//
//  NewPlaceViewController.swift
//  iXplore
//
//  Created by Serene Mirza on 6/14/16.
//  Copyright © 2016 Natalie Polk. All rights reserved.
//

import UIKit
import MapKit

class NewPlaceViewController: UIViewController {
    
    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var describeField: UITextField!
    @IBOutlet weak var lat: UITextField!
    @IBOutlet weak var long: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var currentLocation = appDelegate.locationManager!.location!
        
        long.text = "\(currentLocation.coordinate.longitude)"
        lat.text = "\(currentLocation.coordinate.latitude)"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonTapped(sender: AnyObject) {
        //close modal view controller
        self.dismissViewControllerAnimated(false, completion: nil)

    }

    @IBAction func saveButtonTapped(sender: AnyObject) {
        var coord: CLLocationCoordinate2D = CLLocationCoordinate2D()
        coord.latitude = CLLocationDegrees(Double(lat.text!)!)
        coord.longitude = CLLocationDegrees(Double(long.text!)!)
        
        let newPlace = Place(title: titleField.text, date: NSDate(), coordinate: coord, describe: describeField.text)
        PlacesController.sharedInstance.addPlace(newPlace)
        
        PlacesController.sharedInstance.getPlaces()
        
        self.dismissViewControllerAnimated(false, completion: nil)
        
    }
    

}
