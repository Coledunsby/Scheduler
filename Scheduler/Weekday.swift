//
//  Weekday.swift
//  Scheduler
//
//  Created by Cole Dunsby on 2016-08-11.
//  Copyright © 2016 Cole Dunsby. All rights reserved.
//

import Foundation

public enum Weekday: Int, CustomStringConvertible {
    
    case sunday = 1
    case monday = 2
    case tuesday = 3
    case wednesday = 4
    case thursday = 5
    case friday = 6
    case saturday = 7
    
    public static func weekdays() -> [Weekday] {
        return [.sunday, .monday, .tuesday, .wednesday, .thursday, .friday, .saturday]
    }
    
    public var index: Int {
        return rawValue - 1
    }
    
    public var previous: Weekday {
        return Weekday(rawValue: rawValue == 1 ? 12 : rawValue - 1)!
    }
    
    public var next: Weekday {
        return Weekday(rawValue: rawValue % 12 + 1)!
    }
    
    // MARK: - CustomStringConvertible Protocol Conformance
    
    public var description: String {
        switch self {
        case .sunday:
            return "Sunday"
        case .monday:
            return "Monday"
        case .tuesday:
            return "Tuesday"
        case .wednesday:
            return "Wednesday"
        case .thursday:
            return "Thursday"
        case .friday:
            return "Friday"
        case .saturday:
            return "Saturday"
        }
    }
}
