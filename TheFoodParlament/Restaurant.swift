//
//  Restaurant.swift
//  TheFoodParlament
//
//  Created by Cassio Moraes on 22/02/17.
//  Copyright © 2017 Cassio Moraes. All rights reserved.
//

class Restaurant {
	
	let id: String
	let name: String
	let location: String
	let distance: Float
	
	init(id: String, name: String, location: String, distance: Float) {
		self.id	 = id
		self.name = name
		self.location = location
		self.distance = distance
	}
}
