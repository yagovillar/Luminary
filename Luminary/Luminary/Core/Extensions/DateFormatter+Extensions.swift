//
//  DateFormatter+Extensions.swift
//  Luminary
//
//  Created by Yago Vanzan on 09/09/24.
//

import Foundation

extension DateFormatter {
    static let primaryDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "E, dd MMM yyyy HH:mm:ss Z"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
    
    static let firstAlternativeDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "E, d MMM yyyy"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
    
    static let secondtAlternativeDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "E, dd MMM yyyy HH:mm:ss Z"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
    
    static let thirdAlternativeDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()

    static let alternativeDateFormatters: [DateFormatter] = [firstAlternativeDateFormatter, secondtAlternativeDateFormatter, thirdAlternativeDateFormatter]

    static func convertPubDate(_ pubDateString: String) -> Date? {
        let dateStr = pubDateString.trimmingCharacters(in: .whitespacesAndNewlines)

        if let date = primaryDateFormatter.date(from: dateStr) {
            return date
        }

        for formatter in alternativeDateFormatters {
            if let date = formatter.date(from: dateStr) {
                return date
            }
        }

        return nil
    }
}
