//
//  Timeslot.swift
//  Scheduler
//
//  Created by Cole Dunsby on 2016-08-11.
//  Copyright © 2016 Cole Dunsby. All rights reserved.
//

import Foundation
import SwiftDate

public struct Timeslot {
    
    public var startDate: Date
    public var endDate: Date
    
    public var tuple: (Date, Date) {
        return (startDate, endDate)
    }
    
    public var array: [Date] {
        return [startDate, endDate]
    }
    
    public init(startDate: Date, endDate: Date) {
        self.startDate = min(startDate, endDate)
        self.endDate = max(startDate, endDate)
    }
    
    public init(tuple: (Date, Date)) {
        self.init(startDate: tuple.0, endDate: tuple.1)
    }
    
    public init?(dates: [Date]) {
        guard dates.count == 2 else { return nil }
        self.init(startDate: dates[0], endDate: dates[1])
    }
    
    public static func timeslots(fromDates dates: [Date]?) -> [Timeslot]? {
        guard let dates = dates, dates.count > 0 && dates.count % 2 == 0 else { return nil }
        
        var timeslots = [Timeslot]()
        for i in 0 ..< dates.count where i % 2 == 0 {
            timeslots.append(Timeslot(startDate: dates[i], endDate: dates[i + 1]))
        }
        return timeslots
    }
    
    public static func timeslots(fromTuples tuples: [(Date, Date)]?) -> [Timeslot]? {
        guard let tuples = tuples, tuples.count > 0 else { return nil }
        
        var timeslots = [Timeslot]()
        for i in 0 ..< tuples.count {
            timeslots.append(Timeslot(startDate: tuples[i].0, endDate: tuples[i].1))
        }
        return timeslots
    }
    
    public func overlaps(_ timeslot: Timeslot) -> Bool {
        return (startDate > timeslot.startDate && startDate < timeslot.endDate) ||
            (endDate > timeslot.startDate && endDate < timeslot.endDate) ||
            (startDate < timeslot.startDate && endDate > timeslot.endDate) ||
            (startDate == timeslot.startDate && endDate == timeslot.endDate)
    }
    
    public func contains(_ date: Date) -> Bool {
        return startDate.hour ... endDate.hour ~= date.hour &&
            startDate.minute ... endDate.minute ~= date.minute
    }
}

// MARK: - Equatable
extension Timeslot: Equatable {}

public func == (lhs: Timeslot, rhs: Timeslot) -> Bool {
    return lhs.startDate == rhs.startDate && lhs.endDate == rhs.endDate
}
