//
//  Date+Extensions.swift
//  Luminary
//
//  Created by Yago Vanzan on 10/09/24.
//

import Foundation

extension Date {
    func timeAgoSinceNow() -> String {
        let calendar = Calendar.current
        let now = Date()
        
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self, to: now)
        
        if let years = components.year, years > 0 {
            return "\(years) year" + (years > 1 ? "s" : "") + " ago"
        } else if let months = components.month, months > 0 {
            return "\(months) month" + (months > 1 ? "s" : "") + " ago"
        } else if let days = components.day, days > 0 {
            return "\(days) day" + (days > 1 ? "s" : "") + " ago"
        } else if let hours = components.hour, hours > 0 {
            return "\(hours) hour" + (hours > 1 ? "s" : "") + " ago"
        } else if let minutes = components.minute, minutes > 0 {
            return "\(minutes) minute" + (minutes > 1 ? "s" : "") + " ago"
        } else if let seconds = components.second, seconds > 0 {
            return "\(seconds) second" + (seconds > 1 ? "s" : "") + " ago"
        } else {
            return "Just now"
        }
    }
}
