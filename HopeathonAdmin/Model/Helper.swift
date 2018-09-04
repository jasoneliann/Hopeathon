//
//  Helper.swift
//  HopeathonAdmin
//
//  Created by Jason Elian on 04/09/18.
//  Copyright © 2018 Jason Elian. All rights reserved.
//

import Foundation

extension Date {
    
    func getTodayDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let result = formatter.string(from: date)
        return result
    }
    
    func convertToTimestamp(date : String) -> Int {
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyy-MM-dd HH:mm:ss"
        let date1 = dfmatter.date(from: date)
        let dateStamp : TimeInterval = date1!.timeIntervalSince1970
        return Int(dateStamp)
    }
    
    func convertToDate(date : String) -> Date {
        guard let newDate = Double(date) else {return Date()}
        return Date.init(timeIntervalSince1970: TimeInterval(newDate))
    }
    
    func setDifferenceDate(timestampPast : Int) -> String {
        let firstPress = Double(timestampPast)
        
        let pastDate = Date.init(timeIntervalSince1970: TimeInterval(firstPress))
        let secondsAgo = Int(Date().timeIntervalSince(pastDate))
        //        print("seconds ago \(secondsAgo)")
        let minute = 60
        let hour = minute * 60
        let day = 24 * hour
        let week = 7 * day
        let month = 4 * week
        
        var text = ""
        
//        if secondsAgo < minute {
//            text = "\(secondsAgo) seconds ago"
//        } else if secondsAgo < hour {
//            text = "\(secondsAgo / minute) minutes ago"
//        } else
            if secondsAgo < day {
            text = "\(secondsAgo / hour) hours ago"
        } else if secondsAgo < week {
            text = "\(secondsAgo / day) days ago"
        } else if secondsAgo < month {
            text = "\(secondsAgo / week) weeks ago"
        } else {
            text = "\(secondsAgo)"
        }
        
        return text
        
    }
    
    func setDifferenceDate(date : String) -> String {
        let timestampPast = Date().convertToTimestamp(date: date)
        
        let firstPress = Double(timestampPast)
        
        let pastDate = Date.init(timeIntervalSince1970: TimeInterval(firstPress))
        let secondsAgo = Int(Date().timeIntervalSince(pastDate))
        //        print("seconds ago \(secondsAgo)")
        let minute = 60
        let hour = minute * 60
        let day = 24 * hour
        let week = 7 * day
        
        var text = ""
        
        if secondsAgo < minute {
            text = "\(secondsAgo) seconds ago"
        } else if secondsAgo < hour {
            text = "\(secondsAgo / minute) minutes ago"
        } else if secondsAgo < day {
            text = "\(secondsAgo / hour) hours ago"
        } else if secondsAgo < week {
            text = "\(secondsAgo / day) days ago"
        } else {
            text = "\(secondsAgo / week) weeks ago"
        }
        
        return text
    }
    
}
