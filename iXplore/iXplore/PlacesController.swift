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
        
        //append the new place onto the given array
        placesList.append(spot)
        
        saveArray()
        
    }
    
    func saveArray() {
        //store in memory
        PersistenceManager.saveNSArray(placesList, fileName: "array")
        
    }
    
    func readPlacesFromMemory(){
        let array: [Place]? = PersistenceManager.loadNSArray("array") as? [Place]
        if array != nil {
            placesList = array!
        }
    }
    
    func getPlaces() {
        //if placesList is empty
        if placesList.isEmpty {
            
            //read places from memory
            readPlacesFromMemory()
            
            //if places exist in memory, placeList is now updated
            
            //if no places in memory, populate placeList with text date
            if placesList.isEmpty {
                placesList = Place.placeList()
            }
            
        }
    }
    
}

