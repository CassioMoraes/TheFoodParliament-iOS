//
//  Votes.swift
//  TheFoodParlament
//
//  Created by Cassio Moraes on 27/02/17.
//  Copyright © 2017 Cassio Moraes. All rights reserved.
//

import Foundation

class Vote {
	let userId: String
	let restaurantId: String
	
	init(userId: String, restaurantId: String){
		self.userId = userId
		self.restaurantId = restaurantId
	}
}
