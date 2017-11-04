//
//  FirebaseService.swift
//  TheFoodParlament
//
//  Created by Cassio Moraes on 14/03/17.
//  Copyright © 2017 Cassio Moraes. All rights reserved.
//

import Foundation
import FirebaseDatabase
import SwiftyJSON

class FirebaseService : Serializable {
    typealias T = VotesCollection
    
    var onDataChanged: ((_ data: VotesCollection) -> Void)?
    var onRestaurantsOfWeekLoaded: ((_ data: [Int:String]) -> Void)?
    var firebase: FIRDatabaseReference!
    
    required init() {
        firebase = FIRDatabase.database().reference(withPath: "dailyElection")
        load()
        
        let startDay = DateHelper.getFirstDayOfWeek(date: Date())
        let endDay = DateHelper.getLastDayOfWeek(date: Date())
        
        getElectedOfWeek(startDay: startDay!, endDay: endDay!)
    }
    
    func save(data: VotesCollection) {
        let dateKey = DateHelper.getDateAsString(date: data.date as Date)
        let dateChildKey = firebase.child(dateKey).childByAutoId().key
        
        for vote in 0..<data.votes.count {
            let post = [
                "userId": data.votes[vote].userId,
                "restaurantId": data.votes[vote].restaurantId]
            
            let childUpdates = ["/\(dateKey)/\(dateChildKey)": post	]
            firebase.updateChildValues(childUpdates)
        }
    }
    
    func load() {
        firebase.observe(.value, with: { snapshot in
            let votesCollection = VotesCollection(date: NSDate())
            
            let dateKey = DateHelper.getDateAsString(date: NSDate() as Date)
            
            let result = JSON(snapshot.value!)
            
            for (_,resultsJson):(String, JSON) in result[dateKey] {
                let vote = Vote(userId: resultsJson["userId"].stringValue, restaurantId: resultsJson["restaurantId"].stringValue)
                votesCollection.votes.append(vote)
            }
            self.onDataChanged?(votesCollection)
        })
    }
    
    func getElectedOfWeek(startDay: Date, endDay: Date) {
        
        let keyOrderting = firebase.queryOrderedByKey()
        
        keyOrderting.observe(.value, with: { (snapshot) in
            
            var restaurantsOfWeek = [Int:String]()
            var entries = 0
            let result = JSON(snapshot.value!)
            
            for entry in (result.dictionary?.keys)! {
                let entryAsDate = DateHelper.getDateFromString(date: entry)
                
                if (entryAsDate! >= startDay && entryAsDate! <= endDay) {
                    let votesCollection = VotesCollection(date: entryAsDate! as NSDate)
                    
                    for (_,resultsJson):(String, JSON) in result[entry] {
                        let vote = Vote(userId: resultsJson["userId"].stringValue, restaurantId: resultsJson["restaurantId"].stringValue)
                        votesCollection.votes.append(vote)
                    }
                    
                    restaurantsOfWeek[entries] = votesCollection.getMostVoted()
                    entries = entries + 1
                }
            }
            
            self.onRestaurantsOfWeekLoaded!(restaurantsOfWeek)
        })
    }
}
