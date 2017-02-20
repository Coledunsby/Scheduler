//
//  Schedule.swift
//  Scheduler
//
//  Created by Cole Dunsby on 2016-08-11.
//  Copyright © 2016 Cole Dunsby. All rights reserved.
//

import Foundation

public struct Schedule {
    
    private var sunday = [Timeslot]()
    private var monday = [Timeslot]()
    private var tuesday = [Timeslot]()
    private var wednesday = [Timeslot]()
    private var thursday = [Timeslot]()
    private var friday = [Timeslot]()
    private var saturday = [Timeslot]()
    
    private var weekdays = [[Timeslot]]()
    
    public var is247: Bool {
        for weekday in Weekday.weekdays() {
            if !getTimeslots(for: weekday).contains(Timeslot(startDate: Date().startOfDay, endDate: Date().endOfDay)) {
                return false
            }
        }
        return true
    }
    
    // MARK: - Initializers
    
    public init() {
        commonInit()
    }
    
    public init(sunday: [Timeslot]?, monday: [Timeslot]?, tuesday: [Timeslot]?, wednesday: [Timeslot]?, thursday: [Timeslot]?, friday: [Timeslot]?, saturday: [Timeslot]?) {
        self.sunday = sunday ?? []
        self.monday = monday ?? []
        self.tuesday = tuesday ?? []
        self.wednesday = wednesday ?? []
        self.thursday = thursday ?? []
        self.friday = friday ?? []
        self.saturday = saturday ?? []
        
        commonInit()
    }
    
    public init(sunday: [Date]?, monday: [Date]?, tuesday: [Date]?, wednesday: [Date]?, thursday: [Date]?, friday: [Date]?, saturday: [Date]?) {
        self.sunday = Timeslot.timeslots(fromDates: sunday) ?? []
        self.monday = Timeslot.timeslots(fromDates: monday) ?? []
        self.tuesday = Timeslot.timeslots(fromDates: tuesday) ?? []
        self.wednesday = Timeslot.timeslots(fromDates: wednesday) ?? []
        self.thursday = Timeslot.timeslots(fromDates: thursday) ?? []
        self.friday = Timeslot.timeslots(fromDates: friday) ?? []
        self.saturday = Timeslot.timeslots(fromDates: saturday) ?? []
        
        commonInit()
    }
    
    public init(sunday: [(Date, Date)]?, monday: [(Date, Date)]?, tuesday: [(Date, Date)]?, wednesday: [(Date, Date)]?, thursday: [(Date, Date)]?, friday: [(Date, Date)]?, saturday: [(Date, Date)]?) {
        self.sunday = Timeslot.timeslots(fromTuples: sunday) ?? []
        self.monday = Timeslot.timeslots(fromTuples: monday) ?? []
        self.tuesday = Timeslot.timeslots(fromTuples: tuesday) ?? []
        self.wednesday = Timeslot.timeslots(fromTuples: wednesday) ?? []
        self.thursday = Timeslot.timeslots(fromTuples: thursday) ?? []
        self.friday = Timeslot.timeslots(fromTuples: friday) ?? []
        self.saturday = Timeslot.timeslots(fromTuples: saturday) ?? []
        
        commonInit()
    }
    
    public init?(timeslots: [[Timeslot]?]) {
        guard timeslots.count <= 7 else { return nil }
        
        self.init(
            sunday: timeslots[0],
            monday: timeslots[1],
            tuesday: timeslots[2],
            wednesday: timeslots[3],
            thursday: timeslots[4],
            friday: timeslots[5],
            saturday: timeslots[6]
        )
    }
    
    public init?(arrays: [[Date]?]) {
        guard arrays.count <= 7 else { return nil }
        
        self.init(
            sunday: arrays[0],
            monday: arrays[1],
            tuesday: arrays[2],
            wednesday: arrays[3],
            thursday: arrays[4],
            friday: arrays[5],
            saturday: arrays[6]
        )
    }
    
    public init?(tuples: [[(Date, Date)]?]) {
        guard tuples.count <= 7 else { return nil }
        
        self.init(
            sunday: tuples[0],
            monday: tuples[1],
            tuesday: tuples[2],
            wednesday: tuples[3],
            thursday: tuples[4],
            friday: tuples[5],
            saturday: tuples[6]
        )
    }
    
    // MARK: - Private Functions
    
    private mutating func commonInit() {
        weekdays = [self.sunday, self.monday, self.tuesday, self.wednesday, self.thursday, self.friday, self.saturday]
    }
    
    // MARK: - Public Functions
    
    public func hasTimeslots(for weekday: Weekday? = nil) -> Bool {
        return numberOfTimeslots(for: weekday) > 0
    }
    
    public func numberOfTimeslots(for weekday: Weekday? = nil) -> Int {
        if let weekday = weekday {
            return weekdays[weekday.index].count
        } else {
            return weekdays.reduce(0) { $0 + $1.count }
        }
    }
    
    public func getTimeslots(for weekday: Weekday? = nil) -> [Timeslot] {
        if let weekday = weekday {
            return weekdays[weekday.index]
        }
        return weekdays.reduce([]) { $0 + $1 }
    }
    
    public func getDates(for weekday: Weekday? = nil) -> [Date] {
        return getTimeslots(for: weekday).reduce([]) { $0 + $1.array }
    }
    
    public func getTuples(for weekday: Weekday? = nil) -> [(Date, Date)] {
        return getTimeslots(for: weekday).reduce([]) { $0 + [$1.tuple] }
    }
    
    // MARK: Mutating
    
    public mutating func add(_ timeslot: Timeslot, for weekday: Weekday) {
        var overlappingTimeslots = [Timeslot]()
        
        for otherTimeslot in weekdays[weekday.index] where otherTimeslot.overlaps(timeslot) {
            overlappingTimeslots.append(otherTimeslot)
        }
        
        guard overlappingTimeslots.count > 0 else {
            weekdays[weekday.index].append(timeslot)
            return
        }
        
        var startDate = timeslot.startDate
        var endDate = timeslot.endDate
        
        for otherTimeslot in overlappingTimeslots {
            if otherTimeslot.startDate < startDate {
                startDate = otherTimeslot.startDate
            }
            if otherTimeslot.endDate > endDate {
                endDate = otherTimeslot.endDate
            }
            weekdays[weekday.index].removeObject(otherTimeslot)
        }
        
        weekdays[weekday.index].append(Timeslot(startDate: startDate, endDate: endDate))
    }
    
    public mutating func add(_ timeslots: [Timeslot], for weekday: Weekday) {
        for timeslot in timeslots {
            add(timeslot, for: weekday)
        }
    }
    
    public mutating func remove(_ timeslot: Timeslot, for weekday: Weekday) {
        weekdays[weekday.index].removeObject(timeslot)
    }
    
    @discardableResult public mutating func remove(at index: Int, for weekday: Weekday) -> Timeslot {
        return weekdays[weekday.index].remove(at: index)
    }
    
    public mutating func removeAll(for weekday: Weekday? = nil) {
        for weekday in (weekday == nil ? Weekday.weekdays() : [weekday!]) {
            for timeslot in weekdays[weekday.index] {
                remove(timeslot, for: weekday)
            }
        }
    }
}

// MARK: - Equatable
extension Schedule: Equatable {}

public func == (lhs: Schedule, rhs: Schedule) -> Bool {
    return lhs.getTimeslots() == rhs.getTimeslots()
}

// MARK: - Equatable Array Extension
extension Array where Element: Equatable {
    
    public mutating func removeObject(_ object: Element) {
        guard let index = index(of: object) else { return }
        remove(at: index)
    }
}
