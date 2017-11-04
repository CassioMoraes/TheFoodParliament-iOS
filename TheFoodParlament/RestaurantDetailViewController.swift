//
//  RestaurantDetailViewController.swift
//  TheFoodParlament
//
//  Created by Cassio Moraes on 09/04/17.
//  Copyright © 2017 Cassio Moraes. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController {
    
    @IBOutlet weak var RestaurantAdressLabel: UILabel!
    @IBOutlet weak var RestaurantNameLabel: UILabel!
    
    var restaurant: Restaurant?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let restaurant = restaurant {
            RestaurantAdressLabel.text = restaurant.location
            RestaurantNameLabel.text = restaurant.name
        }
    }
}
