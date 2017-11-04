//
//  ElectionService.swift
//  TheFoodParlament
//
//  Created by Cassio Moraes on 14/05/17.
//  Copyright © 2017 Cassio Moraes. All rights reserved.
//

import Foundation
import UserNotifications

class ElectionService {
    
    var onStateChange: ((_ state: Bool) -> Void)?
    var onElectionReset: (() -> Void)?
    
    var isElectionOpen: Bool = true
    private let electionOpeningTime = "11:00:00" //"11:00:00"
    private let electionClosingTime = "16:00:00" //"16:00:00"
    private let electionResetingTime = "02:55:59" //"02:59:59"
    
    init() {
        isElectionOpen = setElectionState()
        setTimerForElectionReset()
        setTimerForElectionOpening()
        setTimerForElectionClose()
    }
    
    @objc func resetElection() {
        onElectionReset?()
    }
    
    @objc func openElection() {
        isElectionOpen = true
        onStateChange?(true)
    }
    
    @objc func closeElection() {
        isElectionOpen = false
        onStateChange?(false)
    }
    
    func setElectionState() -> Bool {
        let startTime = DateHelper.getDateFromString(time: electionOpeningTime)! //"11:00:00"
        let endTime = DateHelper.getDateFromString(time: electionClosingTime)! //"16:00:00"
        let currentDate = Date()
        
        return DateHelper.isDateBetween(date: currentDate, start: startTime, end: endTime)
    }
    
    private func setTimerForElectionReset() {
        if let date = DateHelper.getDateFromString(time: electionResetingTime) {
            let timer = Timer(fireAt: date, interval: 86400, target: self, selector: #selector(resetElection), userInfo: nil, repeats: true)
            RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
        }
    }
    
    private func setTimerForElectionOpening() {
        if let date = DateHelper.getDateFromString(time: electionOpeningTime) {
            
            let timer = Timer(fireAt: date, interval: 86400, target: self, selector: #selector(openElection), userInfo: nil, repeats: true)
            RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
            
            let content = UNMutableNotificationContent()
            content.title = "The election is open!"
            content.body = "The election is open, you can now vote on your favorite restaurant!"
            content.sound = UNNotificationSound.default()
            
            let triggerDaily = Calendar.current.dateComponents([.hour,.minute,.second,], from: date)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true)
            
            let identifier = "ElectionOpen"
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request){(error) in
                if (error != nil){
                    print(error!)
                }
            }
        }
    }
    
    private func setTimerForElectionClose() {
        if let date = DateHelper.getDateFromString(time: electionClosingTime) {
            
            let timer = Timer(fireAt: date, interval: 86400, target: self, selector: #selector(closeElection), userInfo: nil, repeats: true)
            RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
            
            let content = UNMutableNotificationContent()
            content.title = "The election is close!"
            content.body = "The election is close, you can now see the winner!"
            content.sound = UNNotificationSound.default()
            
            let triggerDaily = Calendar.current.dateComponents([.hour,.minute,.second,], from: date)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true)
            
            let identifier = "ElectionClose"
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request){(error) in
                if (error != nil){
                    print(error!)
                }
            }
        }
    }
}
