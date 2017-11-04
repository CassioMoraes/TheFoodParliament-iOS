//
//  LocationService.swift
//  TheFoodParlament
//
//  Created by Cassio Moraes on 13/05/17.
//  Copyright © 2017 Cassio Moraes. All rights reserved.
//

import Foundation
import CoreLocation

class LocationService : NSObject, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    private var position: Position
    
    var onPositionUpdate: ((_ position: Position) -> Void)?
    
    override init() {
        position = Position(latitude: 0, longitude: 0)
        super.init()
        initializeLocationService()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0]
        
        self.position = Position(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        self.onPositionUpdate!(self.position)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager crashed")
    }
    
    func requestLocation() {
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            self.locationManager.requestLocation()
        }
    }
    
    private func initializeLocationService() {
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        }
    }
}
