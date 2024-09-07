//
//  Item.swift
//  Luminary
//
//  Created by Yago Vanzan on 06/09/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
