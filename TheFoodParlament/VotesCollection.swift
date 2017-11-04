//
//  Votes.swift
//  TheFoodParlament
//
//  Created by Cassio Moraes on 04/03/17.
//  Copyright © 2017 Cassio Moraes. All rights reserved.
//

import Foundation

class VotesCollection {
	var votes = [Vote]()
	let date: NSDate!
	
	init(date: NSDate){
		self.date = date
	}
	
	func calculateVotesById(_ id: String) -> Int {
		var totalVotes = 0
		
		for vote in votes {
			if vote.restaurantId == id {
				totalVotes += 1
			}
		}
		
		return totalVotes
	}
	
	func remove(_ id: String) {
		votes = votes.filter() { $0.restaurantId != id}
	}
	
	func contains(_ voterId: String) -> Bool {
		return votes.contains {vote in vote.userId == voterId}
	}
    
    func getMostVoted() -> String {
        var votesPerRestaurant = [String:Int]()
        
        for vote in votes {
            if (votesPerRestaurant[vote.restaurantId] != nil) {
                votesPerRestaurant[vote.restaurantId] = votesPerRestaurant[vote.restaurantId]! +  1;
            } else {
                votesPerRestaurant[vote.restaurantId] = 1;
            }
        }
        
        var winningRestaurant = String()
        var mostVotes = 0
        
        for item in votesPerRestaurant {
            if (item.value > mostVotes){
                mostVotes = item.value
                winningRestaurant = item.key
            }
        }
       
        return winningRestaurant
    }
}
