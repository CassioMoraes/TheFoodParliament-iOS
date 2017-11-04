//
//  RestaurantView.swift
//  TheFoodParlament
//
//  Created by Cassio Moraes on 13/05/17.
//  Copyright © 2017 Cassio Moraes. All rights reserved.
//

import Foundation

protocol RestaurantView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setRestaurants(_ restaurants: [Restaurant])
    func setEmptyRestaurants()
    func setElectionState(electionState: Bool)
}
