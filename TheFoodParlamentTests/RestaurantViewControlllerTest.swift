//
//  RestaurantViewControlllerTest.swift
//  TheFoodParlament
//
//  Created by Cassio Moraes on 02/03/17.
//  Copyright © 2017 Cassio Moraes. All rights reserved.
//

import XCTest
@testable import TheFoodParlament

class RestaurantViewControllerTest: XCTestCase {
	
	var restaurantViewController: RestaurantViewController!
	
	override func setUp() {
		super.setUp()
		
		let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
		restaurantViewController = storyboard.instantiateViewController(withIdentifier: "RestaurantViewController") as! RestaurantViewController
		_ = restaurantViewController.view
		
		restaurantViewController.votesCollection = VotesCollection(date: NSDate())
		restaurantViewController.votesCollection.votes.append(Vote(userId: "0",restaurantId: "0"))
		restaurantViewController.votesCollection.votes.append(Vote(userId: "1",restaurantId: "0"))
		restaurantViewController.votesCollection.votes.append(Vote(userId: "2",restaurantId: "5"))
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	func testHandleRefresh() {
		restaurantViewController.restaurants.append(Restaurant(id: "0", name: "Zezinho", location: "não importa", distance: 10));
		restaurantViewController.handleRefresh(UIRefreshControl())
		
		XCTAssertEqual(restaurantViewController.restaurants.count, 0)
	}
	
	
	func testResetElection(){
		restaurantViewController.resetElection()
		XCTAssertEqual(0, restaurantViewController.votesCollection.votes.count)
	}
}
