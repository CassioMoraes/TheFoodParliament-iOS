//
//  APIKeys.swift
//  TheFoodParlament
//
//  Created by Cassio Moraes on 04/03/17.
//  Copyright © 2017 Cassio Moraes. All rights reserved.
//
// Credit to the original source for this technique at
// http://blog.lazerwalker.com/blog/2014/05/14/handling-private-api-keys-in-open-source-ios-apps

import Foundation

func getAPIKey(apiName keyname:String) -> String {
	let filePath = Bundle.main.path(forResource: "APIKeys", ofType: "plist")
	let plist = NSDictionary(contentsOfFile:filePath!)
	let value = plist?.object(forKey: keyname) as! String
	return value
}
