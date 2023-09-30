//
//  Tab.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 30/09/23.
//

import Foundation

enum Tab: String, CaseIterable {
    case timetable
    case professors
    case schedule
    case disciplines
    
    var tabName: String {
        switch self {
        case .timetable:
            "Timetable"
        case .professors:
            "Professors"
        case .schedule:
            "Schedule"
        case .disciplines:
            "Disciplines"
        }
    }
    
    var unselectedImage: String {
        switch self {
        case .timetable:
            "house"
        case .professors:
            "graduationcap"
        case .schedule:
            "clock"
        case .disciplines:
            "book.closed"
        }
    }
    
    var fillImage: String {
        unselectedImage + ".fill"
    }
}
