//
//  Constants.swift
//  TheFoodParlament
//
//  Created by Cassio Moraes on 06/04/17.
//  Copyright © 2017 Cassio Moraes. All rights reserved.
//

import Foundation

struct Constants {
    struct GooglePlacesApi {
        static let BaseUrl = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%f,%f&radius=500&rankby=prominence&sensor=true&name=restaurant&key=%@"
    }
}
