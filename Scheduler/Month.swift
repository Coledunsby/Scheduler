//
//  Month.swift
//  Scheduler
//
//  Created by Cole Dunsby on 2016-08-11.
//  Copyright © 2016 Cole Dunsby. All rights reserved.
//

import Foundation

public enum Month: Int, CustomStringConvertible {
    
    case january = 1
    case february = 2
    case march = 3
    case april = 4
    case may = 5
    case june = 6
    case july = 7
    case august = 8
    case september = 9
    case october = 10
    case november = 11
    case december = 12
    
    public static func months() -> [Month] {
        return [.january, .february, .march, .april, .may, .june, .july, .august, .september, .october, .november, .december]
    }
    
    public var index: Int {
        return rawValue - 1
    }
    
    public var previous: Month {
        return Month(rawValue: rawValue == 1 ? 12 : rawValue - 1)!
    }
    
    public var next: Month {
        return Month(rawValue: rawValue % 12 + 1)!
    }
    
    // MARK: - CustomStringConvertible Protocol Conformance
    
    public var description: String {
        switch self {
        case .january:
            return "January"
        case .february:
            return "February"
        case .march:
            return "March"
        case .april:
            return "April"
        case .may:
            return "May"
        case .june:
            return "June"
        case .july:
            return "July"
        case .august:
            return "August"
        case .september:
            return "September"
        case .october:
            return "October"
        case .november:
            return "November"
        case .december:
            return "December"
        }
    }
}
