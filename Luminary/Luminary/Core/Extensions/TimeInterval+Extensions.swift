//
//  TimeInterval+Extensions.swift
//  Luminary
//
//  Created by Yago Vanzan on 10/09/24.
//

import Foundation
import SwiftUI

extension TimeInterval {
    func toTimeString() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = [.pad]
        
        return formatter.string(from: self) ?? "Invalid Time Interval"
    }
}
