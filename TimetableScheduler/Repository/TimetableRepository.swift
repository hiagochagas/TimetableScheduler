//
//  TimetableRepository.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 29/09/23.
//

import Foundation

protocol TimetableRepositing {
    func getTimetables() -> [Timetable]
    func saveTimetables(_ timetables: [Timetable])
}

final class TimetableRepository {
    var timetables: [Timetable] = []
}

extension TimetableRepository: TimetableRepositing {
    func getTimetables() -> [Timetable] {
        return timetables
    }
    
    func saveTimetables(_ timetables: [Timetable]) {
        self.timetables = timetables
    }
}
