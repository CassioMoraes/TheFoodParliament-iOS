//
//  PlacesService.swift
//  TheFoodParlament
//
//  Created by Cassio Moraes on 30/04/17.
//  Copyright © 2017 Cassio Moraes. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class PlacesService {
    var allRestaurants = [Restaurant]()
    var onFetchEnded: ((_ data: [Restaurant]) -> Void)?
    
    func fetchPlacesNearCoordinate(latitude: Double, longitude: Double){
        let urlRequest = String(format: Constants.GooglePlacesApi.BaseUrl, latitude, longitude, getAPIKey(apiName: "PlacesAPIKey"))
        
        Alamofire.request(urlRequest).responseJSON { response in
            //print(response.request)
            //print(response.result.value)
            
            let responseAsJson = JSON(response.result.value!)
            
            for (_,resultsJson):(String, JSON) in responseAsJson["results"] {
                
                let newRestaurant = Restaurant(id: resultsJson["id"].stringValue, name: resultsJson["name"].stringValue, location:resultsJson["vicinity"].stringValue, distance: 0)
                
                self.allRestaurants.append(newRestaurant)
            }
            
            self.onFetchEnded?(self.allRestaurants)
        }
    }
}
