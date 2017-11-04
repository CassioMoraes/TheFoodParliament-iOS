//
//  RestaurantViewControllerExtension.swift
//  TheFoodParlament
//
//  Created by Cassio Moraes on 27/05/17.
//  Copyright © 2017 Cassio Moraes. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import UserNotifications

extension RestaurantViewController: RestaurantView {
    
    func startLoading() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func finishLoading() {
        self.refreshControl?.endRefreshing()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func setRestaurants(_ restaurants: [Restaurant]) {
        self.restaurants = restaurants
        tableView?.isHidden = false
        tableView?.reloadData()
    }
    
    func setEmptyRestaurants() {
        tableView?.isHidden = true
    }
    
    func setElectionState(electionState: Bool) {
        if electionState {
            electionStatusLabel.text = "Election is open"
        } else {
            electionStatusLabel.text = "Election is closed"
        }
        tableView?.reloadData()
    }
}
