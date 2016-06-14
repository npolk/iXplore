//
//  LandingViewController.swift
//  iXplore
//
//  Created by Serene Mirza on 6/13/16.
//  Copyright © 2016 Natalie Polk. All rights reserved.
//

import UIKit
import MapKit

class CustomPointAnnotation: MKPointAnnotation {
    var imageName: String!
}

class LandingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    var placesList: [Place] = Place.placeList()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = true
        
        self.mapView.delegate = self
        
        setupMapView()
        setupTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupMapView() {
        self.mapView.mapType = .Hybrid
        self.mapView.showsBuildings = true
        self.mapView.addAnnotations(self.placesList)
        
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
        return self.placesList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SpotTableViewCell", forIndexPath: indexPath) as! SpotTableViewCell
        let spot = placesList[indexPath.row]
        cell.label.text = spot.title!
        print("cell.label = \(spot.title!)")
        cell.logo.imageFromUrl(spot.imageURL!)
        cell.describe.text = spot.describe!
        
        //date stuff
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm"
        cell.date.text = dateFormatter.stringFromDate(spot.date)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let spot = placesList[indexPath.row]
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let mapCenterAfterMove = CLLocationCoordinate2D(latitude: self.placesList[indexPath.row].coordinate.latitude, longitude: self.placesList[indexPath.row].coordinate.longitude)
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
            //add code here for when you hit delete
            self.mapView.removeAnnotation(self.placesList[indexPath.row])
            self.placesList.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
        action1.backgroundColor = UIColor.redColor()
        
        
        //MAKE FAVORITE
        let action2 = UITableViewRowAction(style: .Normal, title: "Favorite") { action, index in
            print("Action 2 tapped")
            self.mapView.removeAnnotation(self.placesList[indexPath.row])
            self.placesList[indexPath.row].favorite = true
            self.mapView.addAnnotation(self.placesList[indexPath.row])
        }
        action2.backgroundColor = UIColor.orangeColor()
        
        
        return [action2, action1]
    }
    

}
