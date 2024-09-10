//
//  String+Extensions.swift
//  Luminary
//
//  Created by Yago Vanzan on 10/09/24.
//

import Foundation

extension String {
    // Converts string timestamps to the correct format (MM:SS or HH:MM:SS)
    func toTimeFormat() -> String? {
        // Check if it's already in "HH:MM:SS" or "MM:SS" format
        let components = self.split(separator: ":").map { Int($0) ?? 0 }
        
        // If it's "HH:MM:SS" format
        if components.count == 3 {
            let hours = components[0]
            let minutes = components[1]
            let seconds = components[2]
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        } else if components.count == 2 {
            // If it's "MM:SS" format
            let minutes = components[0]
            let seconds = components[1]
            return String(format: "%02d:%02d", minutes, seconds)
        }
        
        // If the string represents a number of seconds
        if let totalSeconds = Int(self) {
            let hours = totalSeconds / 3600
            let minutes = (totalSeconds % 3600) / 60
            let seconds = totalSeconds % 60
            
            if hours > 0 {
                return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
            } else {
                return String(format: "%02d:%02d", minutes, seconds)
            }
        }
        
        return nil
    }
}
