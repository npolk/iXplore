//
//  LandingViewController.swift
//  iXplore
//
//  Created by Serene Mirza on 6/13/16.
//  Copyright © 2016 Natalie Polk. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class CustomPointAnnotation: MKPointAnnotation {
    var imageName: String!
}

class LandingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate, UITextFieldDelegate, CLLocationManagerDelegate {
    
    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var locationManager: CLLocationManager!

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    //var placesList: [Place] = Place.placeList()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        PlacesController.sharedInstance.getPlaces()
        setupMapView()
        setupTableView()
        
        self.mapView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*  location Manager
     *  
     *  this runs when the alert box (which requests location access) appears
     *  actions taken depending if user allows or denies
     */
    func locationManager(manager:CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        var shouldIAllow:Bool = false
        
        switch status {
        case .Denied:
            print("User denied access to location")
            //action
        case .Restricted:
            print("Restricted access to location")
            //action
        case .NotDetermined:
            print("Status not determined")
            //action
        default:
            print("Allowed to access location")
            shouldIAllow = true
        }
        
        
    }
    
    
    func setupMapView() {
        self.mapView.mapType = .Hybrid
        self.mapView.showsBuildings = true
        self.mapView.addAnnotations(PlacesController.sharedInstance.placesList)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        self.navigationController?.navigationBarHidden = false
        
        PlacesController.sharedInstance.getPlaces()
        setupMapView()
        setupTableView()
        //UPDATE TABLE
        tableView.reloadData()
    
        
        let plusButton : UIBarButtonItem = UIBarButtonItem(title: "+", style: UIBarButtonItemStyle.Plain, target: self, action: "openModal:")
        let logButton : UIBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.Plain, target: self, action: "returnHome:")
        
        self.navigationItem.leftBarButtonItem = logButton
        self.navigationItem.rightBarButtonItem = plusButton
    }
    
    /*  OpenModal
     *
     *  Opens the NewPlaceViewController as a modal
     *  excecuted when the + button (on navigation bar) is pressed
     */
    func openModal(Sender: UIBarButtonItem!) {
        appDelegate.locationManager = locationManager
        let secondViewController:NewPlaceViewController = NewPlaceViewController()
        self.presentViewController(secondViewController, animated: true, completion: nil)
    }
    
    
    
    /*  returnHome
     *
     *  navigates back to homescreen
     */
    func returnHome(Sender: UIBarButtonItem!) {
        appDelegate.navigateToHomeScreen()
        
    }
    
    
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
        let pin = annotation as! Place
        if !pin.favorite {
            return nil
        }
        
        if annotation is MKUserLocation {
            //return nil so map view draws "blue dot" for standard user location
            return nil
        }
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.animatesDrop = true
            pinView!.pinTintColor = UIColor.yellowColor()
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
        
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerClass(SpotTableViewCell.self, forCellReuseIdentifier: "SpotTableViewCell")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PlacesController.sharedInstance.placesList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SpotTableViewCell", forIndexPath: indexPath) as! SpotTableViewCell
        let spot = PlacesController.sharedInstance.placesList[indexPath.row]
        
        //add label name, logo, and description to table cell
        cell.label.text = spot.title!
        if spot.imageURL != nil {
            cell.logo.imageFromUrl(spot.imageURL!)
        }
        cell.describe.text = spot.describe!
        
        //only show star if favorite
        if PlacesController.sharedInstance.placesList[indexPath.row].favorite {
            cell.star.hidden = false
        }
        else {
            cell.star.hidden = true
        }
        
        //date stuff
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm"
        cell.date.text = dateFormatter.stringFromDate(spot.date)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let spot = PlacesController.sharedInstance.placesList[indexPath.row]
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let mapCenterAfterMove = CLLocationCoordinate2D(latitude: PlacesController.sharedInstance.placesList[indexPath.row].coordinate.latitude, longitude: PlacesController.sharedInstance.placesList[indexPath.row].coordinate.longitude)
        mapView.selectAnnotation(spot as! MKAnnotation, animated: true)
        let span = MKCoordinateSpanMake(0.01, 0.01)
        let region = MKCoordinateRegion(center: mapCenterAfterMove, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    /*-------------- functions for swiping table cell to delete or favorite -----------*/
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        //DELETE TABLE CELL
        let action1 = UITableViewRowAction(style: .Normal, title: "Delete") { action, index in
            //show alert asking if they are sure they want to delete
            let alertController = UIAlertController(title: "Are you sure you want to delete \(PlacesController.sharedInstance.placesList[indexPath.row].title!)?", message: "", preferredStyle: .Alert)
            
            //if delete is pressed
            let OKAction = UIAlertAction(title: "Delete", style: .Default) { (action) in
                //remove place from list and delete annotation
                self.mapView.removeAnnotation(PlacesController.sharedInstance.placesList[indexPath.row])
                PlacesController.sharedInstance.placesList.removeAtIndex(indexPath.row)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                //update stored array
                PlacesController.sharedInstance.saveArray()
            }
            alertController.addAction(OKAction)
            
            //if cancel is pressed
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in }
            alertController.addAction(cancelAction)
            self.presentViewController(alertController, animated: true) {}
        }
        action1.backgroundColor = UIColor.redColor()
        
        
        //MAKE FAVORITE
        let action2 = UITableViewRowAction(style: .Normal, title: "Favorite") { action, index in
            //make a favorite
            if !PlacesController.sharedInstance.placesList[indexPath.row].favorite {
                //delete red annotation
                self.mapView.removeAnnotation(PlacesController.sharedInstance.placesList[indexPath.row])
                //set as favorite
                PlacesController.sharedInstance.placesList[indexPath.row].favorite = true
            self.mapView.addAnnotation(PlacesController.sharedInstance.placesList[indexPath.row])
                
                //add star to table cell!!!!!!
            }
            
            //unfavorite
            else {
                //delete yellow annotation
                self.mapView.removeAnnotation(PlacesController.sharedInstance.placesList[indexPath.row])
                //set as not favorite
                PlacesController.sharedInstance.placesList[indexPath.row].favorite = false
            self.mapView.addAnnotation(PlacesController.sharedInstance.placesList[indexPath.row])
            }
            
        }
        action2.backgroundColor = UIColor.orangeColor()
        
        
        return [action1, action2]
    }
    
    
    /*-------------------------- function to show message alert ------------------------*/
    func showWarningAlert(title:String?, message:String?, button1:String?, button2:String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: button2, style: .Cancel) { (action) in }
        alertController.addAction(cancelAction)
        let OKAction = UIAlertAction(title: button1, style: .Default) { (action) in }
        alertController.addAction(OKAction)
        self.presentViewController(alertController, animated: true) {}
    }

}
