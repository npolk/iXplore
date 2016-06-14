//
//  PlacesController.swift
//  iXplore
//
//  Created by Serene Mirza on 6/14/16.
//  Copyright © 2016 Natalie Polk. All rights reserved.
//

import Foundation


class PlacesController {
    
    var placesList: [Place] = []
    
    //SINGLETON
    class var sharedInstance: PlacesController {
        struct Static {
            static var instance:PlacesController?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token)    {
            Static.instance = PlacesController()
        }
        return Static.instance!
    }
    
    /*  addPlace
     *
     *  Accepts all the attributes on the place model then creates and
     *  stores a new instance on the array 
     *  Persists the new place
     */
    func addPlace(spot: Place) {
        //set current date
        spot.date = NSDate()
        
        //append the new place onto the given array
        placesList.append(spot)
        
        //store in memory
        PersistenceManager.saveNSArray(placesList, fileName: "array")
        
    }
    
    func readPlacesFromMemory() -> [Place] {
        let array: [Place] = PersistenceManager.loadNSArray("array") as! [Place]
        return array
    }
    
    func getPlaces() {
        
        //if placesList is empty
        if placesList.isEmpty {
            //call the readPlacesFromMemory before returning the array
            placesList = readPlacesFromMemory()
            
            //If the array is still empty after reading the disk, return testing data
            if placesList.isEmpty {
                placesList = Place.placeList()
            }
            
        }
    }
}

