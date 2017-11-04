//
//  RestaurantsPresenter.swift
//  TheFoodParlament
//
//  Created by Cassio Moraes on 02/05/17.
//  Copyright © 2017 Cassio Moraes. All rights reserved.
//

import Foundation

class RestaurantsPresenter {
    
    var restaurants = [Restaurant]()
    private var electedRestaurants = [Restaurant]()
    private var allRestaurants = [Restaurant]()
    private var restaurantsOfWeek: [Int:String] = [:]
    
    var votesCollection: VotesCollection!
    
    private var serializator : FirebaseService!
    private var restaurantView : RestaurantView?
    private let placesService = PlacesService()
    private let locationService = LocationService()
    private let electionService = ElectionService()
    
    init() {
        votesCollection = VotesCollection(date: NSDate())
        
        serializator = FirebaseService()
        serializator.onDataChanged = { result in
            self.refetchAllData(votesCollection: result)
        }
        serializator.onRestaurantsOfWeekLoaded = { result in
            self.restaurantsOfWeek = result
            self.setCurrentAvailableRestaurants()
        }
        
        electionService.onStateChange = { result in
            self.restaurantView?.setElectionState(electionState: result)
        }
        
        electionService.onElectionReset = {
            self.votesCollection = VotesCollection(date: NSDate())
        }
    }
    
    func attachView(_ view:RestaurantView){
        restaurantView = view
        setViewInitialState()
    }
    
    func detachView() {
        restaurantView = nil
    }
    
    func getRestaurants() {
        self.restaurantView?.startLoading()
        
        locationService.requestLocation()
        locationService.onPositionUpdate = { result in
            self.placesService.fetchPlacesNearCoordinate(latitude: result.latitude, longitude: result.longitude)
            self.placesService.onFetchEnded = { restaurants in
                self.allRestaurants = restaurants
                self.restaurantView?.setRestaurants(restaurants)
                self.restaurantView?.finishLoading()
            }
        }
    }
    
    func setVote(restaurantId: String, userId: String, isOn: Bool)
    {
        if isOn {
            self.votesCollection.votes.append(Vote(userId: userId, restaurantId: restaurantId))
        } else {
            self.votesCollection.remove(restaurantId)
        }
        
        self.serializator.save(data: self.votesCollection)
    }
    
    func getElectedRestaurant() -> Restaurant? {
        var selectedRestaurant:Restaurant? = nil
        
        if restaurantsOfWeek.count > 0 {
            let winnerRestaurant = restaurantsOfWeek[restaurantsOfWeek.count - 1]
            selectedRestaurant = electedRestaurants.first(where: {$0.id == winnerRestaurant})
        }
        
        return selectedRestaurant
    }
    
    func isElectionEnabled(userId: String) -> Bool {
        return !votesCollection.contains(userId) && electionService.isElectionOpen;
    }
    
    func calculateVotesFor(restaurantId: String) -> String{
        return String(votesCollection.calculateVotesById(restaurantId))
    }
    
    private func setViewInitialState() {
        restaurantView?.setElectionState(electionState: electionService.isElectionOpen)
    }
    
    private func setCurrentAvailableRestaurants(){
        restaurants.removeAll()
        electedRestaurants.removeAll()
        
        for restaurant in allRestaurants {
            if !restaurantsOfWeek.values.contains(restaurant.id) {
                restaurants.append(restaurant)
            }
            else {
                electedRestaurants.append(restaurant)
            }
        }
    }
    
    private func refetchAllData(votesCollection: Any){
        self.votesCollection = votesCollection as! VotesCollection
        self.getRestaurants()
    }
}
