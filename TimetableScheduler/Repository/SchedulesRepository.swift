//
//  SchedulesRepository.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 30/09/23.
//

import Foundation

protocol SchedulesRepositing {
    func fetchSchedules() -> [Schedule]
}

final class SchedulesRepository {
    
}

extension SchedulesRepository: SchedulesRepositing {
    func fetchSchedules() -> [Schedule] {
        var schedules: [Schedule] = []
        Weekdays.allCases.forEach { day in
            schedules.append(.init(dayOfTheWeek: day, startTime: "7:40", endTime: "9:40"))
            schedules.append(.init(dayOfTheWeek: day, startTime: "10:00", endTime: "12:00"))
            schedules.append(.init(dayOfTheWeek: day, startTime: "13:30", endTime: "15:30"))
            schedules.append(.init(dayOfTheWeek: day, startTime: "15:50", endTime: "17:50"))
        }
        return schedules
    }
}
