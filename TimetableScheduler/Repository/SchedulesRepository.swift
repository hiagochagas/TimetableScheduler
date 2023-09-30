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
        [
            .init(startTime: "7:40", endTime: "9:40"),
            .init(startTime: "10:00", endTime: "12:00"),
            .init(startTime: "13:30", endTime: "15:30"),
            .init(startTime: "15:50", endTime: "17:50")
        ]
    }
}
