//
//  Item.swift
//  ccPositionManager
//
//  Created by Harold Tomlinson on 2024-12-21.
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
