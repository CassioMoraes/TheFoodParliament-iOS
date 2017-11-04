//
//  ViewController.swift
//  TheFoodParlament
//
//  Created by Cassio Moraes on 22/02/17.
//  Copyright © 2017 Cassio Moraes. All rights reserved.
//

import UIKit
import MapKit
import GoogleMaps
import Alamofire
import SwiftyJSON

class RestaurantViewController: UITableViewController {
    
    @IBOutlet weak var electionStatusLabel: UILabel!
    
    var restaurants = [Restaurant]()
    var userDeviceId = String()
    var restaurantsPresenter: RestaurantsPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restaurantsPresenter = RestaurantsPresenter()
        restaurantsPresenter.attachView(self)
        restaurantsPresenter.getRestaurants()
        
        userDeviceId = UIDevice.current.identifierForVendor!.uuidString
        
        self.refreshControl?.addTarget(self, action: #selector(RestaurantViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "RestaurantTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RestaurantTableViewCell else {
            fatalError("The dequeued cell is no an instance of RestaurantTableViewCell")
        }
        
        if restaurants.count >= indexPath.row {
            let restaurant = restaurants[indexPath.row]
            
            cell.votedCallback = {(isOn: Bool) in
                self.restaurantsPresenter.setVote(restaurantId: restaurant.id, userId: self.userDeviceId, isOn: isOn)
                self.tableView.reloadData()
            }
            
            cell.restaurantId = restaurant.id
            cell.restaurantNameLabel!.text = restaurant.name
            cell.restaurantAddressLabel!.text = restaurant.location
            cell.totalDailyVotesLabel!.text = restaurantsPresenter.calculateVotesFor(restaurantId: restaurant.id)
            cell.voteSwitch.isEnabled = restaurantsPresenter.isElectionEnabled(userId: userDeviceId)
            
            if (restaurantsPresenter.votesCollection.votes.count == 0){
                cell.voteSwitch.isOn = false
            }
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        guard let restaurantDetailViewController = segue.destination as? RestaurantDetailViewController else {
            fatalError("Unexpected destination: \(segue.destination)")
        }
        
        restaurantDetailViewController.restaurant = restaurantsPresenter.getElectedRestaurant()
    }
    
    func handleRefresh(_ refreshControl: UIRefreshControl) {
        restaurantsPresenter.getRestaurants()
    }
}
