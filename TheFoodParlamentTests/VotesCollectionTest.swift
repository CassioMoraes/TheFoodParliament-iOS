//
//  VotesCollectionTest.swift
//  TheFoodParlament
//
//  Created by Cassio Moraes on 04/03/17.
//  Copyright © 2017 Cassio Moraes. All rights reserved.
//

import XCTest
@testable import TheFoodParlament

class VotesCollectionTest : XCTestCase {
	
	var votesCollection: VotesCollection!
	
	override func setUp() {
		super.setUp()
		
		votesCollection = VotesCollection(date: NSDate())
		
		votesCollection.votes.append(Vote(userId: "0",restaurantId: "0"))
		votesCollection.votes.append(Vote(userId: "1",restaurantId: "0"))
		votesCollection.votes.append(Vote(userId: "2",restaurantId: "5"))
		votesCollection.votes.append(Vote(userId: "3",restaurantId: "4"))
		votesCollection.votes.append(Vote(userId: "4",restaurantId: "4"))
        votesCollection.votes.append(Vote(userId: "5",restaurantId: "4"))
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	func testCalculateVotesById_TestingWithExistingIds(){
		let votesOnId0 = votesCollection.calculateVotesById("0")
		XCTAssertEqual(2, votesOnId0)
		
		let votesOnId4 = votesCollection.calculateVotesById("4")
		XCTAssertEqual(3, votesOnId4)
	}
	
	func testCalculateVotesById_TestingWithNonExistingIds(){
		let votesOnId999 = votesCollection.calculateVotesById("999")
		XCTAssertEqual(0, votesOnId999)
	}
	
	func testContains_TestingWithExistingVotersIds(){
		let contains3 = votesCollection.contains("3")
		XCTAssertTrue(contains3)
		
		let contains0 = votesCollection.contains("0")
		XCTAssertTrue(contains0)
	}
	
	func testContains_TestingWithNonExistingVotersIds(){
		let containsASD = votesCollection.contains("ASD")
		XCTAssertFalse(containsASD)
		
		let contains99 = votesCollection.contains("99")
		XCTAssertFalse(contains99)

	}
	
	func testRemove_TestingWithExistingIds(){
		votesCollection.remove("0")
		XCTAssertEqual(4, votesCollection.votes.count)
	}
	
	func testRemove_TestingWithNonExistingIds(){
		votesCollection.remove("qwerty")
		XCTAssertEqual(6, votesCollection.votes.count)
	}
    
    func testGetMostVoted() {
        let result = votesCollection.getMostVoted()
        XCTAssertEqual("4", result)
    }
}
