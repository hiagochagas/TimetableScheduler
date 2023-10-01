//
//  Weekdays.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 27/09/23.
//

import Foundation

public enum Weekdays: Identifiable, CaseIterable {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    
    public var id: Self { self }
    
    var sectionName: String {
        switch self {
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
        }
    }
}
